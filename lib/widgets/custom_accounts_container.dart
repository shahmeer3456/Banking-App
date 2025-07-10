import 'package:bank/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomAccountContainer extends StatelessWidget {
  final String mainTitle;
  final String secondTitle;
  final String thirdTitle;

  final String mainTitle2;
  final String secondTitle2;
  final String thirdTitle2;



  const CustomAccountContainer({
    required this.mainTitle,
    required this.secondTitle,
    required this.thirdTitle,
    required this.mainTitle2,
    required this.secondTitle2,
    required this.thirdTitle2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))

      ),
      child: SizedBox(
        width: 327,
        height: 108,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0,left: 16,right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text(
                    secondTitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: greyText,
                    ),
                  ),
                  SizedBox(height: 8,),

                  Text(
                    thirdTitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: greyText,
                    ),
                  ),

                ],

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    mainTitle2,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text(
                    secondTitle2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 8,),

                  Text(
                    thirdTitle2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),

                ],

              ),

            ],
          ),
        ),
      ),
    );
  }
}
