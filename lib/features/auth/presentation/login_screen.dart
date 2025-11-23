import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                "login".tr(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const LoginForm(),
              const Spacer(),
              _buildLanguageSelector(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _langButton(context, "EN", const Locale('en')),
        const SizedBox(width: 12),
        _langButton(context, "RU", const Locale('ru')),
        const SizedBox(width: 12),
        _langButton(context, "KZ", const Locale('kk')),
      ],
    );
  }

  Widget _langButton(BuildContext context, String label, Locale locale) {
    return GestureDetector(
      onTap: () async {
        await context.setLocale(locale);
        (context as Element).reassemble(); // Force rebuild on Windows desktop
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label),
      ),
    );
  }
}
