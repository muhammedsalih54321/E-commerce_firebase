import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/UI/components/ordercontainer.dart';
import 'package:e_commerce_firebase/UI/screens/Home/ordertracking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final order = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('order')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            height: 0.09,
            letterSpacing: -0.41,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder<QuerySnapshot>(
              stream: order,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('loading');

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  print('No data');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  );
                }
                if (snapshot.hasError) {
                  print('Error');
                  return Center(
                    child: Text('error'),
                  );
                }
                if (snapshot.hasData) {
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 20.h),
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Ordertracking(Tracker:snapshot.data!.docs[index]['stutus'].toString(),))),
                          child: Ordercontainer(
                            img: snapshot.data!.docs[index]['Thumnail'],
                            title: snapshot.data!.docs[index]['title'].toString(),
                            Price: snapshot.data!.docs[index]['price'].toString(),
                            offer: snapshot.data!.docs[index]['offer'].toString(),
                            star: double.parse(
                                snapshot.data!.docs[index]['rating'].toString()),
                            index: index,
                            discount:
                                snapshot.data!.docs[index]['discount'].toString(),
                            id: snapshot.data!.docs[index]['id'].toString(),
                            date: snapshot.data!.docs[index]['date'].toString(),
                            rating: snapshot.data!.docs[index]['rating'].toString(),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox();
                }
              })),
    );
  }
}
