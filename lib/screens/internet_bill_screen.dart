import 'package:bank/screens/bill_payment_successful.dart';
import 'package:bank/screens/withdraw_successful.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InternetBillPayment extends StatefulWidget {
  @override
  InternetBillPaymentState createState() => InternetBillPaymentState();
}

class InternetBillPaymentState extends State<InternetBillPayment> {
  bool isSelected = false;
  TextEditingController _cardController = TextEditingController();
  TextEditingController _otpontroller = TextEditingController();
  bool isEnable = false;

  void checkField() {
    setState(() {
      isEnable =
          _cardController.text.isNotEmpty && _otpontroller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _cardController.addListener(checkField);
    _otpontroller.addListener(checkField);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cardController.dispose();
    _otpontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: "Internet Bill"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/svg/withdraw.svg"),
            Align(
              alignment: Alignment.center,
              child: Text(
                "01/10/2019 - 01/11/2019",
                style: TextStyle(
                  color: Color(0xFF989898),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSelected = isSelected == false ? true : false;
                });
              },
              child: Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  width: 327,
                  height: 432,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          "All the Bills",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Jackson Maine",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Address",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "403 East 4th Street,\nSanta Ana ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Phone number",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "+8424599721 ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Code",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "#2343543 ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "From",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "01/10/2019 ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "To",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "01/11/2019 ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Internet fee",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$50 ",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        DottedLine(),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tax",
                              style: TextStyle(
                                color: greyText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$10 ",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        DottedLine(),
                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$60 ",
                              style: TextStyle(
                                color: cardColor2,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (isSelected) ...[
              SizedBox(height: 32),
              CustomTextField(
                hintLabel: "Choose account/card",
                inputController: _cardController,
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextField(
                      inputController: _otpontroller,
                      hintLabel: "OTP",
                      widthField: 215,
                      inputLabel: "Get OTP to verify transaction",
                    ),
                    Spacer(),
                    CustomButton(
                      buttonText: "Get OTP",
                      buttonColor: primaryColor,
                      buttonWidth: 110,
                      buttonHeight: 54,
                      buttonPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CustomButton(
                buttonText: "Pay the bill",
                buttonColor: primaryColor,
                buttonPressed: isEnable
                    ? () {
                        _otpontroller.clear();
                        _cardController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillPaymentSuccessfulScreen(),
                          ),
                        );
                      }
                    : null,
              ),
              SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
