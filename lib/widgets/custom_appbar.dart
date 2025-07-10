import 'package:flutter/material.dart';
import '../utilities/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool centerTitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final double height;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.titleColor,
    this.centerTitle = true,
    this.showBackButton = true,
    this.actions,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: titleColor ?? Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
