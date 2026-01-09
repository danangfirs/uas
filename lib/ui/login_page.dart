import 'package:flutter/material.dart';

import '../styles/text_styles.dart';
import '../widgets/coffee_logo.dart';
import '../services/api_service.dart';
import 'signup_page.dart';
import 'homepage.dart';

const double _contentMaxWidth = 420;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(text: 'admin@ombe.com');
  final TextEditingController _passwordController = TextEditingController(text: 'password');
  bool _obscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiService.login(
        email: email,
        password: password,
      );

      setState(() => _isLoading = false);

      if (!mounted) return;

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error ?? 'Login gagal'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  // Logo + Brand
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
                  // Sign In Title
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Description text
                  const Text(
                    'Masuk untuk melanjutkan pemesanan kopi favoritmu',
                    style: TextStyle(
                      fontSize: 16,
                      color: subtitleColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Email Field
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
                      hintText: 'admin@ombe.com',
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
                  // Password Field
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
                  // LOGIN Button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        disabledBackgroundColor: Colors.grey[400],
                      ),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                letterSpacing: 0.6,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 16,
                          color: subtitleColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: primaryGreen,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  // Don't have account text
                  const Center(
                    child: Text(
                      "Dont have any account?",
                      style: TextStyle(
                        fontSize: 16,
                        color: subtitleColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // CREATE AN ACCOUNT Button
                  SizedBox(
                    width: double.infinity,
                    height: 66,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed(SignUpPage.routeName),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: beige,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'CREATE AN ACCOUNT',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 0.6,
                        ),
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
