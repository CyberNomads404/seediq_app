import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seediq_app/src/core/themes/app_colors.dart';

class ImagePickerButton extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final double height;
  final double borderRadius;

  const ImagePickerButton({
    super.key,
    required this.image,
    required this.onTap,
    this.height = 280,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.beige,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: AppColors.blue,
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius - 3),
          child: Stack(
            children: [
              if (image != null)
                Image.file(
                  image!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              else
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

              if (image != null)
                Container(
                  color: Colors.black.withOpacity(0.1),
                ),

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
                  child: Icon(
                    image == null ? Icons.camera_alt_outlined : Icons.edit,
                    size: 40,
                    color: AppColors.grayMedium,
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
