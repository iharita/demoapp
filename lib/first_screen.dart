import 'package:demoapp/screens/community_screen.dart';
import 'package:demoapp/screens/home_screen.dart';
import 'package:demoapp/screens/liked_screen.dart';
import 'package:demoapp/screens/saved_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LikedListScreen(),
    CommunityScreen(),
    SaveScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black87,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: (index){
              _onItemTapped(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Liked',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Saved',
              ),
            ],
          ),
    )
    );
  }
}