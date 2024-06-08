import 'package:ebook_app/components/single_tab.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class HomeTabs extends StatelessWidget {
  final TabController tabController;

  const HomeTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.sliverBackground,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: TabBar(
            indicatorPadding: const EdgeInsets.all(0),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.all(0),
            dividerHeight: 0,
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            tabs: const [
              SingleTab(text: 'New', color: AppColors.menu1Color),
              SingleTab(text: 'Popular', color: AppColors.menu2Color),
              SingleTab(text: 'Trending', color: AppColors.menu3Color),
            ],
          ),
        ),
      ),
    );
  }
}
