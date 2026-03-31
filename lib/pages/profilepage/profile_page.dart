import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../B_mainpage/home_screen.dart';
import '../../my_bookings_screen.dart';
import '../A.login/logout.dart';
import 'package:projek_billiard/booking_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  static const Color bgColor = Color(0xFF0F1115);
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);

  String name = "Alex Chen";
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  int selectedNavIndex = 3;

  // 🔥 TOTAL DATA AUTO
  int get totalBookings => BookingService.getBookings().length;

  int get totalHours {
    int total = 0;
    for (var b in BookingService.getBookings()) {
      final hrs = int.parse(
        b.time.split("(")[1].replaceAll(" hrs)", ""),
      );
      total += hrs;
    }
    return total;
  }

  // 🔥 PICK IMAGE
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  // 🔥 EDIT NAME POPUP
  void editName() {
    TextEditingController controller = TextEditingController(text: name);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: cardColor,
        title: const Text("Edit Name", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter new name",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                name = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 20),

            // 🔥 PROFILE IMAGE
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: accentBlue,
                  backgroundImage:
                      imageFile != null ? FileImage(imageFile!) : null,
                  child: imageFile == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: accentBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 18),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

            // 🔥 NAME
            GestureDetector(
              onTap: editName,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textMainColor,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 STATS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statBox(totalBookings.toString(), "BOOKINGS"),
                _statBox(totalHours.toString(), "HOURS"),
              ],
            ),

            const SizedBox(height: 30),

            // 🔥 ACCOUNT SETTINGS
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "ACCOUNT SETTINGS",
                style: TextStyle(color: textSecondaryColor),
              ),
            ),

            const SizedBox(height: 10),

            _menuItem(Icons.payment, "Payment Methods"),
            _menuItem(Icons.help_outline, "Support & FAQ"),

            const SizedBox(height: 20),

            // 🔥 SIGN OUT
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Logout.showConfirmation(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.2),
                ),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // 🔥 BOTTOM NAV FIX (NO MORE BLANK WHITE)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: bgColor,
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

_navItem(Icons.home_filled, "HOME", 0),
_navItem(Icons.calendar_month, "BOOKINGS", 1),
_navItem(Icons.person, "PROFILE", 2),

            ],
          ),
        ),
      ),
    );
  }

  // 🔥 NAV ITEM FUNCTION
  Widget _navItem(IconData icon, String label, int index) {
    final isActive = selectedNavIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == selectedNavIndex) return;

if (index == 0) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const HomeScreen()),
    (route) => false,
  );
}

if (index == 1) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const MyBookingsScreen()),
    (route) => false,
  );
}
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? accentBlue : textSecondaryColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? accentBlue : textSecondaryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _statBox(String value, String label) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: accentBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: textSecondaryColor),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}