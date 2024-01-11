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
  int _currentActiveIndex = 0;

  @override
  void initState() {
    // 设置默认选中
    final path = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
    final defaultActiveIndex = _navList.indexWhere((element) => element.id == path);
    _currentActiveIndex = defaultActiveIndex == -1 ? 0 : defaultActiveIndex;

    super.initState();
  }

  final List<_NavItem> _navList = [
    const _NavItem(
      id: '/home',
      label: '首页',
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
    ),
    const _NavItem(
      id: '/notification',
      label: '通知',
      icon: Icon(Icons.notification_add_outlined),
      activeIcon: Icon(Icons.notification_add),
    ),
    const _NavItem(
      id: '/explore',
      label: '探索',
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
    ),
    const _NavItem(
      id: '/my',
      label: '我的',
      icon: Icon(Icons.person_2_outlined),
      activeIcon: Icon(Icons.person_2),
    ),
  ];

  List<NavigationDestination> _buildNavItems(BuildContext context) {
    return List<NavigationDestination>.from(
      _navList.map(
        (e) => NavigationDestination(
          icon: e.icon,
          label: e.label,
          selectedIcon: e.activeIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: _buildNavItems(context),
      selectedIndex: _currentActiveIndex,
      onDestinationSelected: (value) {
        setState(() {
          _currentActiveIndex = value;
          GoRouter.of(context).replace(_navList[_currentActiveIndex].id);
        });
      },
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.id,
  });

  final String label;
  final Icon icon;
  final Icon activeIcon;
  final String id;
}
