import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class AppInformationScreen extends StatelessWidget {
  final List <String> _titleList = [
    'Date of manufacture',
    'Version',
    'Language'
  ];

  final List <String> _trailingList = [
    'Dec 2019',
    '9.0.2',
    'English'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: CustomAppBar(title: "App information"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Text(
                "CaBank E-mobile Banking",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 28,),
              Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(title: Text(_titleList[index],style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),),
                          trailing: Text(_trailingList[index],style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor
                          ),),


                        ),
                        Divider(height: 1,)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
