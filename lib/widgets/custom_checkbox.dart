import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String checkBoxText;
  String? spanText;
  final Color textColorFirst;
  Color? textColorSecond;
  final Function(bool)? onChanged;



  CustomCheckBox({
    required this.checkBoxText,
    required this.textColorFirst,
    this.spanText,
    this.textColorSecond,
    this.onChanged,
    super.key,
  });

  @override
  CustomCheckBoxState createState() => CustomCheckBoxState();
}

class CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked= false;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              isChecked = newValue ?? false;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(isChecked); // notify parent
            }
          },
        ),
        Expanded(
          child: RichText(
            maxLines: 2,
            text: TextSpan(
            text: widget.checkBoxText,
            style: TextStyle(color: widget.textColorFirst,fontSize: 11.99,
            fontWeight: FontWeight.w600),
              children: <TextSpan> [
                TextSpan(
                  text: widget.spanText,
                  style: TextStyle(
                    color: widget.textColorSecond,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  )
                )
              ]
            ),

          ),
        ),

      ],
    );
  }
}
