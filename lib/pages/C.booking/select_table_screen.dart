import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'select_time_screen.dart';

class SelectTableScreen extends StatefulWidget {
  final int clubId;
  final String type;
  final int price;
  final String clubName;

  const SelectTableScreen({
    super.key,
    required this.clubId,
    required this.type,
    required this.price,
    required this.clubName,
  });

  @override
  State<SelectTableScreen> createState() => _SelectTableScreenState();
}

class _SelectTableScreenState extends State<SelectTableScreen> {
  static const bg = Color(0xFF0A0C10);
  static const card = Color(0xFF161B22);
  static const primary = Color(0xFF207FDF);

  final String baseUrl = "http://localhost:8080/api/tables";

  List tables = [];
  bool isLoading = true;

  // 🔥 GET TABLES
  Future<void> getTables() async {
    try {
      final res = await http.get(Uri.parse("$baseUrl?type=${widget.type}"));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        setState(() {
          tables = data["data"];
          isLoading = false;
        });
      } else {
        throw Exception("Failed load tables");
      }
    } catch (e) {
      print("ERROR TABLE: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTables();
  }

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
                  Expanded(
                    child: Column(
                      children: [
                        Text(widget.clubName, // 🔥 DINAMIS
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Text("PREMIUM CLUB",
                            style: TextStyle(
                                fontSize: 10,
                                color: primary,
                                letterSpacing: 1)),
                      ],
                    ),
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
                  Text("${tables.length} tables available",
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔥 LIST
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: tables.length,
                      itemBuilder: (context, index) {
                        final table = tables[index];

                        return _tableCard(
                          context,
                          table: table,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 CARD
  Widget _tableCard(
    BuildContext context, {
    required Map table,
  }) {
    final title = table["table_name"] ?? "-";
    final price = table["price"] ?? 0;
    final img = table["image"] ??
        "https://images.unsplash.com/photo-1572451479139-6a308211d8be";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
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
                    Text("Rp $price",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectTimeScreen(
                          tableName: title,
                          price: int.parse(price.toString()),
                          clubName: widget.clubName, // 🔥 FIX DISINI
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text("SELECT TABLE"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}