import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String email;
  final String userStatus;

  const ProfileHeader({
    super.key,
    required this.email,
    required this.userStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8F0FE), width: 2),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person_outline,
                size: 40,
                color: Color(0xFF5F6368),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            email,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF202124),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            userStatus,
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF5F6368),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
