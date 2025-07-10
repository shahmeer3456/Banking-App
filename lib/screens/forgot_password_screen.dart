import 'package:bank/screens/forgot_password2_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneController = TextEditingController();

  bool isEnable = false;

  void checkField() {
    setState(() {
      isEnable = phoneController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController.addListener(checkField);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: "Forgot password",
        titleColor: Colors.black,
        centerTitle: false,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Material(
              color: white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 357,
                height: 242,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    CustomTextField(
                      inputController: phoneController,
                      hintLabel: "(+92)",
                      widthField: 315,
                      inputLabel: "Type your phone number",
                    ),
                    SizedBox(height: 24),

                    SizedBox(
                      width: 315,
                      height: 42,
                      child: Text(
                        "We text you a code to verify your phone number",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: greyText,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 10),

                    SizedBox(
                      width: 315,
                      height: 44,
                      child: CustomButton(
                        buttonText: "Send",
                        buttonColor: isEnable ? primaryColor : white,
                        buttonPressed: isEnable
                            ? () {
                          phoneController.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPassword2Screen(),
                                  ),
                                );
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
