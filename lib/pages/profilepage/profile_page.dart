import 'package:flutter/material.dart';
import 'package:projek_billiard/pages/B.mainpage/home_screen.dart';
import '../A.login/logout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color bgColor = Color(0xFF0F1115);
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);
  static const Color logoutRed = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textMainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(color: textMainColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // Menambahkan physics agar scroll terasa lebih kenyal/smooth
              physics: const BouncingScrollPhysics(), 
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildHeaderSection(),
                  const SizedBox(height: 32), 
                  _buildStatsRow(),
                  const SizedBox(height: 40),
                  _buildRecentActivity(),
                  const SizedBox(height: 40),
                  _buildAccountSettings(),
                  const SizedBox(height: 32),
                  _buildSignOutButton(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      // PERBAIKAN BARIS 70: Masukkan 'context' ke dalam fungsi
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: accentBlue, shape: BoxShape.circle),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300?u=alexchen'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: accentBlue, shape: BoxShape.circle),
              child: const Icon(Icons.edit, color: Colors.white, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Alex Chen', style: TextStyle(color: textMainColor, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Billiards Enthusiast • Level 12', style: TextStyle(color: textSecondaryColor, fontSize: 14)),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statItem('24', 'BOOKINGS'),
        _statItem('120', 'HOURS'),
        _statItem('15', 'CLUBS'),
      ],
    );
  }

  Widget _statItem(String value, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: accentBlue, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: textSecondaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Recent Activity', style: TextStyle(color: textMainColor, fontSize: 18, fontWeight: FontWeight.bold)),
            Text('View All', style: TextStyle(color: accentBlue, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 16),
        _activityCard(Icons.flag, 'Rack & Roll Club', '2 hours session • Yesterday', '\$32.00'),
        const SizedBox(height: 12),
        _activityCard(Icons.emoji_events, 'Amateur Tournament', 'Ranked #4 • 3 days ago', null),
      ],
    );
  }

  Widget _activityCard(IconData icon, String title, String sub, String? price) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: accentBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: textMainColor, fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(color: textSecondaryColor, fontSize: 12)),
              ],
            ),
          ),
          if (price != null)
            Text(price, style: const TextStyle(color: textMainColor, fontWeight: FontWeight.bold))
          else
            const Icon(Icons.chevron_right, color: textSecondaryColor),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ACCOUNT SETTINGS', style: TextStyle(color: textSecondaryColor, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const SizedBox(height: 16),
        _settingTile(Icons.credit_card, 'Payment Methods'),
        _settingTile(Icons.notifications_none, 'Notifications', hasBadge: true),
        _settingTile(Icons.help_outline, 'Support & FAQ'),
      ],
    );
  }

  Widget _settingTile(IconData icon, String title, {bool hasBadge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: textSecondaryColor, size: 24),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(color: textMainColor, fontSize: 16))),
          if (hasBadge)
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: accentBlue, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          const Icon(Icons.chevron_right, color: textSecondaryColor),
        ],
      ),
    );
  }

 Widget _buildSignOutButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 56,
    child: OutlinedButton(
      // SEKARANG: Memanggil popup konfirmasi, bukan langsung logout
      onPressed: () => Logout.showConfirmation(context), 
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF2A1619)),
        backgroundColor: const Color(0xFF1A1112),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout, color: Color(0xFFE53935), size: 20),
          SizedBox(width: 12),
          Text(
            'Sign Out', 
            style: TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.bold)
          ),
        ],
      ),
    ),
  );
}

  // --- BOTTOM NAV SECTION (GABUNGAN) ---

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Item HOME dengan navigasi balik ke HomeScreen
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: _navItem(Icons.home_filled, 'HOME', false),
            ),
            _navItem(Icons.pool, 'CLUBS', false),
            _navItem(Icons.calendar_month, 'BOOKINGS', false),
            _navItem(Icons.person, 'PROFILE', true),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? accentBlue : textSecondaryColor, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? accentBlue : textSecondaryColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}