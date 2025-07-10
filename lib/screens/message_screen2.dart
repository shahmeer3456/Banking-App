import 'package:bank/utilities/colors.dart';
import 'package:bank/widgets/custom_appbar.dart';
import 'package:bank/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class MessageScreen2 extends StatefulWidget {
  @override
  MessageScreen2State createState() => MessageScreen2State();
}

class MessageScreen2State extends State<MessageScreen2> {
  List<String> messages = [];
  final TextEditingController _messageController = TextEditingController();
  bool isEnable = false;

  void sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(_messageController.text.trim());
      });
      _messageController.clear();
    }
  }

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
      appBar: CustomAppBar(title: "Bank of America"),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isLeft = index % 2 == 0;
                  return Align(
                    alignment: isLeft
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isLeft ? Color(0xFFF2F1F9) : primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: isLeft
                              ? Radius.circular(0)
                              : Radius.circular(12),
                          bottomRight: isLeft
                              ? Radius.circular(12)
                              : Radius.circular(0),
                        ),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(
                          color: isLeft ? Colors.black : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      inputController: _messageController,

                      hintLabel: "Type something...",
                    ),
                  ),
                  SizedBox(width: 16),
                  /*IconButton(
                      icon: Icon(Icons.send, color: Colors.blue),
                      onPressed: sendMessage,
                    )*/
                  InkWell(
                    onTap: () {
                      sendMessage();
                    },
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36,)
          ],
        ),
      ),
    );
  }
}
