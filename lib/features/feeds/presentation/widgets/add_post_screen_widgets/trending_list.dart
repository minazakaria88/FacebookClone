import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trend.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.all(5),
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.greyColor,
          ),
          child: Center(
            child: Text(
              trend[index],
              style: AppStyles.bold18BlackTextColor.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> trend = ['#art', '#design', '#digitalart', '#illustration'];