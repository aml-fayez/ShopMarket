import 'package:buy/screens/bottomnavbar/cartscreen.dart';
import 'package:buy/screens/bottomnavbar/login.dart';
import 'package:flutter/material.dart';
import 'package:buy/screens/bottomnavbar/home.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> {
  int current = 0;

List<Widget> screens = [
  HomePage(),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon:Icon(Icons.home_outlined,color: Colors.black),
          label:'Home',
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.add,color: Colors.black),
          label:'Add',
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.book_outlined,color: Colors.black),
          label:'Book Mark',
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.person_outline,color: Colors.black),
          label:'Profile',
        ),
      ],
      onTap: (index){
        setState(() {
          current=index;
        });  
       },
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 20.0),
        selectedIconTheme: IconThemeData(color: Colors.black, size: 20.0),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
      ),
     body:screens[current]
    );
  }
}
  