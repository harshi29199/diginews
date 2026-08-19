import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  String _countryCode = '+91';
  String? _errorText;
  bool _loading = false;

  final _countryCodes = const ['+91', '+1', '+44', '+61', '+971'];

  void _handleContinue() {
    final phone = _phoneController.text.trim();
    setState(() {
      if (phone.isEmpty) {
        _errorText = 'Please enter your phone number';
      } else if (phone.length < 10) {
        _errorText = 'Enter a valid 10-digit phone number';
      } else {
        _errorText = null;
      }
    });

    if (_errorText != null) return;

    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() => _loading = false);
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (_, animation, __) => FadeTransition(
            opacity: animation,
            child: OtpScreen(
              phoneNumber: '$_countryCode ${_phoneController.text.trim()}',
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Masthead-style logo
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.ink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.newspaper, color: AppColors.paper, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Text('THE DAILY WIRE', style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 48),
              Text('Welcome back', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28)),
              const SizedBox(height: 8),
              const Text(
                'Enter your phone number to log in or create a new account.',
                style: TextStyle(color: AppColors.subtitle, fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 32),
              Text('Phone Number', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _countryCode,
                        items: _countryCodes
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: (v) => setState(() => _countryCode = v ?? _countryCode),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: '98765 43210',
                        counterText: '',
                        errorText: _errorText,
                      ),
                      onChanged: (_) {
                        if (_errorText != null) setState(() => _errorText = null);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              PrimaryButton(label: 'Continue', onPressed: _handleContinue, loading: _loading),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11.5, color: AppColors.subtitle, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
