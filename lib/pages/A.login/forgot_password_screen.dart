import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController(); // ✅ TAMBAHAN

  final String baseUrl = "http://localhost:8080/api";

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose(); // ✅ TAMBAHAN
    super.dispose();
  }

  // 🔥 FUNCTION RESET PASSWORD
  Future<void> resetPassword() async {
    final email = _emailController.text.trim();
    final newPassword = _newPasswordController.text.trim();

    if (email.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Isi semua field")),
      );
      return;
    }

    try {
      final res = await http.post(
        Uri.parse("$baseUrl/reset-password"),
        body: {
          "email": email,
          "new_password": newPassword,
        },
      );

      print("RESET RESPONSE: ${res.body}");

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password berhasil diubah")),
        );

        Navigator.pop(context); // balik ke login
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal reset password")),
        );
      }
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server error")),
      );
    }
  }

  // Warna
  static const Color bgColor = Color(0xFF0F1115);
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color inputBgColor = Color(0xFF0F1115);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);
  static const Color hintTextColor = Color(0xFF53565A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomPaint(
        painter: DotMatrixPainter(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: textMainColor, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 40),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: accentBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.lock_reset_rounded, color: accentBlue, size: 60),
                      ),

                      const SizedBox(height: 32),

                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: textMainColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // 🔹 EMAIL
                            const Text('Email', style: TextStyle(color: textSecondaryColor)),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _emailController,
                              hint: 'your@email.com',
                              icon: Icons.email_outlined,
                            ),

                            const SizedBox(height: 20),

                            // 🔹 NEW PASSWORD
                            const Text('New Password', style: TextStyle(color: textSecondaryColor)),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _newPasswordController,
                              hint: 'Enter new password',
                              icon: Icons.lock_outline,
                            ),

                            const SizedBox(height: 30),

                            // 🔥 BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: resetPassword, // ✅ FIX
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentBlue,
                                ),
                                child: const Text("Reset Password"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: textMainColor),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: hintTextColor),
          hintText: hint,
          hintStyle: const TextStyle(color: hintTextColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class DotMatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF1F2227).withOpacity(0.5);
    for (double x = 0; x < size.width; x += 16) {
      for (double y = 0; y < size.height; y += 16) {
        canvas.drawCircle(Offset(x, y), 0.6, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}