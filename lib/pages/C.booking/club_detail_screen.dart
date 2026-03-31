import 'package:flutter/material.dart';
import 'package:projek_billiard/pages/C.booking/select_table_screen.dart';

class ClubDetailScreen extends StatefulWidget {
  final String name;
  final String sub;
  final String price;
  final String rate;
  final String image;

  const ClubDetailScreen({
    super.key,
    required this.name,
    required this.sub,
    required this.price,
    required this.rate,
    required this.image,
  });

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  static const Color bgColor = Color(0xFF0F1115);
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);

  double userRating = 0;

  @override
  void initState() {
    super.initState();
    userRating = double.tryParse(widget.rate) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Image.network(widget.image, fit: BoxFit.cover),
          ),

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

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleBtn(Icons.arrow_back,
                          () => Navigator.pop(context)),
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

                        Text(
                          "Breaktime Billiards — ${widget.name}",
                          style: const TextStyle(
                            color: textMainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ⭐ RATING FIX
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      userRating =
                                          (index + 1).toDouble();
                                    });
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: index < userRating
                                        ? Colors.orange
                                        : Colors.grey,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              userRating.toStringAsFixed(1),
                              style:
                                  const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            const Text("•",
                                style: TextStyle(
                                    color: textSecondaryColor)),
                            const SizedBox(width: 10),
                            const Text("Open until 02:00",
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),

                        const SizedBox(height: 24),

                        const Text("About the club",
                            style: TextStyle(
                                color: textMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(height: 8),
                        Text(widget.sub,
                            style:
                                const TextStyle(color: textSecondaryColor)),

                        const SizedBox(height: 24),

                        const Text("Facilities",
                            style: TextStyle(
                                color: textMainColor,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: const [
                            _Facility(Icons.wifi, "WiFi"),
                            _Facility(Icons.local_bar, "Snack"),
                            _Facility(Icons.ac_unit, "AC"),
                            _Facility(Icons.local_parking, "Parking"),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // 🔥 TABLE HEADER + VIEW ALL
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Available Tables",
                                style: TextStyle(
                                    color: textMainColor,
                                    fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (_) => Container(
                                    padding: const EdgeInsets.all(20),
                                    child: const Column(
                                      mainAxisSize:
                                          MainAxisSize.min,
                                      children: [
                                        Text("All Tables",
                                            style: TextStyle(
                                                fontSize: 18)),
                                        SizedBox(height: 10),
                                        Text("Classic Table: 8"),
                                        Text("Pro Table: 4"),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: const Text("View All",
                                  style: TextStyle(
                                      color: accentBlue)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // 🔥 LIST TABLE (CAMPUR)
                        _tableItem(
                          context,
                          "Diamond Pro Table #04",
                          "VVIP Section",
                          "\$15.00",
                          "https://images.unsplash.com/photo-1572451479139-6a308211d8be",
                        ),

                        _tableItem(
                          context,
                          "Classic Table #09",
                          "Standard Section",
                          "\$10.00",
                          "https://images.unsplash.com/photo-1603575448878-868a20723f46",
                        ),

                        const SizedBox(height: 24),

                        const Text("Location",
                            style: TextStyle(
                                color: textMainColor,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),

                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text("Map Placeholder",
                                style: TextStyle(
                                    color: textSecondaryColor)),
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

  Widget _tableItem(
    BuildContext context,
    String title,
    String sub,
    String price,
    String img,
  ) {
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
            child: Image.network(img,
                width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: textMainColor)),
                Text(sub,
                    style: const TextStyle(
                        color: textSecondaryColor,
                        fontSize: 12)),
                Text(price,
                    style: const TextStyle(
                        color: accentBlue)),
              ],
            ),
          ),
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectTableScreen(
          type: title.contains("Pro") ? "pro" : "classic",
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
          child: Icon(icon,
              color: Color(0xFF1D88F5)),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(
                color: Color(0xFF8B8E93),
                fontSize: 10)),
      ],
    );
  }
}