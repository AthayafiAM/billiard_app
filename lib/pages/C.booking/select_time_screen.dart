import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'booking_confirmation_screen.dart';

class SelectTimeScreen extends StatefulWidget {
  final String tableName;
  final int price;
  final String userEmail;
  final String clubName;
  final int clubId;
  final String userName;

  const SelectTimeScreen({
    super.key,
    required this.tableName,
    required this.price,
    required this.clubName,
    required this.userEmail,
    required this.userName,
    required this.clubId,
  });

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {

  int selectedIndex = -1;
  int duration = 1;

  // ✅ PAYMENT
  String selectedPayment = "Cash";

  final List<String> paymentMethods = [
    "Cash",
    "Gopay",
    "OVO",
    "BNI",
    "BRI"
  ];

  final List<String> times = [
    "15:00","16:00","17:00","18:00",
    "19:00","20:00","21:00","22:00","23:00",
  ];

  final String baseUrl = "http://localhost:8080/api";

  // 🔥 CREATE BOOKING
  Future<bool> createBooking(String time, int duration) async {
    try {

      // 🔥 DEBUG (WAJIB LIHAT INI)
      print("USERNAME: ${widget.userName}");
      print("EMAIL: ${widget.userEmail}");
      print("PAYMENT: $selectedPayment");

      if (widget.userEmail.isEmpty) {
        print("ERROR: EMAIL KOSONG");
        return false;
      }

      final res = await http.post(
        Uri.parse("$baseUrl/bookings"),
        body: {
          "table_name": widget.tableName,
          "club_id": widget.clubId.toString(),
          "club": widget.clubName,
          "start_time": time,
          "date": DateTime.now().toString().split(" ")[0],
          "duration": duration.toString(),
          "user_name": widget.userName,
          "user_email": widget.userEmail, // ✅ FIX PENTING
          "payment": selectedPayment,     // ✅ FIX
        },
      );

      print("BOOKING STATUS: ${res.statusCode}");
      print("BOOKING RESPONSE: ${res.body}");

      return res.statusCode == 200;

    } catch (e) {
      print("BOOKING ERROR: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      appBar: AppBar(
        title: Text(widget.tableName),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [

          const SizedBox(height: 20),

          const Text(
            "Choose your time",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),

          const SizedBox(height: 20),

          // 🔹 TIME LIST
          Expanded(
            child: ListView.builder(
              itemCount: times.length,
              itemBuilder: (context, index) {

                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF207FDF)
                          : const Color(0xFF161B22),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      times[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔹 DURASI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Duration (hours)", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                Row(
                  children: [1,2,3,4].map((d) {
                    final isActive = duration == d;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            duration = d;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF207FDF)
                                : const Color(0xFF161B22),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "$d h",
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 PAYMENT SELECTOR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Payment Method", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedPayment,
                  dropdownColor: const Color(0xFF161B22),
                  style: const TextStyle(color: Colors.white),
                  items: paymentMethods.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(p),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 CONTINUE BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: selectedIndex == -1
                  ? null
                  : () async {

                      final selectedTime = times[selectedIndex];

                      final success = await createBooking(selectedTime, duration);

                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingConfirmationScreen(
                              tableName: widget.tableName,
                              time: selectedTime,
                              duration: duration,
                              price: widget.price,
                              userEmail: widget.userEmail,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Booking gagal / jam bentrok")),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF207FDF),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Continue"),
            ),
          )
        ],
      ),
    );
  }
}