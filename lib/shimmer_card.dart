import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
final double width;
final double height;

const ShimmerCard({
super.key,
required this.width,
required this.height,
});

@override
Widget build(BuildContext context) {
return Shimmer.fromColors(
baseColor: Colors.red[100]!,
highlightColor: Colors.yellow[100]!,
child: Container(
width: width,
height: height,
margin: const EdgeInsets.only(left: 16, right: 8),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
),
),
);
}
}
