import 'package:flutter/material.dart';
import 'select_time_screen.dart';

class SelectTableScreen extends StatelessWidget {
  final String type;

  const SelectTableScreen({super.key, required this.type});

  static const bg = Color(0xFF0A0C10);
  static const card = Color(0xFF161B22);
  static const primary = Color(0xFF207FDF);

  @override
  Widget build(BuildContext context) {
    final int totalTables = type == "pro" ? 4 : 8;

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select a Table",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("$totalTables tables available",
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔥 LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: totalTables,
                itemBuilder: (context, index) {
                  bool available = index % 2 == 0;

                  String title =
                      "${type == "pro" ? "Pro" : "Classic"} Table #${index + 1}";

                  return _tableCard(
                    context,
                    title: title,
                    price: type == "pro" ? "\$15.00" : "\$10.00",
                    img:
                        "https://images.unsplash.com/photo-1572451479139-6a308211d8be",
                    available: available,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableCard(
    BuildContext context, {
    required String title,
    required String price,
    required String img,
    required bool available,
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
                              builder: (context) => SelectTimeScreen(
                                tableName: title, // 🔥 INI KUNCI
                              ),
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