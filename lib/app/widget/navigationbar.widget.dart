import 'package:flutter/material.dart';
import 'package:flutter_nov2026/app/views/contacts.screen.dart';
import 'package:flutter_nov2026/app/views/home.screen.dart';
import 'package:flutter_nov2026/app/views/layout.screen.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const MyHomePage(title: 'Home'),
        const LayoutScreen(),
        const Contacts()
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavDestinationWidget(
            mySelectedIcon: Icons.home, 
            myIcon: Icons.home_outlined, 
            myLabel: 'Home'
          ),
          NavDestinationWidget(
            mySelectedIcon: Icons.palette,
            myIcon: Icons.palette_outlined,
            myLabel: 'Layout',
          ),
           NavDestinationWidget(
            mySelectedIcon: Icons.person,
            myIcon: Icons.person_outlined,
            myLabel: 'Contacts',
          )
        ],
      ),
    );
  }
}

class NavDestinationWidget extends StatelessWidget {
  const NavDestinationWidget({
    super.key,
    required this.mySelectedIcon,
    required this.myIcon,
    required this.myLabel
  });

  final IconData mySelectedIcon;
  final IconData myIcon;
  final String myLabel;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      selectedIcon: Icon(mySelectedIcon, color: Colors.white),
      icon: Icon(myIcon),
      label: myLabel,
    );
  }
}