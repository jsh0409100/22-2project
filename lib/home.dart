import 'package:Midterm/chatroom.dart';
import 'package:Midterm/savedPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';
import 'detail.dart';
import 'myPage.dart';
import 'itemAdd.dart';
import 'applicationState.dart';
import 'feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'alert.dart';

final isSelected = <bool>[false, true];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  /*void navi(int index){
    switch(index) {
      case 0: {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => feed(),
          ),
        );
      }
      break;
      case 1: {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      }
      break;
      case 2: {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      }
      break;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Community', style: TextStyle(fontFamily: 'Cooper')),
        actions:  <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              semanticLabel: 'cart',
            ),
            onPressed: () {
              print('cart button');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => savedPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              semanticLabel: 'cart',
            ),
            onPressed: () {
              print('cart button');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RandomWords(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              semanticLabel: 'logout',
            ),
            onPressed: () async {
              print('Logout button');
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lime.shade600,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex, //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  final List _widgetOptions = [
    const feed(),
    const FriendlyChatApp(),
    const ProfilePage(),
  ];
}





