import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network(
                'https://st4.depositphotos.com/5686152/27322/v/450/depositphotos_273220330-stock-illustration-sorry-page-not-found-404.jpg'),
            FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.keyboard_arrow_left_sharp),
                label: Text('')),
          ],
        ),
      ),
    );
  }
}
