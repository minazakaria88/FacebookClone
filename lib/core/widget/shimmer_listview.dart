import 'package:app_factory/core/widget/shimmer_item.dart';
import 'package:flutter/material.dart';

class ShimmerListview extends StatelessWidget {
  const ShimmerListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) =>
          const ShimmerItem(height: 150, width: double.infinity, margin: 12),
    );
  }
}

class ShimmerCircleListview extends StatelessWidget {
  const ShimmerCircleListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const ShimmerItem(
          height: 120,
          width: 120,
          margin: 12,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
