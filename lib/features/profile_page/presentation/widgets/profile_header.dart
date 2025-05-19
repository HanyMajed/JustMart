import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String email;
  final String userStatus;
  final String name; // New parameter
  final String? imageUrl; // New parameter

  const ProfileHeader({
    super.key,
    required this.email,
    required this.userStatus,
    required this.name, // Add to constructor
    this.imageUrl, // Add to constructor
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
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              backgroundImage:
                  imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null
                  ? const Icon(
                      Icons.person_outline,
                      size: 40,
                      color: Color(0xFF5F6368),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            // Add name display
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF202124),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8), // Adjust spacing
          Text(
            email,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF202124),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            userStatus,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF5F6368),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
