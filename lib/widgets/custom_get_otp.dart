import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomOTP extends StatefulWidget {
  String? inputLabel;
  final String hintLabel;
  bool? isPassword;
  TextEditingController? inputController;
  final String buttonText;
  final Color butonColor;

  //double? widthField;
  double? heightBtwLabelAndFeild;
  void Function()? onFieldTap;

  CustomOTP({
    required this.hintLabel,
    this.inputLabel,
    this.isPassword,
    this.inputController,
    //this.widthField,
    this.heightBtwLabelAndFeild,
    this.onFieldTap,
    required this.buttonText,
    required this.butonColor,
    super.key,
  });

  @override
  CustomOTPState createState() => CustomOTPState();
}

class CustomOTPState extends State<CustomOTP> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          hintLabel: widget.hintLabel,
          inputLabel: widget.inputLabel,
          isPassword: widget.isPassword,
          inputController: widget.inputController,
          widthField: 214,
          heightBtwLabelAndFeild: widget.heightBtwLabelAndFeild,
          onFieldTap: widget.onFieldTap,
        ),
        SizedBox(width: 40,),

        CustomButton(
          buttonText: widget.buttonText,
          buttonColor: widget.butonColor,
          buttonWidth: 110,
          buttonHeight: 54,
          buttonPressed: () {},
        ),
      ],
    );
  }
}
