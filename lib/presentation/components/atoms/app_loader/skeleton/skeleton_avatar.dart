import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/app_loader/skeleton/skeleton_loader.dart';

class SkeletonAvatar extends StatelessWidget {
  final double size;

  const SkeletonAvatar({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}
