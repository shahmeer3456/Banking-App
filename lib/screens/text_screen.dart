import 'package:bank/provider/text_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Provider Text Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter something...',
              ),
              onChanged: (value) {
                textProvider.updateText(value);
              },
            ),
            const SizedBox(height: 30),
            Text(
              textProvider.text.isEmpty
                  ? 'Type something above...'
                  : textProvider.text,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
