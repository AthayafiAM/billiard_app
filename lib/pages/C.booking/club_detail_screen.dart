import 'package:flutter/material.dart';
import 'package:projek_billiard/pages/C.booking/select_table_screen.dart';

class ClubDetailScreen extends StatelessWidget {
  final int clubId; // 🔥 WAJIB
  final String name;
  final String sub;
  final String price;
  final String rate;
  final String image;

  const ClubDetailScreen({
    super.key,
    required this.clubId,
    required this.name,
    required this.sub,
    required this.price,
    required this.rate,
    required this.image,
  });

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

          // 🔥 IMAGE HEADER
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(image, fit: BoxFit.cover),
          ),

          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [bgColor, Colors.transparent],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [

                // 🔹 TOP BAR
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

                        const SizedBox(height: 170),

                        // 🔥 TITLE
                        Text(
                          "Breaktime Billiards — $name",
                          style: const TextStyle(
                            color: textMainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // 🔥 RATING
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange),
                            const SizedBox(width: 5),
                            Text(rate, style: const TextStyle(color: Colors.white)),
                            const SizedBox(width: 10),
                            const Text("•", style: TextStyle(color: textSecondaryColor)),
                            const SizedBox(width: 10),
                            const Text("Open until 02:00",
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // 🔥 PRICE
                        Text(
                          "Rp $price / hour",
                          style: const TextStyle(
                            color: accentBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 🔥 ABOUT
                        const Text(
                          "About the club",
                          style: TextStyle(
                            color: textMainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          sub,
                          style: const TextStyle(color: textSecondaryColor),
                        ),

                        const SizedBox(height: 24),

                        // 🔥 FACILITIES
                        const Text(
                          "Facilities",
                          style: TextStyle(
                            color: textMainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            _Facility(Icons.wifi, "WiFi"),
                            _Facility(Icons.fastfood, "Snack"),
                            _Facility(Icons.ac_unit, "AC"),
                            _Facility(Icons.local_parking, "Parking"),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // 🔥 CLASS
                        const Text(
                          "Choose Class",
                          style: TextStyle(
                            color: textMainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ✅ PRO
                        _classCard(
  context: context,
  title: "Pro Class",
  desc: "Exclusive room • 4 tables",
  type: "pro",
  price: 15000,
),

                        const SizedBox(height: 12),

                        // ✅ CLASSIC
                        _classCard(
                          context : context,
                          title: "Classic Class",
                          desc: "Regular room • 8 tables",
                          type: "classic",
                          price: 10000,
                        ),

                        const SizedBox(height: 40),
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

  // 🔵 BUTTON
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

  // 🔥 CLASS CARD FIX TOTAL
Widget _classCard({
  required BuildContext context,
  required String title,
  required String desc,
  required String type,
  required int price,
}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          const Text("🎱", style: TextStyle(fontSize: 28)),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: textMainColor)),
                Text(desc,
                    style: const TextStyle(
                        color: textSecondaryColor, fontSize: 12)),
                Text("Rp $price / hour",
                    style: const TextStyle(color: accentBlue)),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SelectTableScreen(
  clubId: this.clubId,
  type: type,
  price: price,
  clubName: this.name,
),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: accentBlue,
            ),
            child: const Text("Select"),
          ),
        ],
      ),
    );
  }
}

// 🔥 FACILITY
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
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8B8E93),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}