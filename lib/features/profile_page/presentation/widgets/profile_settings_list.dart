import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/who_are_we_page.dart';
import 'profile_list_item.dart';

class ProfileSettingsList extends StatefulWidget {
  final bool isDarkMode;
  final bool isStudentMode;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<bool> onStudentModeChanged;

  const ProfileSettingsList({
    super.key,
    required this.isDarkMode,
    required this.isStudentMode,
    required this.onDarkModeChanged,
    required this.onStudentModeChanged,
  });

  @override
  State<ProfileSettingsList> createState() => _ProfileSettingsListState();
}

class _ProfileSettingsListState extends State<ProfileSettingsList> {
  @override
  Widget build(BuildContext context) {
    const iconColor = Color(0xFF5F6368);

    final menuItems = [
      ProfileListItem(
        icon: Icons.person_outline,
        title: 'الملف الشخصي',
        onTap: () {},
        color: AppColors.lightprimaryColor,
      ),

      ProfileListItem(
        icon: Icons.add_box,
        title: 'طلباتي',
        onTap: () {},
        color: AppColors.lightprimaryColor,
      ),
      ProfileListItem(
        icon: Icons.wallet,
        title: 'المدفوعات',
        onTap: () {},
        color: AppColors.lightprimaryColor,
      ),
      ProfileListItem(
        icon: Icons.favorite_outline_outlined,
        title: 'المفضله',
        onTap: () {},
        color: AppColors.lightprimaryColor,
      ),

      ProfileListItem(
        icon: Icons.notifications_none_outlined,
        title: 'الاشعارات',
        color: AppColors.lightprimaryColor,
        trailing: Switch(
          value: widget.isStudentMode,
          activeColor: AppColors.lightprimaryColor,
          onChanged: widget.onStudentModeChanged,
        ),
      ),
      ProfileListItem(
        icon: Icons.sports_basketball_outlined,
        title: 'اللغه',
        onTap: () {},
        color: AppColors.lightprimaryColor,
      ),
      ProfileListItem(
        icon: Icons.mode_edit_outlined,
        title: 'الوضع',
        color: AppColors.lightprimaryColor,
        trailing: Switch(
          value: widget.isStudentMode,
          activeColor: AppColors.lightprimaryColor,
          onChanged: widget.onStudentModeChanged,
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: Text(
          'المساعده',
          style: TextStyles.bold13,
        ),
      ),
      ProfileListItem(
        icon: Icons.error_outline_outlined,
        title: 'من نحن',
        onTap: () {
          Navigator.pushNamed(context, WhoAreWePage.routeName);
        },
        color: AppColors.lightprimaryColor,
      ),
      // ... Add other menu items following the same pattern
    ];

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8),
      itemCount: menuItems.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 24),
      itemBuilder: (context, index) => menuItems[index],
    );
  }
}
