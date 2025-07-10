import 'package:bank/screens/mobile_prepaid_screen2.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_people_row.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class MobilePrepaidScreen extends StatefulWidget {
  @override
  MobilePrepaidScreenState createState() => MobilePrepaidScreenState();
}

class MobilePrepaidScreenState extends State<MobilePrepaidScreen> {
  int selectedIndex = -1;
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int? selectedPersonIndex;

  bool isEnable = false;

  void checkField() {
    setState(() {
      isEnable =
          _cardController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          (selectedIndex >= 0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardController.addListener(checkField);
    _phoneController.addListener(checkField);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneController.dispose();
    _cardController.dispose();
    selectedIndex = -1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: "Mobile prepaid"),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            CustomTextField(
              hintLabel: "Choose Card/Account",
              inputController: _cardController,
            ),
            SizedBox(height: 24),
            CustomPeopleRow(
              topLeftText: "Directory",
              topRightText: "Find beneficiary",
              selectedIndex: selectedPersonIndex,
              onIndexSelected: (index) {
                selectedPersonIndex = index;
                if (index == 1) {
                  _phoneController.text = "1234";
                } else if (index == 2) {
                  _phoneController.text = "4567";
                } else {
                  _phoneController.clear();
                }
              },
            ),
            CustomTextField(
              hintLabel: "Phone number",
              inputLabel: "Phone number",
              inputController: _phoneController,
            ),
            SizedBox(height: 32),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(width: 14),

                  CustomButton(
                    buttonText: "\$20",
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
                  SizedBox(width: 14),

                  CustomButton(
                    buttonText: "\$30",
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
                ],
              ),
            ),
            CustomButton(
              buttonText: "Confirm",
              buttonColor: primaryColor,
              buttonPressed: isEnable
                  ? () {
                      _phoneController.clear();
                      _cardController.clear();
                      selectedIndex = -1;
                      selectedPersonIndex = null;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MobilePrepaidScreen2(),
                        ),
                      );
                    }
                  : null,
            ),
            SizedBox(height: 55),
          ],
        ),
      ),
    );
  }
}
