import 'package:flutter/material.dart';
import 'package:projek_billiard/pages/A.login/login_screen.dart'; 

class Logout {
  static void showConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF16191D), // Warna card gelap sesuai tema
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Color(0xFF8B8E93)),
          ),
          actions: [
            // Tombol NO (Abu-abu)
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup popup
              child: const Text(
                'No',
                style: TextStyle(color: Color(0xFF8B8E93), fontWeight: FontWeight.bold),
              ),
            ),
            // Tombol YES (Merah)
            ElevatedButton(
              onPressed: () {
                // Tutup dialog lalu pindah ke Login
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935), // Merah
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}