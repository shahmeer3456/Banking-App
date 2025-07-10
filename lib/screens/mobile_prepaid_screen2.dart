import 'package:bank/screens/mobile_prepaid_success_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_people_row.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class MobilePrepaidScreen2 extends StatefulWidget {
  @override
  MobilePrepaidScreen2State createState() => MobilePrepaidScreen2State();
}

class MobilePrepaidScreen2State extends State<MobilePrepaidScreen2> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool isEnable = false;

  void checkFeild() {
    setState(() {
      isEnable =
          _fromController.text.isNotEmpty &&
          _toController.text.isNotEmpty &&
          _amountController.text.isNotEmpty &&
          _otpController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    _otpController.addListener(checkFeild);
    _fromController.addListener(checkFeild);
    _toController.addListener(checkFeild);
    _amountController.addListener(checkFeild);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _otpController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: "Confirm"),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintLabel: "From",
              inputLabel: "From",
              inputController: _fromController,
            ),
            SizedBox(height: 24),
            CustomTextField(
              hintLabel: "To",
              inputLabel: "To",
              inputController: _toController,
            ),
            SizedBox(height: 24),

            CustomTextField(
              hintLabel: "Amount",
              inputLabel: "Amount",
              inputController: _amountController,
            ),
            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextField(
                  hintLabel: "OTP",
                  inputLabel: "OTP",
                  widthField: 214,
                  inputController: _otpController,
                ),
                SizedBox(width: 40),
                CustomButton(
                  buttonText: "Get OTP",
                  buttonColor: primaryColor,
                  buttonPressed: () {},
                  buttonWidth: 120,
                  buttonHeight: 55,
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              buttonText: "Confirm",
              buttonColor: primaryColor,
              buttonPressed: isEnable
                  ? () {
                      _otpController.clear();
                      _amountController.clear();
                      _toController.clear();
                      _fromController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MobilePrepaidSuccessScreen(),
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
