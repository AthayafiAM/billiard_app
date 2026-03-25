import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Skema warna 1:1 dari desain
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: textMainColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Bagian yang bisa di-scroll
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // 1. Foto Profil & Nama
                  _buildHeaderSection(),
                  const SizedBox(height: 32),
                  
                  // 2. Row Statistik (Bookings, Hours, Clubs)
                  _buildStatsRow(),
                  const SizedBox(height: 40),

                  // 3. Recent Activity Section
                  _buildRecentActivity(),
                  const SizedBox(height: 40),

                  // 4. Account Settings Section
                  _buildAccountSettings(),
                  const SizedBox(height: 32),

                  // 5. Button Sign Out
                  _buildSignOutButton(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom Nav Bar tetap di bawah
      bottomNavigationBar: _buildBottomNav(),
    );
  }

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
        const Text(
          'Alex Chen',
          style: TextStyle(color: textMainColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Billiards Enthusiast • Level 12',
          style: TextStyle(color: textSecondaryColor, fontSize: 14),
        ),
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
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF2A1619)),
          backgroundColor: const Color(0xFF1A1112),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.logout, color: logoutRed, size: 20),
            SizedBox(width: 12),
            Text('Sign Out', style: TextStyle(color: logoutRed, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(color: bgColor, border: Border(top: BorderSide(color: Colors.white10, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_filled, 'HOME', false),
          _navItem(Icons.pool, 'CLUBS', false),
          _navItem(Icons.calendar_month, 'BOOKINGS', false),
          _navItem(Icons.person, 'PROFILE', true),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? accentBlue : textSecondaryColor),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? accentBlue : textSecondaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}