import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';



class MyShimmer extends StatelessWidget {
  const MyShimmer({super.key, required this.height, this.edgeInsetsMargin,});
  final double height;
  final EdgeInsets? edgeInsetsMargin;

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      // baseColor: context.theme.colorScheme.primaryContainer,
      baseColor: Colors.grey.shade300,
      // highlightColor: context.theme.unselectedWidgetColor,
      highlightColor: Colors.white,
      child: Container(
        height: height,
        margin: edgeInsetsMargin,
        decoration: BoxDecoration(
            color: context.theme.colorScheme.primaryContainer,
            // color: Colors.grey[300]!,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}