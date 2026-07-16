import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'set_password_screen.dart';
import '../ViewModel/auth_view_model.dart';
import '../Widgets/auth_header.dart';
import '../Widgets/custom_text_field.dart';
import '../Widgets/date_picker_field.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/divider_with_text.dart';
import '../Widgets/social_login_button.dart';
import '../Widgets/terms_and_conditions_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final AuthViewModel _viewModel = AuthViewModel();
  // ignore: prefer_final_fields
  bool _isLoading = false;

  void _signup() {
    if (_formKey.currentState!.validate()) {
      final userData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _mobileController.text.trim(),
        'birth_date': _dobController.text.trim(),
        'profile_image': '', // Placeholder
      };
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPasswordScreen(userData: userData),
        ),
      );
    }
  }

  void _signupWithGoogle() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Sign-In is not implemented yet.')),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
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
                  title: 'Create an account',
                  subtitle: 'Join us to get better healthcare.',
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  controller: _nameController,
                  validator: _viewModel.validateName,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _emailController,
                  validator: _viewModel.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Mobile Number',
                  hint: 'Enter your mobile number',
                  controller: _mobileController,
                  validator: _viewModel.validatePhone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                DatePickerField(
                  label: 'Date of Birth',
                  hint: 'Select your date of birth',
                  controller: _dobController,
                  validator: _viewModel.validateDateOfBirth,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: _signup,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 24),
                const DividerWithText(text: 'OR'),
                const SizedBox(height: 24),
                SocialLoginButton(
                  text: 'Continue with Google',
                  onPressed: _signupWithGoogle,
                  iconPath: 'assets/google_icon.png',
                ),
                const SizedBox(height: 32),
                const TermsAndConditionsText(),
                const SizedBox(height: 24),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575),
                      ),
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: Color(0xFF0066FF),
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
