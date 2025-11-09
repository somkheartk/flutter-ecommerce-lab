import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

/// ContactScreen - User profile and contact information
///
/// This screen demonstrates:
/// - Displaying user information
/// - List of settings/options
/// - Contact information
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile header with modern design
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Colors.purple.shade400,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Profile avatar with enhanced design
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.grey],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      user?.name.substring(0, 1).toUpperCase() ?? 'U',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // User name with Thai font
                Text(
                  user?.name ?? 'ผู้ใช้งาน',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kanit',
                  ),
                ),
                const SizedBox(height: 8),

                // User email with enhanced design
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    user?.email ?? 'user@example.com',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Kanit',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Profile options with Thai titles
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _ProfileOption(
                  icon: Icons.person_rounded,
                  title: 'แก้ไขโปรไฟล์',
                  subtitle: 'อัปเดตข้อมูลส่วนตัวของคุณ',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'แก้ไขโปรไฟล์ (สาธิต)',
                          style: TextStyle(fontFamily: 'Kanit'),
                        ),
                      ),
                    );
                  },
                ),

                _ProfileOption(
                  icon: Icons.shopping_bag_rounded,
                  title: 'ประวัติการสั่งซื้อ',
                  subtitle: 'ดูประวัติการสั่งซื้อของคุณ',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'ประวัติการสั่งซื้อ (สาธิต)',
                          style: TextStyle(fontFamily: 'Kanit'),
                        ),
                      ),
                    );
                  },
                ),

                _ProfileOption(
                  icon: Icons.favorite_rounded,
                  title: 'รายการโปรด',
                  subtitle: 'สินค้าที่คุณบันทึกไว้',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'รายการโปรด (สาธิต)',
                          style: TextStyle(fontFamily: 'Kanit'),
                        ),
                      ),
                    );
                  },
                ),

                _ProfileOption(
                  icon: Icons.location_on_rounded,
                  title: 'ที่อยู่จัดส่ง',
                  subtitle: 'จัดการที่อยู่สำหรับจัดส่งสินค้า',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'ที่อยู่จัดส่ง (สาธิต)',
                          style: TextStyle(fontFamily: 'Kanit'),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Contact section with modern design
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey[50]!, Colors.white],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ติดต่อเรา',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Kanit',
                    ),
                  ),
                  const SizedBox(height: 20),

                  _ContactItem(
                    icon: Icons.email_rounded,
                    title: 'อีเมล',
                    value: 'support@fluttershop.com',
                  ),
                  const SizedBox(height: 16),

                  _ContactItem(
                    icon: Icons.phone_rounded,
                    title: 'โทรศัพท์',
                    value: '02-123-4567',
                  ),
                  const SizedBox(height: 16),

                  _ContactItem(
                    icon: Icons.language_rounded,
                    title: 'เว็บไซต์',
                    value: 'www.fluttershop.com',
                  ),
                  const SizedBox(height: 16),

                  _ContactItem(
                    icon: Icons.location_city_rounded,
                    title: 'ที่อยู่',
                    value: '123 ถนนเทคโนโลยี แขวงคลองเตย กรุงเทพฯ 10110',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // App version with enhanced design
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  'เวอร์ชัน 1.0.0 - สร้างด้วย Flutter',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Kanit',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

/// Widget for profile options
class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Kanit',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14, fontFamily: 'Kanit'),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ),
        onTap: onTap,
      ),
    );
  }
}

/// Widget for contact information items
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Kanit',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontFamily: 'Kanit',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
