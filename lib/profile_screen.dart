import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color bgColor = Color(0xFF0F1115);
  static const Color cardColor = Color(0xFF16191D);
  static const Color accentBlue = Color(0xFF1D88F5);
  static const Color textMainColor = Color(0xFFF0F0F0);
  static const Color textSecondaryColor = Color(0xFF8B8E93);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: textMainColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: textMainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: textMainColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // 🔹 CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // 🔹 AVATAR
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/150?img=3",
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: accentBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: bgColor, width: 2),
                            ),
                            child: const Icon(Icons.edit, size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 🔹 NAME
                    const Text(
                      "Alex Chen",
                      style: TextStyle(
                        color: textMainColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Billiards Enthusiast • Level 12",
                      style: TextStyle(color: textSecondaryColor),
                    ),

                    const SizedBox(height: 24),

                    // 🔹 STATS
                    Row(
                      children: const [
                        Expanded(child: _StatCard("24", "Bookings")),
                        SizedBox(width: 10),
                        Expanded(child: _StatCard("120", "Hours")),
                        SizedBox(width: 10),
                        Expanded(child: _StatCard("15", "Clubs")),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // 🔹 RECENT ACTIVITY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Recent Activity",
                          style: TextStyle(
                            color: textMainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(color: accentBlue),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    _activityItem(
                      icon: Icons.sports,
                      title: "Rack & Roll Club",
                      subtitle: "2 hours session • Yesterday",
                      trailing: "\$32.00",
                    ),

                    _activityItem(
                      icon: Icons.emoji_events,
                      title: "Amateur Tournament",
                      subtitle: "Ranked #4 • 3 days ago",
                      trailing: ">",
                    ),

                    const SizedBox(height: 30),

                    // 🔹 SETTINGS
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ACCOUNT SETTINGS",
                        style: TextStyle(
                          color: textSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    _menuItem(Icons.credit_card, "Payment Methods"),
                    _menuItem(Icons.notifications, "Notifications"),
                    _menuItem(Icons.help, "Support & FAQ"),

                    const SizedBox(height: 20),

                    // 🔹 LOGOUT
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔹 BOTTOM NAV (optional)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: bgColor,
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, color: textSecondaryColor),
            Icon(Icons.grid_view, color: textSecondaryColor),
            Icon(Icons.calendar_month, color: textSecondaryColor),
            Icon(Icons.person, color: accentBlue),
          ],
        ),
      ),
    );
  }

  Widget _activityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: accentBlue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: textMainColor)),
                Text(subtitle,
                    style: const TextStyle(color: textSecondaryColor, fontSize: 12)),
              ],
            ),
          ),
          Text(trailing, style: const TextStyle(color: textMainColor)),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: textSecondaryColor),
      title: Text(title, style: const TextStyle(color: textMainColor)),
      trailing: const Icon(Icons.chevron_right, color: textSecondaryColor),
    );
  }
}

// 🔹 STAT CARD
class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1D88F5),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B8E93),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}