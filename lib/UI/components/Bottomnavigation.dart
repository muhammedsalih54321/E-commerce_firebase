
import 'package:e_commerce_firebase/UI/screens/Cart.dart';
import 'package:e_commerce_firebase/UI/screens/Home.dart';
import 'package:e_commerce_firebase/UI/screens/Search.dart';
import 'package:e_commerce_firebase/UI/screens/Settings.dart';
import 'package:e_commerce_firebase/UI/screens/Wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  final screen = [Home(), Wishlist(), Cart(), search(), Settings()];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFF73658),
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled,
                  color: currentindex == 0 ?Color(0xFFF73658): Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: currentindex == 1 ? Color(0xFFF73658) : Colors.black,
                ),
                label: 'Wishlist'),
            BottomNavigationBarItem(
                icon: Container( width: 53.85.w,
                  height: 56.h,
                  decoration: ShapeDecoration(
                    color: currentindex == 2 ? Color(0xFFF73658): Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x16000000),
                        blurRadius: 14,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child:Center(child:  Icon(Icons.shopping_cart_outlined,
                    color: currentindex == 2 ? Colors.white : Colors.black),) ,
                  ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded,
                    color: currentindex == 3 ? Color(0xFFF73658) : Colors.black),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined,
                    color: currentindex == 4 ? Color(0xFFF73658) : Colors.black),
                label: 'Settings'),
          ]),
      body: screen[currentindex],
    );
  }
}
