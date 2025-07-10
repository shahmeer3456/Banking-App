import 'package:bank/screens/change_password_successfull.dart';
import 'package:bank/screens/home_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_bottomNavBar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';

class ChangePassword2Screen extends StatefulWidget {
  @override
  ChangePassword2ScreenState createState() => ChangePassword2ScreenState();
}

class ChangePassword2ScreenState extends State<ChangePassword2Screen> {
  bool isEnable = false;
  TextEditingController recentPassController = TextEditingController();

  TextEditingController newPassController = TextEditingController();
  TextEditingController cnfrmNewPassController = TextEditingController();

  void checkField() {
    setState(() {
      isEnable =
          newPassController.text.isNotEmpty &&
          cnfrmNewPassController.text.isNotEmpty &&
          recentPassController.text.isNotEmpty &&
          (newPassController.text == cnfrmNewPassController.text) &&
          (recentPassController.text != newPassController.text);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentPassController.addListener(checkField);
    newPassController.addListener(checkField);
    cnfrmNewPassController.addListener(checkField);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recentPassController.dispose();
    newPassController.dispose();
    cnfrmNewPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: "Change password",
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
                height: 422,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    CustomTextField(
                      inputController: recentPassController,
                      hintLabel: "Recent password",
                      inputLabel: "Recent password",
                      isPassword: true,
                      widthField: 316,
                      heightBtwLabelAndFeild: 8,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      inputController: newPassController,
                      hintLabel: "New password",
                      inputLabel: "New password",
                      isPassword: true,
                      widthField: 316,
                      heightBtwLabelAndFeild: 8,
                    ),
                    SizedBox(height: 24),
                    CustomTextField(
                      inputController: cnfrmNewPassController,
                      hintLabel: "Confirm password",
                      inputLabel: "Confirm password",
                      isPassword: true,
                      widthField: 316,
                      heightBtwLabelAndFeild: 8,
                    ),
                    SizedBox(height: 54),

                    SizedBox(
                      width: 315,
                      height: 44,
                      child: CustomButton(
                        buttonText: "Change password",
                        buttonColor: isEnable ? primaryColor : white,
                        buttonPressed: isEnable
                            ? () {
                                newPassController.clear();
                                cnfrmNewPassController.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomNavBar(),
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
