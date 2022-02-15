import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String? payload;

  const SecondPage({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Notifikasi'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset(
              'assets/motion_lab_logo.png',
            ),
            Text(
              payload ?? '',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Payload',
            ),
          ],
        ),
      ),
    );
  }
}
