import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatelessWidget {
  final Function(int)? onTap;
  final int initialIndex; // Add initialIndex parameter

  const BottomNavigation({
    Key? key,
    this.onTap,
    this.initialIndex = 0, // Default to 0 if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double iconSize = screenWidth * 0.07;
    double paddingSize = screenWidth * 0.015;
    
    final List<Widget> navigationItems = [
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          'assets/images/menu1.svg',
          width: 20,
          height: 20,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          'assets/images/home.svg',
          width: 20,
          height: 20,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          'assets/images/menu2.svg',
          width: 20,
          height: 20,
        ),
      ),
    ];

    return CurvedNavigationBar(
      index: initialIndex, // Set the initial index here
      height: 60,
      color: Colors.black,
      items: navigationItems,
      backgroundColor: Colors.transparent,
      animationDuration: Duration(milliseconds: 300),
      onTap: onTap,
    );
  }
}
