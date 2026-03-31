import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../A.login/logout.dart';
import 'package:projek_billiard/pages/C.booking/booking_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Warna disamakan dengan tema utama
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);

  String name = "Alex Chen";
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  // 🔥 DATA AUTO
  int get totalBookings => BookingService.getBookings().length;

  int get totalHours {
    int total = 0;
    for (var b in BookingService.getBookings()) {
      try {
        final hrs = int.parse(
          b.time.split("(")[1].replaceAll(" hrs)", ""),
        );
        total += hrs;
      } catch (e) {
        total += 0;
      }
    }
    return total;
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

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
              setState(() => name = controller.text);
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
    // MENGHAPUS SCAFFOLD & BOTTOM NAVBAR KARENA SUDAH ADA DI PARENT
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          
          // Judul halaman manual karena AppBar dilepas
          const Text(
            "Profile",
            style: TextStyle(
              color: textMainColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          // 🔥 PROFILE IMAGE
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: accentBlue,
                backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
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
                    child: const Icon(Icons.edit, size: 18, color: Colors.white),
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
                fontSize: 22,
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

          const SizedBox(height: 40),

          // 🔥 ACCOUNT SETTINGS
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "ACCOUNT SETTINGS",
              style: TextStyle(color: textSecondaryColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),

          const SizedBox(height: 10),

          _menuItem(Icons.payment, "Payment Methods"),
          _menuItem(Icons.help_outline, "Support & FAQ"),

          const SizedBox(height: 30),

          // 🔥 SIGN OUT
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () => Logout.showConfirmation(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                side: BorderSide(color: Colors.red.withOpacity(0.3)),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 100), // Spasi agar tidak tertutup navbar parent
        ],
      ),
    );
  }

  Widget _statBox(String value, String label) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: accentBlue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: textSecondaryColor, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: textMainColor, size: 22),
        title: Text(text, style: const TextStyle(color: textMainColor, fontSize: 14)),
        trailing: const Icon(Icons.chevron_right, color: textSecondaryColor),
      ),
    );
  }
}