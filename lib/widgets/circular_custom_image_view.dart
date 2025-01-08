import 'package:flutter/material.dart';

class CircularCustomImageView extends StatelessWidget {
  final String imagePath;
  final double size;
  final BorderRadius? borderRadius;

  const CircularCustomImageView({
    super.key,
    required this.imagePath,
    this.size = 100.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.grey,
          BlendMode.saturation,
        ),
        child: ClipOval(
          child: Image.network(
            imagePath,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
