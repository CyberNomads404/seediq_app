import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seediq_app/src/core/themes/app_colors.dart';
import 'package:seediq_app/src/core/themes/app_text.dart';
import 'package:seediq_app/src/core/widgets/image_picker_button.dart';
import 'package:seediq_app/src/data/services/services_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? _selectedGrainType = 'Soja';
  File? _capturedImage;

  final List<String> _grainTypes = [
    'Soja',
    'Milho',
    'Trigo',
    'Feijão',
    'Arroz',
  ];

  Future<void> _captureImage() async {
    try {
      final cameraService = ref.read(cameraServiceProvider);
      final image = await cameraService.captureImageFromCamera();

      if (image != null) {
        setState(() {
          _capturedImage = image;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao capturar imagem: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayLight,
      body: SafeArea(
        child: SingleChildScrollView(
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

              // Subtítulo
              Text(
                'Inicie o processo de classificação',
                style: AppText.body.copyWith(
                  fontSize: 15,
                  color: AppColors.grayMedium,
                ),
              ),
              const SizedBox(height: 32),

              // Container da imagem com botão de câmera
              ImagePickerButton(
                image: _capturedImage,
                onTap: _captureImage,
                height: 280,
                borderRadius: 20,
              ),
              const SizedBox(height: 32),

              // Label do dropdown
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

              // Dropdown de tipo de grão
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
                  value: _selectedGrainType,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: InputBorder.none,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.grayMedium,
                  ),
                  style: AppText.medium.copyWith(fontSize: 15),
                  items: _grainTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGrainType = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Botão "Iniciar Análise"
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _capturedImage == null
                      ? null
                      : () {
                          // TODO: Implementar lógica de iniciar análise
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Iniciando análise de $_selectedGrainType',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
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
