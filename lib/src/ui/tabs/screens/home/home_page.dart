import 'package:flutter/material.dart';
import 'package:seediq_app/src/core/themes/app_colors.dart';
import 'package:seediq_app/src/core/themes/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedGrainType = 'Soja';

  final List<String> _grainTypes = [
    'Soja',
    'Milho',
    'Trigo',
    'Feijão',
    'Arroz',
  ];

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
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  color: AppColors.beige,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.blue,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Stack(
                    children: [
                      // Placeholder de imagem (simulando grãos de soja)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.yellow.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.grid_view_rounded,
                            size: 80,
                            color: AppColors.yellow.withOpacity(0.5),
                          ),
                        ),
                      ),

                      // Botão de câmera centralizado
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: AppColors.grayMedium,
                            ),
                            onPressed: () {
                              // TODO: Implementar captura de imagem
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Capturar imagem'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  onPressed: () {
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
