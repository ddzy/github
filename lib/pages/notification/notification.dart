import 'package:flutter/material.dart';
import '../../components/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart'
    show CustomBottomNavigationBar;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
        ),
        // iconTheme: const IconThemeData(color: Colors.white),
        // actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Text('Notification'),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
