import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Warna-warna utama (Konsisten dengan Login & Register)
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
                      // Tombol Back
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: textMainColor, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Icon Kunci/Gembok Besar
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: accentBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: accentBlue.withOpacity(0.2), width: 2),
                        ),
                        child: const Icon(Icons.lock_reset_rounded, color: accentBlue, size: 60),
                      ),
                      const SizedBox(height: 32),

                      // Judul & Deskripsi
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: textMainColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No worries, we\'ll send you instructions\nto reset your password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textSecondaryColor, fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 40),

                      // Kartu Form
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
                            const Text('Email Address', style: TextStyle(color: textSecondaryColor, fontSize: 14)),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _emailController,
                              hint: 'your@email.com',
                              icon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 32),

                            // Tombol Reset
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Tambahkan logika kirim email di sini
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Reset link sent to your email!')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 8,
                                  shadowColor: accentBlue.withOpacity(0.4),
                                ),
                                child: const Text('Send Reset Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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

  Widget _buildTextField({required TextEditingController controller, required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(color: inputBgColor, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: textMainColor),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: hintTextColor, size: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: hintTextColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

// Painter yang sama agar background konsisten
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