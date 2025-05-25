import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'register.dart';
import 'forget_password.dart';

void main() {
  runApp(const SettleUpApp());
}

class SettleUpApp extends StatelessWidget {
  const SettleUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B3D2E),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Green background area
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Username Or Email",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0B3D2E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          hintText: "example@example.com",
                          obscureText: false,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0B3D2E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPasswordField(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Log In button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login logic
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF004D40,
                      ), // Darker green for better contrast
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            Colors
                                .white, // Explicitly set to white for visibility
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Forgot Password
                  GestureDetector(
                    onTap: () {
                      // Handle forgot password
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xFF0B3D2E), fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign Up button
                  ElevatedButton(
                    onPressed: () {
                      // Handle sign up
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF6D9B0),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0B3D2E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Fingerprint section
                  const Text(
                    "Use Fingerprint To Access",
                    style: TextStyle(fontSize: 14, color: Color(0xFF0B3D2E)),
                  ),

                  const SizedBox(height: 24),

                  // Or sign up with
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 0.5),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "or sign up with",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 0.5),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Social buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        icon: Icons.facebook,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      _buildSocialButton(
                        icon: Icons.g_mobiledata,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Don't have an account
                  GestureDetector(
                    onTap: () {
                      // Navigate to registration/signup page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: const Color(0xFFF6D9B0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: "••••••••",
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: const Color(0xFFF6D9B0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[600],
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Icon(icon, color: const Color(0xFF0B3D2E)),
      ),
    );
  }
}
