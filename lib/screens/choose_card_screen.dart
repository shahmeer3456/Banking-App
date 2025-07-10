import 'package:bank/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_accounts_container.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';


class ChooseCardScreen extends StatelessWidget {
  const ChooseCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Choose Card"),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCardOption(
            context,
            cardNumber: "1234",
            cardType: "Visa",
            onTap: () => Navigator.pop(context, 1),
          ),
          const SizedBox(height: 16),
          _buildCardOption(
            context,
            cardNumber: "5678",
            cardType: "Mastercard",
            onTap: () => Navigator.pop(context, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildCardOption(
    BuildContext context, {
    required String cardNumber,
    required String cardType,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          'assets/images/${cardType.toLowerCase()}.png',
          width: 40,
          height: 40,
        ),
        title: Text('**** **** **** $cardNumber'),
        subtitle: Text(cardType),
        onTap: onTap,
      ),
    );
  }
}