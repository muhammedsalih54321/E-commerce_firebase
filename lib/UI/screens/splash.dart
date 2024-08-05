import 'dart:async';

import 'package:e_commerce_firebase/UI/components/Bottomnavigation.dart';
import 'package:e_commerce_firebase/UI/screens/Auth/Sign%20in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
    void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Bottomnavigation())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Sign_in())));
    }
  }

  @override
  void initState() {
    islogin(context);
    super.initState();
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/img1.png' ,width: 274.99.w,
          height: 100.h,),),
    );
  }
}