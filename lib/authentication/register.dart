import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateOfBirthController.text = DateFormat(
          'dd / MM / yyyy',
        ).format(_selectedDate!);
      });
    }
  }

  bool _isValidPhoneNumber(String phone) {
    final phoneRegExp = RegExp(r'^\+?\d{7,15}$');
    return phoneRegExp.hasMatch(phone);
  }

  bool _isValidDate(String date) {
    try {
      final parts = date.split(' / ');
      if (parts.length != 3) return false;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final dob = DateTime(year, month, day);
      return dob.isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  bool _isPasswordStrong(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasDigits = password.contains(RegExp(r'\d'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasMinLength = password.length >= 8;
    return hasDigits && hasUppercase && hasLowercase && hasMinLength;
  }

  Future<void> _signUp() async {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _mobileNumberController.text.isEmpty ||
        _dateOfBirthController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showErrorSnackbar('Please fill all fields');
      return;
    }

    if (!_isValidPhoneNumber(_mobileNumberController.text.trim())) {
      _showErrorSnackbar('Please enter a valid phone number');
      return;
    }

    if (!_isValidDate(_dateOfBirthController.text.trim())) {
      _showErrorSnackbar('Please enter a valid date of birth');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorSnackbar('Passwords do not match');
      return;
    }

    if (!_isPasswordStrong(_passwordController.text.trim())) {
      _showErrorSnackbar(
        'Password must be at least 8 characters long, include uppercase, lowercase letters, and numbers.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Create user in Firebase Authentication
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      // 2. Save additional user data to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'fullName': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'mobileNumber': _mobileNumberController.text.trim(),
        'dateOfBirth': _dateOfBirthController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3. Send email verification (optional)
      await userCredential.user?.sendEmailVerification();

      if (!mounted) return;
      _showRegistrationSuccessDialog();
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is invalid.';
      }
      _showErrorSnackbar(errorMessage);
    } catch (e) {
      _showErrorSnackbar('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showRegistrationSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text(
            'Your account has been created successfully. Please check your email for verification.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _mobileNumberController,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _dateOfBirthController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child:
                  _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
