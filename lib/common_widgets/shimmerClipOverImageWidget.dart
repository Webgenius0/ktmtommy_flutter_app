import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class shimmerClipOvalWidget extends StatelessWidget {
  const shimmerClipOvalWidget({
    super.key, this.networkImageLink, this.height, this.weight,
  });
  final String? networkImageLink;
  final double? height;
  final double? weight;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        height: height??50,
        width: weight??50,
        child: Image.network(
          networkImageLink??"",
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                color: Colors.grey.shade300,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}