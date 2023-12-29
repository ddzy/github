import 'package:flutter/material.dart';
import '../../components/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart'
    show CustomBottomNavigationBar;

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExplorePageState();
  }
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
        ),
        // iconTheme: const IconThemeData(color: Colors.white),
        // actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Text('Explore'),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
