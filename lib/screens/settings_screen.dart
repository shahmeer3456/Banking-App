import 'package:bank/screens/app_information_screen.dart';
import 'package:bank/screens/change_password2.dart';
import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<String> _listNames = [
    'Password',
    'Touch ID',
    'Languages',
    'App information',
    'Customer care',
  ];

  final List<Widget> _pagesPath = [
    ChangePassword2Screen(),
    Center(child: Text('Touch ID', style: TextStyle(fontSize: 24))),
    Center(child: Text('Languages', style: TextStyle(fontSize: 24))),

    AppInformationScreen(),
    Center(child: Text('Customer care', style: TextStyle(fontSize: 24))),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: CustomAppBar(
        title: "Settings",
        backgroundColor: primaryColor,
        titleColor: Colors.white,
        showBackButton: false,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.71,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  SizedBox(
                    width: 150,
                    height: 24,
                    child: Text(
                      "  Push Puttichai",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0,right: 24),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  _listNames[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => _pagesPath[index],
                                    ),
                                  );
                                },
                              ),
                              Divider(height: 1,)
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -52,
            bottom: 510,
            left: 137,
            right: 138,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: SizedBox(
                width: 120, // width = radius * 2
                height: 120,
                child: Image.asset(
                  'assets/images/personhomescreen.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
