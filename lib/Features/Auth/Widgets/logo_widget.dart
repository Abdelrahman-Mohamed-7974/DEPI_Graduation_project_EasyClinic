import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;

  const LogoWidget({
    super.key,
    required this.assetPath,
    this.width = 150,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.local_hospital,
          size: width,
          color: Theme.of(context).primaryColor,
        );
      },
    );
  }
}
