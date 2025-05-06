import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/app_loader/skeleton/skeleton_loader.dart';

class SkeletonCard extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonCard({super.key, this.height = 120, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
