import 'package:bank/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/counter_provider.dart';
import '../provider/form_provider.dart';
import '../provider/slider_provider.dart';
import '../provider/switch_provider.dart';
import '../provider/task_provider.dart';

class ThemeScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  double value = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider1>(context);
    final sliderProvider = Provider.of<SliderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Toggle me"),
              value: themeProvider.isOn,
              onChanged: (newVal) {
                themeProvider.changeTheme(newVal);
              },
            ),
            SizedBox(height: 12),

            Container(
              height: 50,
              width: 347,
              decoration: BoxDecoration(
                color: themeProvider.isOn ? Colors.blue : Colors.brown,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              width: 347,
              decoration: BoxDecoration(
                color: themeProvider.isOn ? Colors.brown : Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              width: 347,
              decoration: BoxDecoration(
                color: themeProvider.isOn ? Colors.blue : Colors.brown,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              width: 347,
              decoration: BoxDecoration(
                color: themeProvider.isOn ? Colors.brown : Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              width: 347,
              decoration: BoxDecoration(
                color: themeProvider.isOn ? Colors.blue : Colors.brown,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              width: 347,
              decoration: BoxDecoration(
                color: themeProvider.isOn ? Colors.brown : Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 12),

            SwitchListTile(
              value: sliderProvider.isEnable,
              onChanged: (newVal) {
                sliderProvider.changeState(newVal);
              },
              title: Text("Activate slider"),
            ),
            if (sliderProvider.isEnable) ...[
              Slider(
                value: sliderProvider.sliderValue,
                onChanged: (val) {
                  sliderProvider.changeSlider(val);
                },
                min: 0,
                max: 100,
                divisions: 100,
              ),
              Container(
                width: sliderProvider.sliderValue*4,
                height: sliderProvider.sliderValue*2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: themeProvider.isOn?Colors.blue:Colors.brown,
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
