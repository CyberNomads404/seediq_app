import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seediq_app/src/core/themes/app_colors.dart';
import 'package:seediq_app/src/core/themes/app_text.dart';
import 'package:seediq_app/src/core/widgets/image_picker_button.dart';
import 'package:seediq_app/src/ui/tabs/screens/home/home_state.dart';
import 'package:seediq_app/src/ui/tabs/screens/home/home_view_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _handleSubmit(BuildContext context, WidgetRef ref, HomeState state) {
    if (state.capturedImage == null) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Por favor, capture uma imagem antes de iniciar a análise.',
        ),
      );
      return;
    }

    if (state.selectedCategory == null) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Por favor, selecione um tipo de grão.',
        ),
      );
      return;
    }

    ref.read(homeViewModelProvider.notifier).submitClassification();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    ref.listen<HomeState>(homeViewModelProvider, (previous, next) {
      if (next.errorMessage != null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: next.errorMessage!,
          ),
        );
        Future.microtask(
          () => ref.read(homeViewModelProvider.notifier).clearError(),
        );
      }

      if (next.successMessage != null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: next.successMessage!,
          ),
        );
        Future.microtask(
          () => ref.read(homeViewModelProvider.notifier).clearSuccess(),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.grayLight,
      body: SafeArea(
        child: state.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.greenDark,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Título
                    const Text(
                      'Nova Análise',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Inicie o processo de classificação',
                      style: AppText.body.copyWith(
                        fontSize: 15,
                        color: AppColors.grayMedium,
                      ),
                    ),
                    const SizedBox(height: 32),

                    ImagePickerButton(
                      image: state.capturedImage,
                      onTap: () => ref
                          .read(homeViewModelProvider.notifier)
                          .captureImage(),
                      height: 280,
                      borderRadius: 20,
                    ),
                    const SizedBox(height: 32),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tipo de grão',
                        style: AppText.body.copyWith(
                          fontSize: 13,
                          color: AppColors.grayMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: state.selectedCategory?.externalId,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: InputBorder.none,
                        ),
                        hint: const Text('Selecione um tipo de grão'),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.grayMedium,
                        ),
                        style: AppText.medium.copyWith(fontSize: 15),
                        items: state.categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.externalId,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            final category = state.categories.firstWhere(
                              (cat) => cat.externalId == value,
                            );
                            ref
                                .read(homeViewModelProvider.notifier)
                                .selectCategory(category);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () => _handleSubmit(context, ref, state),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greenDark,
                          disabledBackgroundColor: AppColors.greenDark
                              .withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: state.isSubmitting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Iniciar Análise',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
