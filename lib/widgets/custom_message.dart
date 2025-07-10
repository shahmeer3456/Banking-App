import 'package:bank/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomMessage extends StatefulWidget {
  final String imagePath;
  final String mainText;
  final String subText;
  final String thirdText;

  const CustomMessage({
    required this.imagePath,
    required this.mainText,
    required this.subText,
    required this.thirdText,
  });

  CustomMessageState createState() => CustomMessageState();
}

class CustomMessageState extends State<CustomMessage> {
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
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        child: SizedBox(
          width: 347,
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover, // ✅ Adjust image inside box
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mainText,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.subText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: greyText,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                widget.thirdText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: greyText,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
