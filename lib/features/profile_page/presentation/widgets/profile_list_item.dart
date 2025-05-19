import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color color;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
 
          color: Color.fromARGB(255, 91, 92, 95),
 
          height: 1.4,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.chevron_left,
            color: Color(0xFFBDBDBD),
            size: 20,
          ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      minLeadingWidth: 28,
      visualDensity: const VisualDensity(vertical: -1),
    );
  }
}
