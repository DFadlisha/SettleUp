import 'package:flutter/material.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({
    super.key,
  }); // Use super.key to resolve use_super_parameters

  @override
  State<LogoutPage> createState() => _LogoutPageState(); // Changed to explicitly return State<LogoutPage>
}

class _LogoutPageState extends State<LogoutPage> {
  bool _isLoading = false;

  Future<void> _handleLogout() async {
    // Set loading state
    setState(() {
      _isLoading = true;
    });

    try {
      // Actual logout logic implementation
      // Replace with your specific authentication logout mechanism
      await _performLogout();

      // Navigate only if the widget is still mounted
      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed('/login');
    } catch (error) {
      // Show error dialog only if widget is mounted
      if (!mounted) return;
      _showErrorDialog(error.toString());
    } finally {
      // Ensure loading state is reset only if widget is mounted
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _performLogout() async {
    // Simulating logout process
    await Future.delayed(const Duration(seconds: 2));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Logout Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Okay'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Logout'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logout Illustration
              Icon(Icons.exit_to_app, size: 100, color: Colors.red.shade300),
              const SizedBox(height: 30),

              // Logout Confirmation Text
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Logout Button
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
              const SizedBox(height: 15),

              // Cancel Button
              TextButton(
                onPressed:
                    _isLoading ? null : () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
