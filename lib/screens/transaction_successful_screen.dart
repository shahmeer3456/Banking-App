import 'package:bank/screens/signin_screen.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_bottomNavBar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransferSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: " ",showBackButton: false,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24,),
              SvgPicture.asset(
                "assets/images/svg/withdraw.svg",
              ),
              SizedBox(height: 32,),
              Text(
                "Transfer successful!",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24,),
              SizedBox(
                width: 327,
                height: 63,
                child: Text(
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  "You have successfully transferred \n\$ 1,000 to Amanda!",
                  style: TextStyle(

                    color: black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 32,),
              CustomButton(buttonText: "Confirm", buttonColor: primaryColor,buttonPressed:
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomNavBar()));
              },)
            ],
          ),
        ),
      ),
    );
  }
}
