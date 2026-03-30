import 'package:flutter/material.dart';
import 'booking_confirmation_screen.dart';
import 'select_time_screen.dart';

class SelectTableScreen extends StatelessWidget {
  const SelectTableScreen({super.key});

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
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text("Breaktime Billiards",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("PREMIUM CLUB",
                            style: TextStyle(
                                fontSize: 10,
                                color: primary,
                                letterSpacing: 1)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),

            // 🔹 TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select a Table",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("12 tables available",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 FILTER
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _filter("All Tables", true),
                  _filter("Non-Smoking", false),
                  _filter("Smoking", false),
                  _filter("VIP", false),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 LIST
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _tableCard(
                    context,
                    title: "Executive Slate 9ft",
                    price: "\$15.00",
                    img:
                        "https://images.unsplash.com/photo-1544197150-b99a580bb7a8",
                    available: true,
                  ),
                  _tableCard(
                    context,
                    title: "Classic Wood 8ft",
                    price: "\$12.00",
                    img:
                        "https://images.unsplash.com/photo-1603575448878-868a20723f46",
                    available: false,
                  ),
                  _tableCard(
                    context,
                    title: "The Imperial Chamber",
                    price: "\$45.00",
                    img:
                        "https://images.unsplash.com/photo-1618220179428-22790b461013",
                    available: true,
                    vip: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 FILTER BUTTON
  Widget _filter(String text, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: active ? primary : Colors.grey.shade800,
        ),
        child: Text(text),
      ),
    );
  }

  // 🔹 TABLE CARD
  Widget _tableCard(
    BuildContext context, {
    required String title,
    required String price,
    required String img,
    required bool available,
    bool vip = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  img,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: available
                        ? Colors.green.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    available ? "AVAILABLE" : "OCCUPIED",
                    style: TextStyle(
                      fontSize: 10,
                      color: available ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(price,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                   onPressed: available
    ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectTimeScreen(),
          ),
        );
      }
    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: Text(available ? "SELECT TABLE" : "UNAVAILABLE"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}