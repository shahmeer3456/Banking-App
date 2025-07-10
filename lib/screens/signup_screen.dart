import 'package:bank/screens/signin_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_checkbox.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:bank/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isChecked = false;

  bool isEnable = false;

  void checkField() {
    setState(() {
      isEnable =
          nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          passController.text.isNotEmpty &&
          isChecked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.addListener(checkField);
    phoneController.addListener(checkField);
    passController.addListener(checkField);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: CustomAppBar(
        title: "Sign up",
        titleColor: white,
        backgroundColor: primaryColor,
        centerTitle: false,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24, top: 39),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                mainTitle: "Welcome to us,",
                subTitle: "Hello there, create new account",
                titleColor: primaryColor,
              ),
              SizedBox(height: 32),
              Center(
                child: Image.asset(
                  "assets/images/sign_up_page.png",
                  width: 213,
                  height: 165,
                ),
              ),
              SizedBox(height: 32),
              CustomTextField(
                hintLabel: "Name",
                inputController: nameController,
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintLabel: "Phone number",
                inputController: phoneController,
              ),
              SizedBox(height: 20),
              CustomTextField(
                isPassword: true,
                hintLabel: "Password",
                inputController: passController,
              ),
              SizedBox(height: 20),
              CustomCheckBox(
                checkBoxText: "By creating an account you agree to our",
                textColorFirst: black,
                spanText: " Terms and Conditions",
                textColorSecond: primaryColor,
                onChanged: (bool value) {
                  setState(() {
                    isChecked = value;
                    checkField();
                  });
                },
              ),
              SizedBox(height: 45),
              CustomButton(
                buttonText: "Sign up",
                buttonColor: isEnable ? primaryColor : white,
                buttonPressed: isEnable
                    ? () {
                  nameController.clear();
                  phoneController.clear();
                  passController.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninScreen(),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
