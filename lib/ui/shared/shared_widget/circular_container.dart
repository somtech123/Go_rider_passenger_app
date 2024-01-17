import 'package:flutter/material.dart';

class CircularContainerWidget extends StatelessWidget {
  const CircularContainerWidget({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.borderRaduis = 20,
  });

  final double? width;
  final double? height;
  final double borderRaduis;
  final Color? color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(borderRaduis)),
      child: child,
    );
  }
}
