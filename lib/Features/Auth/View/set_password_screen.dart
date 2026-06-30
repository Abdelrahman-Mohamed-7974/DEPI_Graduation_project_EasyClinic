import 'package:flutter/material.dart';
import '../ViewModel/auth_view_model.dart';
import '../Widgets/auth_header.dart';
import '../Widgets/password_text_field.dart';
import '../Widgets/custom_button.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthViewModel _viewModel = AuthViewModel();
  bool _isLoading = false;

  void _savePassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          // Navigate to Home or Login
        }
      });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(
                  title: 'Set Password',
                  subtitle: 'Create a secure password for your account.',
                ),
                const SizedBox(height: 32),
                PasswordTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  validator: _viewModel.validatePassword,
                ),
                const SizedBox(height: 16),
                PasswordTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  validator: (val) => _viewModel.validateConfirmPassword(
                    val,
                    _passwordController.text,
                  ),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Save Password',
                  onPressed: _savePassword,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
