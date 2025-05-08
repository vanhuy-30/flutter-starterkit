import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/app_loader/skeleton/skeleton_avatar.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/app_loader/skeleton/skeleton_loader.dart';


class SkeletonListItem extends StatelessWidget {
  const SkeletonListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SkeletonAvatar(),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoader(width: double.infinity, height: 14),
              SizedBox(height: 8),
              SkeletonLoader(width: 100, height: 14),
            ],
          ),
        )
      ],
    );
  }
}
