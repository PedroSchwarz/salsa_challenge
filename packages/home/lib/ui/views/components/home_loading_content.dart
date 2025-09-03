import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeLoadingContent extends StatelessWidget {
  const HomeLoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      padding: const EdgeInsets.all(AppSpacing.md),
      itemBuilder: (context, index) {
        return const AppSkeleton(isLoading: true, child: SizedBox(height: 300, width: double.infinity));
      },
      separatorBuilder: (context, index) {
        return const Gap(AppSpacing.md);
      },
    );
  }
}
