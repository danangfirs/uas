import 'package:flutter/material.dart';

import '../styles/text_styles.dart';
import '../widgets/coffee_logo.dart';

const double _contentMaxWidth = 420;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const String routeName = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController(text: 'Roberto Karlos');
  final TextEditingController _emailController = TextEditingController(text: 'example@gmail.com');
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CoffeeLogo(),
                      const SizedBox(width: 12),
                      const Text(
                        'Ombe',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                    style: TextStyle(
                      fontSize: 16,
                      color: subtitleColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: subtitleColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    cursorColor: primaryGreen,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Roberto Karlos',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(bottom: 12),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGray, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGray, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen, width: 1.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: subtitleColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    cursorColor: primaryGreen,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'example@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(bottom: 12),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGray, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGray, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen, width: 1.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: subtitleColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    cursorColor: primaryGreen,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.only(bottom: 12),
                      suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: primaryGreen,
                          size: 22,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                        padding: EdgeInsets.zero,
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGray, width: 1),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGray, width: 1),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryGreen, width: 1.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 66,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5E5E5),
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: subtitleColor,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(text: 'By tapping Sign up you accept all our '),
                          TextSpan(
                            text: 'terms',
                            style: const TextStyle(
                              color: primaryGreen,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: primaryGreen,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'condition',
                            style: const TextStyle(
                              color: primaryGreen,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

