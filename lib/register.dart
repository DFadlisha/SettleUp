import 'package:flutter/material.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F3F33),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F7F0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInputField(
                            label: 'Full Name',
                            controller: _fullNameController,
                            hintText:
                                'example@example.com', // This seems wrong in the design
                          ),
                          _buildInputField(
                            label: 'Email',
                            controller: _emailController,
                            hintText: 'example@example.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          _buildInputField(
                            label: 'Mobile Number',
                            controller: _mobileNumberController,
                            hintText: '+ 123 456 789',
                            keyboardType: TextInputType.phone,
                          ),
                          _buildInputField(
                            label: 'Date Of Birth',
                            controller: _dateOfBirthController,
                            hintText: 'DD / MM / YYY',
                            onTap: () => _selectDate(context),
                            readOnly: true,
                          ),
                          _buildPasswordField(
                            label: 'Password',
                            controller: _passwordController,
                            isVisible: _isPasswordVisible,
                            toggleVisibility: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          _buildPasswordField(
                            label: 'Confirm Password',
                            controller: _confirmPasswordController,
                            isVisible: _isConfirmPasswordVisible,
                            toggleVisibility: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'By continuing, you agree to ',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Terms of Use',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          ' and ',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          '.',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _signUp(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F3F33),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to login page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: Color(0xFF0F3F33),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFADFBC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            enableInteractiveSelection: true,
            autofocus: false,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFADFBC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            obscureText: !isVisible,
            keyboardType: TextInputType.visiblePassword,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black54,
                ),
                onPressed: toggleVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            "${picked.day.toString().padLeft(2, '0')} / "
            "${picked.month.toString().padLeft(2, '0')} / "
            "${picked.year}";
      });
    }
  }

  void _signUp() {
    // Implement sign up logic
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _mobileNumberController.text.isEmpty ||
        _dateOfBirthController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // Proceed with registration
    // ignore: avoid_print
    print('Registration successful');
    // Navigate to the next screen or show success message
  }
}

// Instead of creating a placeholder class, we'll import the actual login page
// and use it directly in the navigation code.
