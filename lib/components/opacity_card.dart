import 'package:flutter/material.dart';

class OpacityCards extends StatelessWidget {
  const OpacityCards({
    super.key,
    required this.image,
    this.onTap,
  });
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: 0.60,
        child: Container(
          width: 45,
          height: 45,
          decoration: ShapeDecoration(
            color: const Color(0xFF2A2E2E),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Center(
            child: Image.asset(image),
          ),
        ),
      ),
    );
  }
}
