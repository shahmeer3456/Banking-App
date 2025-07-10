import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_management_tile.dart';
import 'package:flutter/material.dart';

class ManagementScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: "Management"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24,),

            CustomManagementTile(),
            SizedBox(height: 20,),
            CustomManagementTile(),
            SizedBox(height: 20,),

            CustomManagementTile(),

          ],
        ),
      ),
    );

  }
}