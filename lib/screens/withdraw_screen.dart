import 'package:bank/screens/withdraw_successful.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  WithdrawScreenState createState() => WithdrawScreenState();
}

class WithdrawScreenState extends State<WithdrawScreen> {
  int selectedIndex = -1;
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool isEnable = false;

  void checkField() {
    setState(() {
      if (selectedIndex >= 0 && selectedIndex <= 4) {
        isEnable =
            _cardController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            (selectedIndex >= 0);
      }
      if (selectedIndex == 5) {
        isEnable =
            _cardController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            (selectedIndex >= 0) &&
            _amountController.text.isNotEmpty;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardController.addListener(checkField);
    _phoneController.addListener(checkField);
    _amountController.addListener(checkField);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amountController.dispose();
    _phoneController.dispose();
    _cardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: "Withdraw"),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, bottom: 54),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/img_8.png', width: 364, height: 188),
            SizedBox(height: 56),
            CustomTextField(
              hintLabel: "Card/Account",
              inputController: _cardController,
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintLabel: "Phone number",
              inputController: _phoneController,
            ),
            SizedBox(height: 24),

            Text(
              "Choose amount",
              style: TextStyle(
                color: greyText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomButton(
                        buttonText: "\$10",
                        buttonColor: selectedIndex == 0
                            ? primaryColor
                            : Colors.grey,
                        buttonHeight: 60,
                        buttonWidth: 112,
                        buttonPressed: () {
                          setState(() {
                            selectedIndex = selectedIndex == 0 ? -1 : 0;
                            checkField();
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        buttonText: "\$150",
                        buttonColor: selectedIndex == 1
                            ? primaryColor
                            : Colors.grey,
                        buttonHeight: 60,
                        buttonWidth: 112,
                        buttonPressed: () {
                          setState(() {
                            selectedIndex = selectedIndex == 1 ? -1 : 1;
                            checkField();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 14),

                  Column(
                    children: [
                      CustomButton(
                        buttonText: "\$50",
                        buttonColor: selectedIndex == 2
                            ? primaryColor
                            : Colors.grey,
                        buttonHeight: 60,
                        buttonWidth: 112,
                        buttonPressed: () {
                          setState(() {
                            selectedIndex = selectedIndex == 2 ? -1 : 2;
                            checkField();
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        buttonText: "\$200",
                        buttonColor: selectedIndex == 3
                            ? primaryColor
                            : Colors.grey,
                        buttonHeight: 60,
                        buttonWidth: 112,
                        buttonPressed: () {
                          setState(() {
                            selectedIndex = selectedIndex == 3 ? -1 : 3;
                            checkField();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 14),

                  Column(
                    children: [
                      CustomButton(
                        buttonText: "\$100",
                        buttonColor: selectedIndex == 4
                            ? primaryColor
                            : Colors.grey,
                        buttonHeight: 60,
                        buttonWidth: 112,
                        buttonPressed: () {
                          setState(() {
                            selectedIndex = selectedIndex == 4 ? -1 : 4;
                            checkField();
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        buttonText: "Other",
                        buttonColor: selectedIndex == 5
                            ? primaryColor
                            : Colors.grey,
                        buttonHeight: 60,
                        buttonWidth: 112,
                        buttonPressed: () {
                          setState(() {
                            selectedIndex = selectedIndex == 5 ? -1 : 5;
                            checkField();
                          });
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
            if (selectedIndex == 5) ...[
              CustomTextField(
                hintLabel: "Amount",
                inputLabel: "Choose amount",
                inputController: _amountController,
              ),
            ],
            SizedBox(height: 32),

            CustomButton(
              buttonText: "Verify",
              buttonColor: primaryColor,
              buttonPressed: isEnable
                  ? () {
                      _phoneController.clear();
                      _cardController.clear();
                      _amountController.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WithdrawSuccessfulScreen()));
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
