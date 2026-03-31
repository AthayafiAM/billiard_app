import 'package:flutter/material.dart';
import '../B_mainpage/home_screen.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Warna-warna utama sesuai screenshot
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
              // Bagian yang bisa di-scroll (Konten Utama)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 1. Gambar & Logo
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFF22252A),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://images.pond5.com/pool-game-footage-033061194_iconl.jpeg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(child: Icon(Icons.image, color: Colors.white24, size: 50)),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: accentBlue.withOpacity(0.15),
                              border: Border.all(color: accentBlue.withOpacity(0.3), width: 1.5),
                            ),
                            child: const Center(
                              child: Icon(Icons.sports_baseball, color: accentBlue, size: 36),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // 2. Judul & Subjudul
                      const Text(
                        'Breaktime Billiards',
                        style: TextStyle(
                          color: textMainColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Welcome back, rack \'em up.',
                        style: TextStyle(color: textSecondaryColor, fontSize: 16),
                      ),
                      const SizedBox(height: 32),

                      // 3. Kartu Form Login
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
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Password', style: TextStyle(color: textSecondaryColor, fontSize: 14)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot?',
                                    style: TextStyle(
                                      color: accentBlue, 
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _passwordController,
                              hint: '********',
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SizedBox(
                                  height: 24, width: 24,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (v) => setState(() => _rememberMe = v!),
                                    activeColor: accentBlue,
                                    side: const BorderSide(color: hintTextColor),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text('Remember me', style: TextStyle(color: textSecondaryColor)),
                              ],
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validasi sederhana: email dan password tidak boleh kosong
                                  if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter your email and password')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 8,
                                  shadowColor: accentBlue.withOpacity(0.4),
                                ),
                                child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),

                      // 4. Create Account Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account? ', style: TextStyle(color: textSecondaryColor)),
                          GestureDetector(
                            onTap: () {
                              // Navigasi ke halaman Create Account
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterScreen()), // Ganti ke class pendaftaranmu
                              );
                            },
                            child: const Text('Create an account', style: TextStyle(color: accentBlue, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 5. Footer (Privacy & Terms) - Selalu di bawah layar
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _footerText('PRIVACY POLICY'),
                    const SizedBox(width: 20),
                    Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF33363A), shape: BoxShape.circle)),
                    const SizedBox(width: 20),
                    _footerText('TERMS OF SERVICE'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk TextField agar kode lebih bersih
  Widget _buildTextField({required TextEditingController controller, required String hint, required IconData icon, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(color: inputBgColor, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !_passwordVisible : false,
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

  Widget _footerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF53565A),
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
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