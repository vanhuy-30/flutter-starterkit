import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';

class CustomTabbar extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const CustomTabbar({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: tabs,
      indicatorColor: AppColors.primaryColor,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.grey,
    );
  }
}
