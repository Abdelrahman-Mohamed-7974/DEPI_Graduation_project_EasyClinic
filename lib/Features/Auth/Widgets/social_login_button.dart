import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String iconPath;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Typically an SVG or PNG asset
          // Using a placeholder Icon if iconPath is not specified or for simplicity
          const Icon(
            Icons.g_mobiledata,
            size: 28,
            color: Colors.blue,
          ), // Replace with actual Google Logo if needed
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
