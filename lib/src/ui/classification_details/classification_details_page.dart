import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        ref.read(classificationDetailsViewModelProvider.notifier).fetchClassificationDetails(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Classificação'),
      ),
      body: const Center(
        child: Text('Carregando detalhes...'),
      ),
    );
  }
}
