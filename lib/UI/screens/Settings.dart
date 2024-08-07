import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:e_commerce_firebase/UI/screens/Auth/Sign%20in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
   final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [IconButton(onPressed: (){  auth
                                  .signOut()
                                  .then(
                                    (value) => {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Sign_in()),
                                          (Route<dynamic> route) => false)
                                    },
                                  )
                                  .onError(
                                    (error, stackTrace) => ToastMessage()
                                        .toastmessage(
                                            message: error.toString()),
                                  );}, icon: Icon(Icons.logout))],),);
  }
}