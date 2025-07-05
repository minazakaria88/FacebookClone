import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({
    super.key,
    required this.width,
    required this.height,
    required this.margin,
    this.shape,
  });
  final double width;
  final double height;
  final double margin;
  final BoxShape?  shape;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(margin),
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(10),
          color: Colors.grey.shade300,
        ),
      ),
    );

  }
}