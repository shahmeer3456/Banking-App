import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utilities/colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_elevatedbutton.dart';

class BillPaymentSuccessfulScreen extends StatelessWidget {
  final String amount;
  final String provider;
  final String reference;

  const BillPaymentSuccessfulScreen({
    Key? key,
    required this.amount,
    required this.provider,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "",
        showBackButton: false,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/svg/bill_payment_succesful.svg",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 32),
                Text(
                  "Payment Successful!",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Your payment of \$$amount to $provider has been processed successfully.\nReference: $reference",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                CustomElevatedButton(
                  onPressed: () => Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  ),
                  child: const Text("Back to Home"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
