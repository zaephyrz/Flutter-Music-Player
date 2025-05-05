import 'package:flutter/material.dart';
import '../../config/colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const GradientAppBar({required this.title, this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: AppColors.gradient),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
