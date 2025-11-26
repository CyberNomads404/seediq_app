import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seediq_app/src/core/constants/classification_status_types.dart';
import 'package:seediq_app/src/core/helpers/date_formatter_helper.dart';
import 'package:seediq_app/src/core/themes/app_colors.dart';
import 'package:seediq_app/src/core/themes/app_text.dart';
import 'package:seediq_app/src/data/models/classification_model.dart';
import 'package:seediq_app/src/ui/classification_details/classification_details_view_model.dart';

class ClassificationDetailsPage extends ConsumerStatefulWidget {
  final String? externalId;

  const ClassificationDetailsPage({super.key, this.externalId});

  @override
  ConsumerState<ClassificationDetailsPage> createState() =>
      _ClassificationDetailsPageState();
}

class _ClassificationDetailsPageState
    extends ConsumerState<ClassificationDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = widget.externalId;
      if (id != null && id.isNotEmpty) {
        ref
            .read(classificationDetailsViewModelProvider.notifier)
            .fetchClassificationDetails(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(classificationDetailsViewModelProvider);
    final classification = state.classification;

    return Scaffold(
      backgroundColor: AppColors.grayLight,
      appBar: AppBar(
        title: const Text('Resultado da Classificação'),
        backgroundColor: AppColors.greenDark,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
              ? _buildErrorState(state.errorMessage!)
              : classification == null
                  ? const Center(child: Text('Nenhum dado encontrado'))
                  : _buildContent(classification),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar os detalhes',
              style: AppText.large,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: AppText.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final id = widget.externalId;
                if (id != null && id.isNotEmpty) {
                  ref
                      .read(classificationDetailsViewModelProvider.notifier)
                      .fetchClassificationDetails(id);
                }
              },
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ClassificationModel classification) {
    final isCompleted =
        classification.status == ClassificationStatusTypes.completed;
    final isFailed = classification.status == ClassificationStatusTypes.failed;
    final isProcessing = !isCompleted && !isFailed;

    if (isProcessing) {
      return _buildProcessingState(classification);
    }

    if (isFailed) {
      return _buildFailedState(classification);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(classification),
          const SizedBox(height: 16),
          _buildResultsSection(classification),
          const SizedBox(height: 16),
          _buildSummarySection(classification),
          const SizedBox(height: 24),
          _buildReanalysisButton(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProcessingState(ClassificationModel classification) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              'Processando análise...',
              style: AppText.large,
            ),
            const SizedBox(height: 8),
            Text(
              classification.statusLabel,
              style: AppText.body,
              textAlign: TextAlign.center,
            ),
            if (classification.message != null) ...[
              const SizedBox(height: 8),
              Text(
                classification.message!,
                style: AppText.small,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFailedState(ClassificationModel classification) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber_rounded,
                size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            Text(
              'Análise Falhou',
              style: AppText.large,
            ),
            const SizedBox(height: 8),
            Text(
              classification.message ?? 'Ocorreu um erro durante a análise',
              style: AppText.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _handleReanalysis(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reavaliar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ClassificationModel classification) {
    final category = classification.categoryForDisplay;

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              classification.fileUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  color: AppColors.grayLight,
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 64),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (category.iconUrl != null && category.iconUrl!.isNotEmpty)
                Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.grayLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildCategoryIcon(category.iconUrl!),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Classificação - ${category.name}',
                      style: AppText.large,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Criado em: ${DateFormatterHelper.formatDateTime(classification.createdAt)}',
                      style: AppText.small.copyWith(
                        color: AppColors.grayMedium,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      classification.createdAtHuman,
                      style: AppText.small.copyWith(
                        color: AppColors.grayMedium,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(String iconUrl) {
    final lowered = iconUrl.toLowerCase();
    
    if (lowered.endsWith('.svg') ||
        lowered.contains('.svg?') ||
        lowered.contains('image/svg')) {
      return SvgPicture.network(
        iconUrl,
        fit: BoxFit.cover,
        placeholderBuilder: (context) => const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return Image.network(
      iconUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(
          Icons.category,
          color: AppColors.grayMedium,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildResultsSection(ClassificationModel classification) {
    final result = classification.result;
    if (result == null) return const SizedBox.shrink();

    final total = (result.good ?? 0) +
        (result.small ?? 0) +
        (result.greenish ?? 0) +
        (result.burned ?? 0) +
        (result.badDetection ?? 0) +
        (result.unknown ?? 0);

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart, size: 20),
              const SizedBox(width: 8),
              Text('Resultados da Análise', style: AppText.medium),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildResultCard(
                'Grãos Bons',
                result.good ?? 0,
                total,
                Colors.green.shade50,
                Colors.green.shade700,
                Icons.check_circle_outline,
              ),
              _buildResultCard(
                'Grãos Pequenos',
                result.small ?? 0,
                total,
                Colors.amber.shade50,
                Colors.amber.shade700,
                Icons.grain,
              ),
              _buildResultCard(
                'Grãos Esverdeados',
                result.greenish ?? 0,
                total,
                Colors.green.shade50,
                Colors.green.shade900,
                Icons.eco,
              ),
              _buildResultCard(
                'Má Detecção',
                result.badDetection ?? 0,
                total,
                Colors.orange.shade50,
                Colors.orange.shade700,
                Icons.warning_amber,
              ),
              _buildResultCard(
                'Grãos Queimados',
                result.burned ?? 0,
                total,
                Colors.red.shade50,
                Colors.red.shade700,
                Icons.local_fire_department,
              ),
              _buildResultCard(
                'Grãos Desconhecidos',
                result.unknown ?? 0,
                total,
                Colors.grey.shade100,
                Colors.grey.shade700,
                Icons.help_outline,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(
    String label,
    num value,
    num total,
    Color bgColor,
    Color textColor,
    IconData icon,
  ) {
    final percentage = total > 0 ? (value / total * 100) : 0;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: AppText.small.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                '(${percentage.toStringAsFixed(1)}%)',
                style: AppText.small.copyWith(color: textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(ClassificationModel classification) {
    final result = classification.result;
    if (result == null) return const SizedBox.shrink();

    final total = (result.good ?? 0) +
        (result.small ?? 0) +
        (result.greenish ?? 0) +
        (result.burned ?? 0) +
        (result.badDetection ?? 0) +
        (result.unknown ?? 0);

    final goodQuality = total > 0 ? (result.good ?? 0) / total * 100 : 0;
    final needsAttention = total > 0 ? (result.small ?? 0) / total * 100 : 0;
    final problems = total > 0
        ? ((result.burned ?? 0) + (result.badDetection ?? 0)) / total * 100
        : 0;

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Resumo da Análise', style: AppText.medium),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  '$total',
                  'Total de Grãos',
                  AppColors.navy,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  '${goodQuality.toStringAsFixed(1)}%',
                  'Qualidade Boa',
                  Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  '${needsAttention.toStringAsFixed(1)}%',
                  'Necessita Atenção',
                  Colors.amber.shade700,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  '${problems.toStringAsFixed(1)}%',
                  'Problemas',
                  Colors.red.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppText.small,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildReanalysisButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _handleReanalysis(),
          icon: const Icon(Icons.refresh),
          label: const Text('Solicitar Reavaliação'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  void _handleReanalysis() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Solicitar Reavaliação'),
        content: const Text(
          'Deseja realmente solicitar uma nova análise desta classificação?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(classificationDetailsViewModelProvider.notifier)
                 .reanalyzeClassification(widget.externalId!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Solicitação de reavaliação enviada!'),
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}