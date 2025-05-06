import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/app_loader/skeleton/skeleton_loader.dart';

class SkeletonGridItem extends StatelessWidget {
  const SkeletonGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoader(width: double.infinity, height: 100),
        SizedBox(height: 8),
        SkeletonLoader(width: 80, height: 14),
      ],
    );
  }
}
