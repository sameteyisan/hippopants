import 'package:flutter/material.dart';
import 'package:hippopants/utils/theme.dart';

class CustomCircleIconButton extends StatelessWidget {
  final Function()? onTap;
  final Color backgroundColor;
  final double size;
  final Widget icon;

  const CustomCircleIconButton({
    super.key,
    this.onTap,
    this.backgroundColor = CColors.foregroundColor,
    this.size = 32,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: icon,
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final Color backgroundColor;
  final double size;
  final double radius;
  final Widget icon;

  const CustomIconButton({
    super.key,
    this.onTap,
    this.backgroundColor = CColors.foregroundColor,
    this.size = 40,
    this.radius = 12,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.hardEdge,
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
