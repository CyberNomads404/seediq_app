import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seediq_app/src/core/themes/app_colors.dart';
import 'package:seediq_app/src/core/themes/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seediq_app/src/ui/tabs/screens/history/history_view_page.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyViewModelProvider.notifier).fetchClassifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyViewModelProvider);
    final viewModel = ref.read(historyViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.grayLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Text(
                    'Análises Recentes',
                    style: AppText.large,
                  ),
                  const Spacer(),
                ],
              ),
            ),

            const Divider(height: 1),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => viewModel.fetchClassifications(),
                child: Builder(
                  builder: (context) {
                    final list = state.classifications;

                    if (state.isLoading && (list == null || list.isEmpty)) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (list == null || list.isEmpty) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12,
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.history,
                                  size: 72,
                                  color: AppColors.grayMedium,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Nenhuma análise encontrada',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grayMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = list[index];
                        final category = item.categoryForDisplay;
                        final status = item.status;
                        final statusLabel = item.statusLabel.toUpperCase();
                        final statusColor = _statusColor(status);

                        return Material(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/classification_details',
                                arguments: item.externalId,
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 92,
                                    height: 92,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: 92,
                                          height: 92,
                                          decoration: BoxDecoration(
                                            color: AppColors.beige,
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            child: Builder(
                                              builder: (_) {
                                                final fileUrl = item.fileUrl;
                                                if (fileUrl.isEmpty) {
                                                  return const Center(
                                                    child: Icon(
                                                      Icons.photo,
                                                      color:
                                                          AppColors.grayMedium,
                                                      size: 28,
                                                    ),
                                                  );
                                                }

                                                return Image.network(
                                                  fileUrl,
                                                  width: 92,
                                                  height: 92,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      const Center(
                                                        child: Icon(
                                                          Icons.photo,
                                                          color: AppColors
                                                              .grayMedium,
                                                          size: 28,
                                                        ),
                                                      ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),

                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Transform.translate(
                                              offset: const Offset(36, -10),
                                              child: Container(
                                                width: 36,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.08),
                                                      blurRadius: 4,
                                                      offset: const Offset(
                                                        0,
                                                        2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: ClipOval(
                                                  child: Builder(
                                                    builder: (_) {
                                                      final iconUrl =
                                                          category.iconUrl;
                                                      if (iconUrl == null ||
                                                          iconUrl.isEmpty) {
                                                        return const Center(
                                                          child: Icon(
                                                            Icons.image,
                                                            size: 16,
                                                            color: AppColors
                                                                .grayMedium,
                                                          ),
                                                        );
                                                      }

                                                      final lowered = iconUrl
                                                          .toLowerCase();
                                                      if (lowered.endsWith(
                                                            '.svg',
                                                          ) ||
                                                          lowered.contains(
                                                            '.svg?',
                                                          ) ||
                                                          lowered.contains(
                                                            'image/svg',
                                                          )) {
                                                        return SvgPicture.network(
                                                          iconUrl,
                                                          fit: BoxFit.cover,
                                                          placeholderBuilder:
                                                              (
                                                                context,
                                                              ) => const Center(
                                                                child: SizedBox(
                                                                  width: 16,
                                                                  height: 16,
                                                                  child: CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        1.5,
                                                                  ),
                                                                ),
                                                              ),
                                                        );
                                                      }

                                                      return Image.network(
                                                        iconUrl,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              _,
                                                              __,
                                                              ___,
                                                            ) => const Center(
                                                              child: Icon(
                                                                Icons.image,
                                                                size: 16,
                                                                color: AppColors
                                                                    .grayMedium,
                                                              ),
                                                            ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.navy,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item.createdAtHuman,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.grayMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      statusLabel,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'registered':
        return AppColors.beige.withOpacity(1);
      case 'in_progress':
        return AppColors.yellow;
      case 'completed':
        return AppColors.greenDark;
      case 'failed':
        return Colors.red;
      case 'canceled':
        return AppColors.grayMedium;
      default:
        return AppColors.grayMedium;
    }
  }
}
