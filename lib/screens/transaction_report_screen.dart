import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_message.dart';
import 'package:bank/widgets/cutom_card_stack.dart';
import 'package:flutter/material.dart';

class TransactionReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: CustomAppBar(
        title: "Transaction report",
        backgroundColor: primaryColor,
        titleColor: Colors.white,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.71,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 148,),
                  SizedBox(
                    child: CustomMessage(
                      imagePath: 'assets/images/img_1.png',
                      mainText: 'Water bill',
                      subText: "Unsuccessful",
                      thirdText: "-\$280",
                    ),
                  ),
                  CustomMessage(
                    imagePath: 'assets/images/img_2.png',
                    mainText: 'Water bill',
                    subText: "Unsuccessful",
                    thirdText: "-\$280",
                  ),
                  CustomMessage(
                    imagePath: 'assets/images/img_2.png',
                    mainText: 'Water bill',
                    subText: "Unsuccessful",
                    thirdText: "-\$280",
                  ),
                ],
              ),
            ),
          ),
          Positioned(top: 114, left: 74, child: CustomCardStack()),
        ],
      ),
    );
  }
}
