import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:projek_billiard/pages/B_mainpage/home_screen.dart';
import 'dart:convert';

// 🔥 SESUAIKAN IMPORT INI DENGAN PATH FILE ASLIMU
import 'pages/A.login/login_screen.dart'; 
import 'pages/C.booking/my_bookings_screen.dart'; 
import 'pages/D.profilepage/profile_page.dart';

// --- KONFIGURASI WARNA & API ---
const Color bgColor = Color(0xFF0F1115);
const String baseUrl = 'http://localhost:8080'; // Gunakan 10.0.2.2 jika pakai Emulator Android

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: bgColor,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

// --- SERVICE API (LOGIKA BACKEND) ---
class ApiService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/api/login'); 
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      // Kita decode dulu body-nya apapun status codenya
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data; // Berhasil: {'status': 'success', 'message': '...'}
      } else {
        // Gagal (401, 404, dll): {'status': 'error', 'message': 'Password Salah'}
        // Kita ambil 'message' langsung dari server CI4 agar spesifik
        return {
          'status': 'error',
          'message': data['message'] ?? 'Server Error: ${response.statusCode}'
        };
      }
    } catch (e) {
      debugPrint("Error API: $e");
      return {
        'status': 'error',
        'message': 'Koneksi gagal. Periksa jaringan atau server.'
      };
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breaktime Billiards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        useMaterial3: true,
        scaffoldBackgroundColor: bgColor,
      ),
      home: const LoginScreen(),
    );
  }
}

// --- WIDGET NAVIGASI UTAMA (SETELAH LOGIN) ---
class MainNavigation extends StatefulWidget {
  final int initialIndex; // Tambahkan ini
  const MainNavigation({super.key, this.initialIndex = 0}); // Update constructor

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;

  // 1. DEKLARASIKAN variabel _pages di sini
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // 2. ISI variabel _pages dengan halaman asli kamu
    // Pastikan file-file ini sudah di-import di bagian paling atas main.dart
    _pages = [
      const HomeScreen(),         // Index 0
      const MyBookingsScreen(),   // Index 1
      const ProfileScreen(),      // Index 2
    ];
  }

  // ... (fungsi _buildNavItem dan build tetap seperti sebelumnya)

@override
Widget build(BuildContext context) {
  return Scaffold(
    // IndexedStack menjaga agar halaman tidak di-reload saat pindah tab
    body: IndexedStack(
      index: _selectedIndex,
      children: _pages,
    ),
    bottomNavigationBar: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF16191D), // Warna card gelap agar seragam
        border: Border(
          top: BorderSide(color: Colors.white10, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home_filled, 'HOME', 0),
            _buildNavItem(Icons.calendar_month, 'BOOKINGS', 1),
            _buildNavItem(Icons.person, 'PROFILE', 2),
          ],
        ),
      ),
    ),
  );
}

// Fungsi pembantu untuk membuat item navigasi
Widget _buildNavItem(IconData icon, String label, int index) {
  bool isActive = _selectedIndex == index;
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedIndex = index;
      });
    },
    behavior: HitTestBehavior.opaque, // Agar area klik lebih luas
    child: SizedBox(
      width: 80, // Memberikan ruang yang cukup untuk icon & teks
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF1D88F5) : Colors.grey,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? const Color(0xFF1D88F5) : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
}