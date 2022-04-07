import 'package:flutter/material.dart';
import 'package:library_app/account_screen.dart';
import 'package:library_app/bookmark_screen.dart';
import 'package:library_app/event_screen.dart';
import 'package:library_app/homepage_screen.dart';
import 'package:library_app/kids_profile_screen.dart';
import 'package:library_app/super_base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends Superbase<HomeScreen> {

  int _index = 0;

  final _bookmarkKey = GlobalKey<BookmarkScreenState>();


  List<Widget> get widgets {
    var items = <Widget>[
      HomepageScreen(),
      BookmarkScreen(key: _bookmarkKey),
      const EventScreen(),
      const AccountScreen(),
    ];

    if (isFamily) {
      items.insert(3, const KidsProfileScreen());
    }

    return items;
  }


  List<BottomNavigationBarItem> get items {
    var c = Theme
        .of(context)
        .primaryColor;
    int x = isFamily ? 4 : 3;
    var items = [
      BottomNavigationBarItem(icon: Image.asset(
          "assets/home_icon.png", color: _index == 0 ? c : Colors.grey),
          label: "Home"),
      BottomNavigationBarItem(icon: Image.asset(
          "assets/bookmark_icon.png", color: _index == 1 ? c : Colors.grey),
          label: "My Books"),
      BottomNavigationBarItem(icon: Image.asset(
          "assets/events.png", color: _index == 2 ? c : Colors.grey),
          label: "Events"),
      BottomNavigationBarItem(icon: Image.asset(
          "assets/setting_icon.png", color: _index == x ? c : Colors.grey),
          label: "Settings"),
    ];

    if (isFamily) {
      items.insert(3, BottomNavigationBarItem(icon: Image.asset(
          "assets/kids2.png", color: _index == 3 ? c : Colors.grey),
          label: "My Kids"),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: widgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
            if (_index == 1) {
              _bookmarkKey.currentState?.reload();
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        items:items,
      ),
    );
  }
}