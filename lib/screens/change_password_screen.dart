import 'package:bank/screens/change_password_successfull.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isEnable = false;
  TextEditingController passController = TextEditingController();
  TextEditingController cnfrmPassController = TextEditingController();

  void checkField() {
    setState(() {
      isEnable =
          passController.text.isNotEmpty &&
          cnfrmPassController.text.isNotEmpty &&
          (passController.text == cnfrmPassController.text);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passController.addListener(checkField);
    cnfrmPassController.addListener(checkField);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passController.dispose();
    cnfrmPassController.dispose();
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
                    CustomTextField(
                      inputController: passController,
                      hintLabel: "*****",
                      inputLabel: "Type your new password",
                      isPassword: true,
                      widthField: 316,
                      heightBtwLabelAndFeild: 8,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      inputController: cnfrmPassController,
                      hintLabel: "*****",
                      inputLabel: "Confirm password",
                      isPassword: true,
                      widthField: 316,
                      heightBtwLabelAndFeild: 8,
                    ),
                    SizedBox(height: 24),

                    SizedBox(
                      width: 315,
                      height: 44,
                      child: CustomButton(
                        buttonText: "Change password",
                        buttonColor: isEnable ? primaryColor : white,
                        buttonPressed: isEnable
                            ? () {
                                passController.clear();
                                cnfrmPassController.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordSuccessfulScreen(),
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
