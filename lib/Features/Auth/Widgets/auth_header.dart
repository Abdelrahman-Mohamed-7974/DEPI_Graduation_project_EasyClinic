import 'package:flutter/material.dart';
import 'auth_title.dart';
import 'back_button_widget.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBackButton) const BackButtonWidget(),
        if (showBackButton) const SizedBox(height: 24),
        AuthTitle(title: title, subtitle: subtitle),
      ],
    );
  }
}
