import 'package:flutter/material.dart';
import '../D.profilepage/profile_page.dart';
import '../C.booking/club_detail_screen.dart';
import '../C.booking/my_bookings_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex; 
  const HomeScreen({super.key, this.initialIndex = 0}); 

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. Gunakan 'late' karena nilainya akan ditentukan di initState
  late int _selectedIndex; 

  // Konstanta Warna
  static const Color bgColor = Color(0xFF0F1115);
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);

  // List halaman
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    // 3. Set index awal sesuai kiriman dari halaman sebelumnya
    _selectedIndex = widget.initialIndex; 

    _pages = [
      _buildHomeContent(),      // Index 0
      const MyBookingsScreen(), // Index 1
      const ProfileScreen(),    // Index 2
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // Body akan berubah sesuai index yang dipilih
      body: _pages[_selectedIndex],

      // 4. Bottom Navigation Bar - TETAP di bawah (Tidak ikut scroll)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: bgColor,
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: _buildNavItem(Icons.home_filled, 'HOME', _selectedIndex == 0),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: _buildNavItem(Icons.calendar_month, 'BOOKINGS', _selectedIndex == 1),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: _buildNavItem(Icons.person, 'PROFILE', _selectedIndex == 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk isi konten Home (dipisah agar rapi)
  Widget _buildHomeContent() {
    return SafeArea(
      child: Column(
        children: [
          // 1. Header (Profil & Notifikasi)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=alex'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Good evening,', style: TextStyle(color: textSecondaryColor, fontSize: 12)),
                    Text('Alex', style: TextStyle(color: textMainColor, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: cardColor, shape: BoxShape.circle),
                  child: const Icon(Icons.notifications, color: textMainColor, size: 20),
                ),
              ],
            ),
          ),

          // 2. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: const [
                  Icon(Icons.search, color: textSecondaryColor),
                  SizedBox(width: 12),
                  Text('Find your favorite club...', style: TextStyle(color: textSecondaryColor)),
                  Spacer(),
                  Icon(Icons.tune, color: textSecondaryColor),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 3. Konten yang BISA DI-SCROLL
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Featured Locations', style: TextStyle(color: textMainColor, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('View All', style: TextStyle(color: accentBlue, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 16),
                
                _buildLocationCard(
                  context,
                  'Margonda', 
                  'Professional Grade Tables • Depok', 
                  '50.000', '4.8',
                  'https://upload.wikimedia.org/wikipedia/commons/0/07/Hearst_Castle_Casa_Grande_interior_September_2012_006.jpg',
                ),
                _buildLocationCard(
                  context,
                  'Sudirman', 
                  'VIP Lounge & Bar • Jakarta City', 
                  '85.000', '4.9',
                  'https://blacklabelbilliards.com/cdn/shop/articles/savannah-pool-table_df14e3d8-362b-4cb1-bd22-874585f45ceb.jpg?v=1755621754&width=3840',
                ),
                _buildLocationCard(
                  context,
                  'BSD', 
                  'Family Friendly • Tangerang', 
                  '45.000', '4.7',
                  'https://s.alicdn.com/@sc04/kf/H2480ebe54994465b8f226dfb2ef73dadf/Bojue-9Ft-Professional-Billiard-Table-with-Aluminum-Frame-and-Automatic-Ball-Return-System.jpg',
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu untuk Kartu Lokasi
  Widget _buildLocationCard(BuildContext context, String name, String sub, String price, String rate, String imgUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(imgUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 12, right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                      const SizedBox(width: 4),
                      Text(rate, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Breaktime Billiards — $name', style: const TextStyle(color: textMainColor, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(sub, style: const TextStyle(color: textSecondaryColor, fontSize: 12)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Rp $price', style: const TextStyle(color: accentBlue, fontSize: 18, fontWeight: FontWeight.bold)),
                          const TextSpan(text: ' /hr', style: TextStyle(color: textSecondaryColor, fontSize: 12)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ClubDetailScreen(
                              name: name,
                              sub: sub,
                              price: price,
                              rate: rate,
                              image: imgUrl,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu untuk Item Navigasi Bawah
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? accentBlue : textSecondaryColor, size: 26),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? accentBlue : textSecondaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}