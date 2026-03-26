import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

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
                    onPressed: () => Navigator.pop(context),
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
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            const Text(
              "Your table is reserved and ready for your arrival.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // 🔹 CARD DETAIL
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [

                  // IMAGE
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16)),
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

                        const Text(
                          "Table #08",
                          style: TextStyle(
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

                        const Row(
                          children: [
                            Icon(Icons.access_time, color: primary),
                            SizedBox(width: 6),
                            Text("8:00 PM - 10:00 PM (2 hrs)"),
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
              child: Column(
                children: [

                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    icon: const Icon(Icons.qr_code),
                    label: const Text("Show Entry Code"),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text("Add to Calendar"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}