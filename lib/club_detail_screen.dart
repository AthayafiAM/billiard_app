import 'package:flutter/material.dart';

class ClubDetailScreen extends StatelessWidget {
  const ClubDetailScreen({super.key});

  static const Color bgColor = Color(0xFF0F1115);
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // 🔥 BACKGROUND IMAGE
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Image.network(
              "https://images.unsplash.com/photo-1544197150-b99a580bb7a8?q=80&w=1200",
              fit: BoxFit.cover,
            ),
          ),

          // 🔥 GRADIENT
          Container(
            height: 320,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [bgColor, Colors.transparent],
              ),
            ),
          ),

          // 🔥 CONTENT
          SafeArea(
            child: Column(
              children: [
                // HEADER BUTTONS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleBtn(Icons.arrow_back, () => Navigator.pop(context)),
                      Row(
                        children: [
                          _circleBtn(Icons.share, () {}),
                          const SizedBox(width: 10),
                          _circleBtn(Icons.favorite_border, () {}),
                        ],
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 180),

                        // TITLE
                        const Text(
                          "Breaktime Billiards — Sudirman",
                          style: TextStyle(
                            color: textMainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: const [
                            _RatingBadge(),
                            SizedBox(width: 10),
                            Text("120+ reviews", style: TextStyle(color: textSecondaryColor)),
                            SizedBox(width: 10),
                            Text("•", style: TextStyle(color: textSecondaryColor)),
                            SizedBox(width: 10),
                            Text("Open until 02:00",
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ABOUT
                        const Text("About the club",
                            style: TextStyle(
                                color: textMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(height: 8),
                        const Text(
                          "Experience premium billiards in the heart of Sudirman. Featuring tournament-grade tables, signature cocktails, and a sophisticated atmosphere.",
                          style: TextStyle(color: textSecondaryColor),
                        ),

                        const SizedBox(height: 24),

                        // FACILITIES
                        const Text("Facilities",
                            style: TextStyle(
                                color: textMainColor,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            _Facility(Icons.wifi, "WiFi"),
                            _Facility(Icons.local_bar, "Snack"),
                            _Facility(Icons.ac_unit, "AC"),
                            _Facility(Icons.local_parking, "Parking"),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // TABLES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Available Tables",
                                style: TextStyle(
                                    color: textMainColor,
                                    fontWeight: FontWeight.bold)),
                            Text("12 tables available",
                                style: TextStyle(color: accentBlue)),
                          ],
                        ),

                        const SizedBox(height: 12),

                        _tableItem(
                          "Diamond Pro Table #04",
                          "VVIP Section",
                          "\$15.00",
                          "https://images.unsplash.com/photo-1572451479139-6a308211d8be",
                        ),

                        _tableItem(
                          "Classic Table #09",
                          "Standard Section",
                          "\$10.00",
                          "https://images.unsplash.com/photo-1603575448878-868a20723f46",
                        ),

                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: accentBlue),
                          ),
                          child: const Center(
                            child: Text("View All Tables",
                                style: TextStyle(color: accentBlue)),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // LOCATION
                        const Text("Location",
                            style: TextStyle(
                                color: textMainColor,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),

                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text("Map Placeholder",
                                style: TextStyle(color: textSecondaryColor)),
                          ),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 BUTTON
  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }

  // 🔹 TABLE ITEM
  Widget _tableItem(String title, String sub, String price, String img) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(img, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: textMainColor)),
                Text(sub,
                    style: const TextStyle(color: textSecondaryColor, fontSize: 12)),
                Text(price,
                    style: const TextStyle(color: accentBlue)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: accentBlue),
            child: const Text("Select"),
          )
        ],
      ),
    );
  }
}

// 🔹 RATING BADGE
class _RatingBadge extends StatelessWidget {
  const _RatingBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF1D88F5).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.star, color: Color(0xFF1D88F5), size: 14),
          SizedBox(width: 4),
          Text("4.8",
              style: TextStyle(
                  color: Color(0xFF1D88F5),
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// 🔹 FACILITY ICON
class _Facility extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Facility(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF16191D),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Color(0xFF1D88F5)),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(
                color: Color(0xFF8B8E93), fontSize: 10)),
      ],
    );
  }
}