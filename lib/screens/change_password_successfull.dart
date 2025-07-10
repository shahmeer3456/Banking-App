import 'package:bank/screens/signin_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';

class ChangePasswordSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: " "),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Image.asset(
                "assets/images/pass_success.png",
                width: 327,
                height: 216,
              ),
              SizedBox(height: 32),
              Text(
                "Change password successfully!",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: 327,
                height: 42,
                child: Text(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  "You have successfully change password.\nPlease use the new password when Sign in.!",
                  style: TextStyle(
                    color: black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 32),
              CustomButton(
                buttonText: "Ok",
                buttonColor: primaryColor,
                buttonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
