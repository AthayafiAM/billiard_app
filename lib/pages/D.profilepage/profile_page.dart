import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../A.login/logout.dart';
import 'package:projek_billiard/pages/C.booking/booking_data.dart';

class ProfileScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);

  late String name;
  String? imageUrl;

  Uint8List? imageBytes;
  String? imageName;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    name = widget.userName;
    fetchProfile();
  }

  // 🔥 GET PROFILE
  Future<void> fetchProfile() async {
    try {
      final url =
          'http://localhost:8080/api/profile?email=${widget.userEmail}';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'];

        setState(() {
          name = data['name'];

          // 🔥 backend sudah kasih full URL
          imageUrl = data['profile_picture'];
        });
      }
    } catch (e) {
      debugPrint("FETCH ERROR: $e");
    }
  }

  // 🔥 UPDATE PROFILE (WEB VERSION)
  Future<void> _updateProfileToDb(String newName) async {
    try {
      var uri = Uri.parse('http://localhost:8080/api/update-profile');

      var request = http.MultipartRequest('POST', uri);

      request.fields['email'] = widget.userEmail;
      request.fields['name'] = newName;

      // 🔥 FIX: pakai bytes (WEB)
      if (imageBytes != null && imageName != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes!,
            filename: imageName!,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint("UPDATE STATUS: ${response.statusCode}");
      debugPrint("UPDATE BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          imageUrl = data['data']['profile_picture'];
        });

        fetchProfile();
      }
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

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

  // 🔥 PICK IMAGE (WEB)
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imageBytes = await picked.readAsBytes();
      imageName = picked.name;

      setState(() {});

      await _updateProfileToDb(name);
    }
  }

  // 🔥 EDIT NAME
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
            onPressed: () async {
              String newName = controller.text;
              setState(() => name = newName);
              Navigator.pop(context);
              await _updateProfileToDb(newName);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            "Profile",
            style: TextStyle(
              color: textMainColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          GestureDetector(
            onTap: pickImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: accentBlue,
                  backgroundImage:
                      imageUrl != null ? NetworkImage(imageUrl!) : null,
                  child: imageUrl == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: accentBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit,
                        size: 18, color: Colors.white),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 12),

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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statBox(totalBookings.toString(), "BOOKINGS"),
              _statBox(totalHours.toString(), "HOURS"),
            ],
          ),

          const SizedBox(height: 40),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "ACCOUNT SETTINGS",
              style: TextStyle(
                  color: textSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),

          const SizedBox(height: 10),

          _menuItem(Icons.payment, "Payment Methods"),
          _menuItem(Icons.help_outline, "Support & FAQ"),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () => Logout.showConfirmation(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                side: BorderSide(color: Colors.red.withOpacity(0.3)),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                "Sign Out",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 100),
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
            style:
                const TextStyle(color: textSecondaryColor, fontSize: 12),
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
        title: Text(text,
            style: const TextStyle(color: textMainColor, fontSize: 14)),
        trailing:
            const Icon(Icons.chevron_right, color: textSecondaryColor),
      ),
    );
  }
}