import 'package:bank/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String mainTitle;
  final String subTitle;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;

  const CustomContainer({
    required this.mainTitle,
    required this.subTitle,
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
    super.key,
  });

  @override
  CustomContainerState createState() => CustomContainerState();
}

class CustomContainerState extends State<CustomContainer> {
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
      elevation: 1,
      color: Colors.white,
      child: SizedBox(
        width: 347,
        height: 110,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween
            ,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26,),
                  Text(
                    widget.mainTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8,),

                  Text(
                    widget.subTitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: greyText,
                    ),
                  ),
                ],
              ),
              //SizedBox(width: 116,),
              Center(
                child: Image.asset(widget.imagePath, width: widget.imageWidth, height: widget.imageHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
