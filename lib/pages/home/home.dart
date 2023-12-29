import 'package:flutter/material.dart';
import '../../components/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart' show CustomBottomNavigationBar;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
