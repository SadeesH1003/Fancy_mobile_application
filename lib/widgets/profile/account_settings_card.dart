// ignore_for_file: deprecated_member_use

import 'package:fancy/screens/profile/my_orders.dart';
import 'package:fancy/widgets/profile/settings_item.dart';
import 'package:flutter/material.dart';

class AccountSettingsCard extends StatelessWidget {
  const AccountSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.shopping_bag_outlined,
            title: "My Orders",
            subtitle: "View your order history",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyOrders()),
              );
            },
          ),
          _buildDivider(),
          SettingsItem(
            icon: Icons.payment_outlined,
            title: "Payment Methods",
            subtitle: "Manage your payment options",
            onTap: () {
              // Implementation for payment methods
            },
          ),
          // Uncomment these as needed
          // _buildDivider(),
          // SettingsItem(
          //   icon: Icons.notifications_outlined,
          //   title: "Notifications",
          //   subtitle: "Manage your notifications",
          //   onTap: () {},
          // ),
          // _buildDivider(),
          // SettingsItem(
          //   icon: Icons.lock_outline,
          //   title: "Change Password",
          //   subtitle: "Update your password",
          //   onTap: () {},
          // ),
          // _buildDivider(),
          // SettingsItem(
          //   icon: Icons.help_outline,
          //   title: "Help Center",
          //   subtitle: "Get help and support",
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16);
  }
}
