import 'package:flutter/material.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty(
      {super.key,
      this.width = 150,
      this.height = 150,
      this.description = 'No Data...'});

  final double width;
  final double height;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset(
            'assets/images/empty.png',
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
