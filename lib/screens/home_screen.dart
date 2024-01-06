import 'package:diet_app/provider_model/home_tab_model.dart';
import 'package:diet_app/screens/home_screens/contact_screen.dart';
import 'package:diet_app/screens/home_screens/dashboard_screen.dart';
import 'package:diet_app/screens/home_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int selectedTab = context.watch<HomeTabModel>().selectedTab;

    List pages = const [DashboardScreen(), ProfileScreen(), ContactScreen()];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) => context.read<HomeTabModel>().updateSelectedTab(index),
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.green,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            backgroundColor: Colors.green,
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            backgroundColor: Colors.green,
            label: 'Contact',
          ),
        ],
      ),
      body: pages[selectedTab],
    );
  }
}
