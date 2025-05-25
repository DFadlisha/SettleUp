import 'package:flutter/material.dart';
import 'login.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5FFF5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Color(0xFF0A4642),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Forgot Password Header
              const Center(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A4642),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Reset Password Container
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5FFF5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reset Password?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Enter Email Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Email TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'example@example.com',
                        hintStyle: TextStyle(
                          color: Colors.grey.withAlpha(179), // 0.7 * 255 ≈ 179
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    // Next Step Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A4642),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Next Step',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Sign Up Section
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFCDEC0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'or sign up with',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  // Social Media Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton(Icons.facebook),
                      const SizedBox(width: 16),
                      _socialButton(Icons.g_mobiledata, size: 34),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Don't have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFCDEC0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, {double size = 24}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12),
      ),
      child: Center(child: Icon(icon, size: size, color: Colors.black87)),
    );
  }
}

// How to use this screen:
// Add this to your main.dart or navigation:
//
// void main() {
//   runApp(MaterialApp(
//     home: ForgotPasswordScreen(),
//     theme: ThemeData(
//       fontFamily: 'Poppins', // Use your preferred font
//     ),
//   ));
// }
