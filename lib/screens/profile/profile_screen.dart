// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  
  final AuthService authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
            child: Column(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/90'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Aishfa Sheikh',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'aishfa@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          
          // Account Section
          _buildSection(
            context,
            'Account',
            [
              _buildMenuItem(context, 'Edit Profile', Icons.edit_outlined, () {
                Get.toNamed('/edit-profile');
              }),
              _buildMenuItem(context, 'Home Address', Icons.home_outlined, () {}),
              _buildMenuItem(context, 'Security', Icons.security_outlined, () {}),
              _buildMenuItem(context, 'Payments', Icons.payment_outlined, () {}),
            ],
          ),
          
          const Divider(thickness: 1),
          
          // FoodMarket Section
          _buildSection(
            context,
            'FoodMarket',
            [
              _buildMenuItem(context, 'Rate App', Icons.star_outline, () {}),
              _buildMenuItem(context, 'Help Center', Icons.help_outline, () {}),
              _buildMenuItem(context, 'Privacy & Policy', Icons.privacy_tip_outlined, () {}),
              _buildMenuItem(context, 'Terms & Conditions', Icons.description_outlined, () {}),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Sign Out Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomButton(
              text: 'Sign Out',
              onPressed: () async {
                await authService.signOut();
                Get.offAllNamed('/sign-in');
              },
              color: Colors.red.shade100,
              textColor: Theme.of(context).primaryColor,
            ),
          ),
          
          const SizedBox(height: 30),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', false),
          _buildNavItem(Icons.shopping_bag, 'Orders', false),
          _buildNavItem(Icons.person, 'Profile', true),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Get.theme.primaryColor : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Get.theme.primaryColor : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
