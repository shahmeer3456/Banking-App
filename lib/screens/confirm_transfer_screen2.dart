import 'package:bank/screens/transaction_successful_screen.dart';
import 'package:bank/screens/withdraw_successful.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:bank/widgets/custom_get_otp.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ConfirmTransferScreen2 extends StatefulWidget {
  String? personName;
  int? card;
  int? personIndex;
  String? content;
  String? amount;
  String? bank;


  ConfirmTransferScreen2({
    this.personName,
    super.key,
    this.card,
    this.personIndex,
    this.content,
    this.amount,
  });

  @override
  ConfirmTransferScreen2State createState() => ConfirmTransferScreen2State();
}

class ConfirmTransferScreen2State extends State<ConfirmTransferScreen2> {
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _transactionFeeController =
  TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool isEnable = false;

  void checkField() {
    setState(() {
      isEnable = _otpController.text.isNotEmpty &&
          _cardNumberController.text.isNotEmpty
          && _toController.text.isNotEmpty &&
          _cardNumberController.text.isNotEmpty &&
          _transactionFeeController.text.isNotEmpty
          &&_contentController.text.isNotEmpty&&_amountController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _amountController.addListener(checkField);
    _toController.addListener(checkField);
    _cardNumberController.addListener(checkField);
    _transactionFeeController.addListener(checkField);
    _contentController.addListener(checkField);
    _cardController.addListener(checkField);
    _otpController.addListener(checkField);
    setState(() {
      if (widget.card == 1) {
        _cardController.text = "1234";
      } else if (widget.card == 2) {
        _cardController.text = "5678";
      } else {
        _cardController.clear();
      }
    });
    setState(() {
      _toController.text = widget.personName ?? " ";
      _transactionFeeController.text = "\$10";
      _contentController.text = widget.content ?? " ";
      _amountController.text = widget.amount ?? " ";
    });
    setState(() {
      if (widget.personIndex == 1) {
        _cardNumberController.text = "1234";
      } else if (widget.personIndex == 2) {
        _cardNumberController.text = "5678";
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: "Confirm"),
      body: Center(
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextField(
                hintLabel: "Card",
                inputController: _cardController,
                inputLabel: "From",
                heightBtwLabelAndFeild: 8,
              ),
              SizedBox(height: 12),
              CustomTextField(
                hintLabel: "To",
                inputController: _toController,
                inputLabel: "To",
                heightBtwLabelAndFeild: 8,
              ),
              SizedBox(height: 12),
              CustomTextField(
                hintLabel: "Card number",
                inputController: _cardNumberController,
                inputLabel: "Card number",
                heightBtwLabelAndFeild: 8,
              ),
              SizedBox(height: 12),
              CustomTextField(
                hintLabel: "Transaction fee",
                inputController: _transactionFeeController,
                inputLabel: "Transaction fee",
                heightBtwLabelAndFeild: 8,
              ),
              SizedBox(height: 12),
              CustomTextField(
                hintLabel: "Content",
                inputController: _contentController,
                inputLabel: "Content",
                heightBtwLabelAndFeild: 8,
              ),
              SizedBox(height: 12),
              CustomTextField(
                hintLabel: "Amount",
                inputController: _amountController,
                inputLabel: "Amount",
                heightBtwLabelAndFeild: 8,
              ),
              SizedBox(height: 12),
              CustomOTP(
                hintLabel: "OTP",
                inputLabel: "Get OTP to verify transaction",
                buttonText: "Get OTP",
                butonColor: primaryColor,
                inputController: _otpController,
              ),
              Spacer(),
              CustomButton(buttonText: "Confirm", buttonColor: primaryColor,buttonPressed: isEnable?(){
                _otpController.clear();
                _cardController.clear();
                _contentController.clear();
                _transactionFeeController.clear();
                _toController.clear();
                _amountController.clear();
                _cardNumberController.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferSuccessfulScreen()));


              }:null,),
              SizedBox(height: 24,)
            ],
          ),
        ),
      ),
    );
  }
}
