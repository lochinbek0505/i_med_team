import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Center(
          child: Text(
            'Profil',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Section
            Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/seed/picsum/200/300',
                      ), // Placeholder
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black87,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'Lochinbek Tovmurodov',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            // Profile Options
            _buildProfileOption(
              link: "assets/dollar.png",
              title: "Moliyaviy hisobot",
              onTap: () {},
            ),
            _buildProfileOption(
              link: "assets/business.png",
              title: "Natijalar",
              onTap: () {},
            ),
            _buildProfileOption(
              link: "assets/clock.png",
              title: "Faollik : 10 soat 42 min",
              onTap: () {},
              showArrow: false,
            ),
            _buildDarkModeToggle(),
            _buildProfileOption(
              link: "assets/customer.png",
              title: "Admin bilan bog'lanish",
              onTap: () {},
            ),
            _buildProfileOption(
              link: "assets/logout 1.png",
              title: "Hisobdan chiqish",
              onTap: () {},
              isLogout: true,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
    );
  }

  // Profile Option Widget
  Widget _buildProfileOption({
    required String link,
    required String title,
    required VoidCallback onTap,
    bool showArrow = true,
    bool isLogout = false,
  }) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            link,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.red : Colors.black87,
              ),
            ),
          ),
          if (showArrow)
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black45,
            ),
        ],
      ),
    );
  }

  // Dark Mode Toggle
  Widget _buildDarkModeToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/day_mode.png",
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Qorong'u rejim",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Switch(
            value: false,
            onChanged: (bool value) {},
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
