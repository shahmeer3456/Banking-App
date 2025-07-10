import 'package:bank/utilities/colors.dart';
import 'package:bank/models/card_model.dart' as models;
import 'package:bank/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (userProvider.cards.isEmpty) {
          return Center(
            child: Text(
              'No cards available',
              style: TextStyle(
                fontSize: 16,
                color: greyText,
              ),
            ),
          );
        }

        final models.Card card = userProvider.cards.first;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 261,
              height: 164,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor2,
              ),
            ),
            Positioned(
              bottom: 8,
              left: -13,
              right: -13,
              top: -22,
              child: Container(
                width: 287,
                height: 178,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cardColor2,
                ),
              ),
            ),
            Positioned(
              top: -57,
              left: -33,
              right: -33,
              bottom: 17,
              child: Container(
                width: 327,
                height: 204,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cardColor3,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.44,
                    right: 26.6,
                    top: 21.42,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.cardHolderName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 31.49),
                      Text(
                        card.cardType,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 11.39),
                      SizedBox(
                        width: 196.6,
                        height: 26.61,
                        child: Text(
                          card.maskedCardNumber,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.49),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            card.formattedBalance,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            "assets/images/${card.cardNetwork.toLowerCase()}.png",
                            width: 46.56,
                            height: 15.52,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}