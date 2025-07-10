import 'package:bank/screens/message_screen2.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_message.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
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
      appBar: CustomAppBar(
        title: "Message",
        centerTitle: false,
        showBackButton: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageScreen2()));
              },
              child: CustomMessage(
                imagePath: "assets/images/img.png",
                mainText: "Bank of America",
                subText: "Bank of America : 256486 is the au...",
                thirdText: "Today",
              ),
            ),
            SizedBox(height: 20,),
            CustomMessage(
              imagePath: "assets/images/img_1.png",
              mainText: "Account",
              subText: "Your account is limited. Please foll...",
              thirdText: "12/10",
            ),
            SizedBox(height: 20,),

            CustomMessage(
              imagePath: "assets/images/img_5.png",
              mainText: "Alert",
              subText: "Your statement is ready for you to...",
              thirdText: "11/10",
            ),
            SizedBox(height: 20,),

            CustomMessage(
              imagePath: "assets/images/img_3.png",
              mainText: "PayPal",
              subText: "Your account has been locked. Ple...",
              thirdText: "10/11",
            ),
            SizedBox(height: 20,),

            CustomMessage(
              imagePath: "assets/images/img_4.png",
              mainText: "Withdraw",
              subText: "Dear customer, 2987456 is your co...",
              thirdText: "10/12",
            ),
          ],
        ),
      ),
    );
  }
}
