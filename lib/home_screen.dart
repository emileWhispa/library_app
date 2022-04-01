import 'package:flutter/material.dart';
import 'package:library_app/account_screen.dart';
import 'package:library_app/event_screen.dart';
import 'package:library_app/homepage_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var c = Theme.of(context).primaryColor;
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomepageScreen(),
          Center(),
          EventScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Image.asset("assets/home_icon.png",color: _index == 0 ? c : Colors.grey),label: "Home"),
          BottomNavigationBarItem(icon: Image.asset("assets/bookmark_icon.png",color: _index == 1 ? c : Colors.grey),label: "My Books"),
          BottomNavigationBarItem(icon: Image.asset("assets/events.png",color: _index == 2 ? c : Colors.grey),label: "Events"),
          BottomNavigationBarItem(icon: Image.asset("assets/setting_icon.png",color: _index == 3 ? c : Colors.grey),label: "Settings"),
        ],
      ),
    );
  }
}