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
const String baseUrl = 'http://localhost:8080'; // Pakai 10.0.2.2 untuk Emulator

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

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data; 
      } else {
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
  final int initialIndex;
  // 🔥 TAMBAHKAN PARAMETER INI AGAR BISA TERIMA DATA DARI LOGIN
  final String userName;
  final String userEmail;

  const MainNavigation({
    super.key, 
    this.initialIndex = 0, 
    required this.userName, 
    required this.userEmail,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages = [
      HomeScreen(userEmail: widget.userEmail, userName: widget.userName),         // Index 0
      MyBookingsScreen(userEmail: widget.userEmail, userName: widget.userName),   // Index 1
      
      // 🔥 DATA SEKARANG TERKONEKSI KE PROFILE SCREEN
      ProfileScreen(
        userName: widget.userName,   
        userEmail: widget.userEmail, 
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF16191D),
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

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
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