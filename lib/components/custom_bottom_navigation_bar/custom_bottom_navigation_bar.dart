import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomBottomNavigationBarState();
  }
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentActiveNavIndex = 0;

  final List<_NavItem> _navList = [
    const _NavItem(
        id: '/home',
        label: 'Home',
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home)),
    const _NavItem(
        id: '/notification',
        label: 'Notification',
        icon: Icon(Icons.notification_add_outlined),
        activeIcon: Icon(Icons.notification_add)),
    const _NavItem(
        id: '/explore',
        label: 'Explore',
        icon: Icon(Icons.explore_outlined),
        activeIcon: Icon(Icons.explore)),
    const _NavItem(
        id: '/profile',
        label: 'Proifle',
        icon: Icon(Icons.person_2_outlined),
        activeIcon: Icon(Icons.person_2)),
  ];

  List<BottomNavigationBarItem> _buildNavItem(BuildContext context) {
    final path =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
    final activeIndex = _navList.indexWhere((element) => element.id == path);

    setState(() {
      _currentActiveNavIndex = activeIndex;
    });

    return List<BottomNavigationBarItem>.from(_navList.map((e) =>
        BottomNavigationBarItem(
            icon: e.icon, label: e.label, activeIcon: e.activeIcon)));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentActiveNavIndex,
      items: _buildNavItem(context),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (value) {
        setState(() {
          _currentActiveNavIndex = value;
        });
      },
    );
  }
}

class _NavItem {
  const _NavItem(
      {required this.label,
      required this.icon,
      required this.activeIcon,
      required this.id});

  final String label;
  final Icon icon;
  final Icon activeIcon;
  final String id;
}
