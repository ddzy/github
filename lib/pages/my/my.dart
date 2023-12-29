import 'package:flutter/material.dart';
import '../../components/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart'
    show CustomBottomNavigationBar;

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My',
        ),
      ),
      body: Text('My'),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
