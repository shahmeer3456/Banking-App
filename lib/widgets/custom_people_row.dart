import 'package:bank/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomPeopleRow extends StatefulWidget {
  final String topLeftText;
  final String topRightText;
  final Function(int?)? onIndexSelected;
  int? selectedIndex;

  CustomPeopleRow({
    required this.topLeftText,
    required this.topRightText,
    this.selectedIndex,
    this.onIndexSelected,
  });

  @override
  CustomPeopleRowState createState() => CustomPeopleRowState();
}

class CustomPeopleRowState extends State<CustomPeopleRow> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.selectedIndex = -1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      height: 200,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.topLeftText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: greyText,
                ),
              ),
              Text(
                widget.topRightText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Card(
                elevation: 1,
                child: Container(
                  width: 102,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.add_outlined),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedIndex = widget.selectedIndex == 1 ? -1 : 1;
                    if (widget.onIndexSelected != null) {
                      widget.onIndexSelected!(widget.selectedIndex == -1 ? null : 1);
                    }
                  });
                },
                child: Card(
                  elevation: 1,
                  child: Container(
                    width: 102,
                    height: 140,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 1 ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/person.png',
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Emma",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: widget.selectedIndex == 1
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selectedIndex = widget.selectedIndex == 2 ? -1 : 2;
                    if (widget.onIndexSelected != null) {
                      widget.onIndexSelected!(widget.selectedIndex == -1 ? null : 2);
                    }
                  });
                },
                child: Card(
                  elevation: 1,
                  child: Container(
                    width: 102,
                    height: 140,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 2 ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/person2.png',
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Justin",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: widget.selectedIndex == 2
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }
}
