import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Sesuaikan import ini dengan lokasi ApiService kamu
// import '../services/api_service.dart'; 

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false; // Untuk indikator loading

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- LOGIKA REGISTER ---
  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar("Semua data harus diisi!", Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Ganti URL ini dengan URL laptop/server kamu (10.0.2.2 untuk emulator Android)
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        _showSnackBar("Akun berhasil dibuat! Silakan login.", Colors.green);
        if (mounted) Navigator.pop(context); // Kembali ke Login
      } else {
        _showSnackBar(data['message'] ?? "Gagal mendaftar", Colors.red);
      }
    } catch (e) {
      _showSnackBar("Koneksi gagal: $e", Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // --- KONSTANTA WARNA ---
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
                      const SizedBox(height: 20),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          color: textMainColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Join the club and start playing.',
                        style: TextStyle(color: textSecondaryColor, fontSize: 16),
                      ),
                      const SizedBox(height: 32),

                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Full Name', style: TextStyle(color: textSecondaryColor, fontSize: 14)),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _nameController,
                              hint: 'Alex Thompson',
                              icon: Icons.person_outline,
                            ),
                            const SizedBox(height: 20),

                            const Text('Email Address', style: TextStyle(color: textSecondaryColor, fontSize: 14)),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _emailController,
                              hint: 'your@email.com',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),

                            const Text('Password', style: TextStyle(color: textSecondaryColor, fontSize: 14)),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _passwordController,
                              hint: 'Min. 8 characters',
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),
                            
                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 8,
                                  shadowColor: accentBlue.withOpacity(0.4),
                                ),
                                child: _isLoading 
                                  ? const SizedBox(
                                      height: 24, 
                                      width: 24, 
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                                    )
                                  : const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? ', style: TextStyle(color: textSecondaryColor)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text('Sign In', style: TextStyle(color: accentBlue, fontWeight: FontWeight.w600)),
                          ),
                        ],
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
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(color: inputBgColor, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !_passwordVisible : false,
        keyboardType: keyboardType,
        style: const TextStyle(color: textMainColor),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: hintTextColor, size: 20),
          suffixIcon: isPassword 
              ? IconButton(
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off, color: hintTextColor, size: 20),
                  onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                ) 
              : null,
          hintText: hint,
          hintStyle: const TextStyle(color: hintTextColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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