import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'feed_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

enum _VerifyState { idle, verifying, success, error }

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  _VerifyState _state = _VerifyState.idle;
  int _secondsLeft = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _secondsLeft = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _resend() {
    if (_secondsLeft > 0) return;
    for (final c in _controllers) {
      c.clear();
    }
    setState(() => _state = _VerifyState.idle);
    _startCountdown();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent successfully'), duration: Duration(seconds: 2)),
    );
  }

  String get _enteredOtp => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_enteredOtp.length == 4) {
      _verify();
    }
  }

  void _verify() {
    setState(() => _state = _VerifyState.verifying);
    FocusScope.of(context).unfocus();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      // Mock validation: any 4-digit code is accepted, "0000" simulates error.
      if (_enteredOtp == '0000') {
        setState(() => _state = _VerifyState.error);
      } else {
        setState(() => _state = _VerifyState.success);
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (_, animation, __) => FadeTransition(
                opacity: animation,
                child: const FeedScreen(),
              ),
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text('Verify your number', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 26)),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  style: const TextStyle(color: AppColors.subtitle, fontSize: 14, height: 1.4),
                  children: [
                    const TextSpan(text: 'We sent a 4-digit code to '),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (i) => _otpBox(i)),
              ),
              const SizedBox(height: 16),
              if (_state == _VerifyState.error)
                const Text(
                  'Incorrect OTP. Please try again.',
                  style: TextStyle(color: AppColors.accent, fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              if (_state == _VerifyState.success)
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 18),
                    SizedBox(width: 6),
                    Text('Verified! Redirecting...',
                        style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 12.5)),
                  ],
                ),
              const SizedBox(height: 28),
              Center(
                child: _secondsLeft > 0
                    ? Text(
                        'Resend OTP in 00:${_secondsLeft.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: AppColors.subtitle, fontSize: 13),
                      )
                    : GestureDetector(
                        onTap: _resend,
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(
                              color: AppColors.accent, fontSize: 13.5, fontWeight: FontWeight.w700),
                        ),
                      ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Verify & Continue',
                loading: _state == _VerifyState.verifying,
                onPressed: _enteredOtp.length == 4 ? _verify : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    final hasError = _state == _VerifyState.error;
    return SizedBox(
      width: 64,
      height: 64,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: hasError ? AppColors.accent : AppColors.divider, width: 1.4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: hasError ? AppColors.accent : AppColors.divider, width: 1.4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.ink, width: 1.8),
          ),
        ),
        onChanged: (v) => _onDigitChanged(index, v),
      ),
    );
  }
}
