import 'package:bank/screens/add_screen.dart';
import 'package:bank/screens/management_screen.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class SaveOnlineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: "Save online"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddScreen()),
                );
              },
              child: CustomContainer(
                mainTitle: "Add",
                subTitle: "Add new save online account",
                imagePath: "assets/images/add_screen_1.png",
                imageWidth: 100,
                imageHeight: 78,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManagementScreen()),
                );
              },
              child: CustomContainer(
                mainTitle: "Management",
                subTitle: "Manage your save online account",
                imagePath: "assets/images/add_screen_2.png",
                imageWidth: 93,
                imageHeight: 78,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
