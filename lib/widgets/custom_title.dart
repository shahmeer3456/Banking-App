import 'package:bank/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String mainTitle;
  final String subTitle;
  final Color titleColor;

  const CustomTitle({
    required this.mainTitle,
    required this.subTitle,
    required this.titleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainTitle,
          style: TextStyle(
            fontSize: 24,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
