import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import 'booking_data.dart';
import '../B_mainpage/home_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String tableName;
  final String time;
  final int duration;

  const BookingConfirmationScreen({
    super.key,
    required this.tableName,
    required this.time,
    required this.duration,
  });

  static const bg = Color(0xFF0A0C10);
  static const card = Color(0xFF161B22);
  static const primary = Color(0xFF207FDF);

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

            // ICON
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

            // CARD
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
                            Text("$time (${duration} hrs)"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const Spacer(),

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

  void _goToBookings(BuildContext context) {
  // 1. 🔥 SIMPAN DATA KE SERVICE
  BookingService.addBooking(
    BookingModel(
      table: tableName,
      club: "Breaktime Billiards",
      time: "$time (${duration} hrs)",
    ),
  );

  // 2. 🔥 NAVIGASI KE HOMESCREEN (Bukan ke MyBookingsScreen langsung)
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      // Kita kirim initialIndex: 1 supaya pas kebuka langsung ke tab Bookings
      builder: (_) => const HomeScreen(initialIndex: 1), 
    ),
    (route) => false, // Hapus semua tumpukan halaman lama
  );
}
}