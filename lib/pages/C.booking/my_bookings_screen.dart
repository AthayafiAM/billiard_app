import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'booking_confirmation_screen.dart';
import '../B_mainpage/home_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  final String userEmail;
  final String userName;

  const MyBookingsScreen({
    super.key,
    required this.userEmail,
    required this.userName,
  });

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List bookings = [];
  bool isLoading = true;

  final String baseUrl = "http://localhost:8080/api";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchBookings();
  }

  // 🔥 FETCH BOOKINGS (FIX PRIVATE USER)
  Future<void> fetchBookings() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/bookings?user_email=${widget.userEmail}"), // ✅ FIX
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        setState(() {
          bookings = data['data'] ?? [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("ERROR FETCH: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // 🔹 EMPTY STATE
  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_today, size: 80, color: Colors.blue),
        const SizedBox(height: 20),
        const Text(
          "No bookings yet 😢",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(
                  userEmail: widget.userEmail,
                  userName: widget.userName,
                ),
              ),
              (route) => false,
            );
          },
          child: const Text("Find a Table"),
        )
      ],
    );
  }

  // 🔥 CARD
  Widget _card(dynamic b) {
    final table = b['table_name']?.toString() ?? "-";
    final club = b['club']?.toString() ?? "-";
    final time = b['start_time']?.toString() ?? "-";
    final date = b['date']?.toString() ?? "-";
    final duration = b['duration']?.toString() ?? "-";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookingConfirmationScreen(
              tableName: table,
              time: time,
              duration: int.tryParse(duration) ?? 1,
              price: 0,
              userEmail: widget.userEmail,
              userName: widget.userName, // ✅ FIX
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1F26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              table,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 6),

            Text("📍 $club",
                style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 4),

            Text("📅 $date",
                style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 4),

            Text("⏰ $time",
                style: const TextStyle(color: Colors.blue)),

            const SizedBox(height: 4),

            Text("⏳ $duration jam",
                style: const TextStyle(color: Colors.orange)),
          ],
        ),
      ),
    );
  }

  // 🔥 LIST
  Widget _list() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bookings.isEmpty) {
      return _empty();
    }

    return RefreshIndicator(
      onRefresh: fetchBookings,
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, i) => _card(bookings[i]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              "My Bookings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: const [
                Tab(text: "Upcoming"),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _list(),
                  _list(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}