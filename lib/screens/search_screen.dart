import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_bottomNavBar.dart';
import 'package:bank/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
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
      appBar: CustomAppBar(title: "Search",
        centerTitle: false,
        showBackButton: false,),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomContainer(
              mainTitle: "Branch",
              subTitle: "Search for branch",
              imagePath: 'assets/images/branch.png',
              imageHeight: 78,
              imageWidth: 100,
            ),
            SizedBox(height: 20,),
            CustomContainer(
              mainTitle: "Interest rate",
              subTitle: "Search for interest rate",
              imagePath: 'assets/images/interest.png',
              imageWidth: 110,
              imageHeight: 78,
            ),
            SizedBox(height: 20,),

            CustomContainer(
              mainTitle: "Exchange rate",
              subTitle: "Search for exchange rate",
              imagePath: 'assets/images/exchange.png',
              imageWidth: 105,
              imageHeight: 81,
            ),
            SizedBox(height: 20,),

            CustomContainer(
              mainTitle: "Exchange",
              subTitle: "Exchange amount of money",
              imagePath: 'assets/images/exchange2.png',
              imageWidth: 93,
              imageHeight: 78,
            ),
          ],
        ),

      ),

    );
  }
}
