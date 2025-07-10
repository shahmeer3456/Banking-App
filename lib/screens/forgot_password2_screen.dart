import 'package:bank/screens/change_password_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword2Screen extends StatefulWidget {
  @override
  ForgotPassword2ScreenState createState() => ForgotPassword2ScreenState();
}

class ForgotPassword2ScreenState extends State<ForgotPassword2Screen> {
  bool isEnable = false;
  TextEditingController codeController = TextEditingController();

  void checkField()
  {
    setState(() {
      isEnable = codeController.text.isNotEmpty;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController.addListener(checkField);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    codeController.dispose();
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
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 357,
                height: 302,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTextField(
                          hintLabel: "Code",
                          widthField: 203,
                          inputLabel: "Type a code",
                          inputController: codeController,
                        ),
                        CustomButton(
                          buttonText: "Resend",
                          buttonColor: primaryColor,
                          buttonHeight: 56,
                          buttonWidth: 120,
                          buttonPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    SizedBox(
                      width: 315,
                      height: 42,
                      child: Expanded(
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            text:
                                "We texted you a code to verify your phone number",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: greyText,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: " (+92) 0398829xxx",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),


                    SizedBox(
                      width: 315,
                      height: 42,
                      child: Text(
                        "This code will expired 10 minutes after this message. If you don't get a message.",
                        maxLines: 2,
                        style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: greyText,
                        ),
                      ),
                    ),
                    SizedBox(height: 22),

                    SizedBox(
                      width: 315,
                      height: 44,
                      child: CustomButton(
                        buttonText: "Change password",
                        buttonColor: isEnable ? primaryColor : white,
                        buttonPressed: isEnable ? () {
                          codeController.clear();
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));

                        } : null,
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
