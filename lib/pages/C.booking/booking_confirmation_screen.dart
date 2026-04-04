import 'package:flutter/material.dart';
import 'package:projek_billiard/main.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String tableName;
  final String time;
  final int duration;
  final int price;
  final String userEmail; // 🔥 TAMBAH
  final String userName;

  const BookingConfirmationScreen({
    super.key,
    required this.tableName,
    required this.time,
    required this.duration,
    required this.price,
    required this.userEmail, // 🔥 WAJIB
    required this.userName, // 🔥 WAJIB
  });

  static const bg = Color(0xFF0A0C10);
  static const card = Color(0xFF161B22);
  static const primary = Color(0xFF207FDF);

  final String baseUrl = "http://127.0.0.1:8080/api";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [

            // 🔹 HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _goToBookings(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  const Expanded(
                    child: Text(
                      "Booking Status",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 ICON SUCCESS
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primary.withOpacity(0.2),
              ),
              child: const Icon(Icons.check, size: 50, color: primary),
            ),

            const SizedBox(height: 20),

            const Text(
              "You're all set.",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            const Text(
              "Your table is reserved and ready for your arrival.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // 🔹 CARD SUMMARY
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [

                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1544197150-b99a580bb7a8",
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "RESERVATION SUMMARY",
                          style: TextStyle(
                            fontSize: 10,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          tableName,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 12),

                        const Row(
                          children: [
                            Icon(Icons.location_on, color: primary),
                            SizedBox(width: 6),
                            Text("Breaktime Billiards"),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(Icons.access_time, color: primary),
                            const SizedBox(width: 6),
                            Text("$time ($duration hrs)"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const Spacer(),

            // 🔹 BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  _goToBookings(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade800,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Oke"),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🔥 FIX NAVIGATION
  void _goToBookings(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => MainNavigation(
          initialIndex: 1,
          userName: userName, // 🔥 FIX
          userEmail: userEmail, // 🔥 KIRIM
        ),
      ),
      (route) => false,
    );
  }
}