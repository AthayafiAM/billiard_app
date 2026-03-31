import 'package:flutter/material.dart';
import 'booking_confirmation_screen.dart';

class SelectTimeScreen extends StatefulWidget {
  final String tableName; // 🔥 TAMBAHAN

  const SelectTimeScreen({
    super.key,
    required this.tableName,
  });

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {

  int selectedIndex = -1;
  int duration = 1;

  final List<String> times = [
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      appBar: AppBar(
        title: const Text("Select Time"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [

          const SizedBox(height: 20),

          const Text(
            "Choose your time",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

          // 🔥 DURASI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Duration (hours)",
                  style: TextStyle(color: Colors.white),
                ),
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

          // 🔹 BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: selectedIndex == -1
                  ? null
                  : () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => PaymentSheet(
                          time: times[selectedIndex],
                          duration: duration,
                          tableName: widget.tableName, // 🔥 KIRIM
                        ),
                      );
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






// ================= PAYMENT POPUP =================

class PaymentSheet extends StatelessWidget {
  final String time;
  final int duration;
  final String tableName;

  const PaymentSheet({
    super.key,
    required this.time,
    required this.duration,
    required this.tableName,
  });

  @override
  Widget build(BuildContext context) {

    int pricePerHour = 15000;
    int total = pricePerHour * duration;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text(
            "Payment Method",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),

          const SizedBox(height: 20),

          const ListTile(
            title: Text("QRIS", style: TextStyle(color: Colors.white)),
          ),
          const ListTile(
            title: Text("E-Wallet", style: TextStyle(color: Colors.white)),
          ),
          const ListTile(
            title: Text("Cash", style: TextStyle(color: Colors.white)),
          ),

          const SizedBox(height: 20),

          Text(
            "Total: Rp $total",
            style: const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingConfirmationScreen(
                    tableName: tableName,
                    time: time,
                    duration: duration,
                  ),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF207FDF),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("PAY"),
          )
        ],
      ),
    );
  }
}