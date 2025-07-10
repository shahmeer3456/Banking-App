import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/add_successful_screen.dart';
import '../screens/choose_card_screen.dart';
import '../utilities/colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_elevatedbutton.dart';
import '../widgets/custom_textfield.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  AddScreenState createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _timeDepositController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool isEnable = false;
  int? selectedCard;
  String result = "";

  void checkField() {
    setState(() {
      isEnable = _amountController.text.isNotEmpty &&
          _timeDepositController.text.isNotEmpty &&
          _accountController.text.isNotEmpty &&
          double.tryParse(_amountController.text) != null &&
          double.parse(_amountController.text) >= 1000;
    });
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(checkField);
    _timeDepositController.addListener(checkField);
    _accountController.addListener(checkField);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _timeDepositController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add"),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/svg/add_screen.svg"),
              const SizedBox(height: 32),
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        hintLabel: "Choose account/card",
                        widthField: 295,
                        inputController: _accountController,
                        readOnly: true,
                        onFieldTap: () async {
                          selectedCard = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseCardScreen(),
                            ),
                          );

                          if (selectedCard == 1) {
                            _accountController.text = "1234";
                          } else if (selectedCard == 2) {
                            _accountController.text = "5678";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintLabel: "Choose time deposit",
                        widthField: 295,
                        inputController: _timeDepositController,
                        readOnly: true,
                        onFieldTap: () async {
                          final selectedTime = await showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                'Choose time deposit',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(
                                      '3 months (Interest rate 4%)',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(
                                      context,
                                      '3 months (Interest rate 4%)',
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '6 months (Interest rate 4.5%)',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(
                                      context,
                                      '6 months (Interest rate 4.5%)',
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '12 months (Interest rate 5%)',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(
                                      context,
                                      '12 months (Interest rate 5%)',
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '16 months (Interest rate 5.5%)',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(
                                      context,
                                      '16 months (Interest rate 5.5%)',
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '24 months (Interest rate 6%)',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.greyText,
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(
                                      context,
                                      '24 months (Interest rate 6%)',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          if (selectedTime != null) {
                            setState(() {
                              _timeDepositController.text = selectedTime;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintLabel: "Amount (At least \$1000)",
                        widthField: 295,
                        inputController: _amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        onPressed: isEnable
                            ? () {
                                _timeDepositController.clear();
                                _accountController.clear();
                                _amountController.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddSuccessfulScreen(),
                                  ),
                                );
                              }
                            : null,
                        child: const Text('Verify'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
