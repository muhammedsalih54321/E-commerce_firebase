import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_firebase/UI/screens/Home/Details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final favourate = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('favouratecourse')
        .snapshots();
    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('favouratecourse');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Wishlist',
            style: GoogleFonts.montserrat(
              color: Color(0xFF1D1B20),
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              height: 0.05,
              letterSpacing: 0.20,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: StreamBuilder<QuerySnapshot>(
                stream: favourate,
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
                    print('loaded');
                    return GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                           childAspectRatio: 237 / 400,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Details(
                                          img: snapshot.data!.docs[index]
                                              ['Thumnail'],
                                          discount: snapshot
                                              .data!.docs[index]['discount']
                                              .toString(),
                                          about: snapshot
                                              .data!.docs[index]['about']
                                              .toString(),
                                          title: snapshot
                                              .data!.docs[index]['title']
                                              .toString(),
                                          Price: snapshot
                                              .data!.docs[index]['price']
                                              .toString(),
                                          offer: snapshot
                                              .data!.docs[index]['offer']
                                              .toString(),
                                          star: double.parse(snapshot
                                              .data!.docs[index]['rating']
                                              .toString()),
                                          index: index,
                                          id: snapshot.data!.docs[index]['id']
                                              .toString(),
                                        ))),
                            child: Container(
                              width: 170.w,
                              height: 241.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 170.w,
                                    height: 124.h,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.r)),
                                    ),
                                    child: Image.network(snapshot
                                        .data!.docs[index]['Thumnail'][0]),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['title']
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 0.11,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    maxLines: 2,
                                    snapshot.data!.docs[index]['about']
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    '₹${snapshot.data!.docs[index]['offer'].toString()}',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 0.11,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${snapshot.data!.docs[index]['price'].toString()}',
                                        style: GoogleFonts.montserrat(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Color(0xFF808488),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w300,
                                          height: 0.11,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['discount']
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                          color: Color(0xFFFE735C),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 0.16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RatingBar.builder(
                                        itemSize: 15,
                                        initialRating: double.parse(snapshot
                                            .data!.docs[index]['rating']
                                            .toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            ref
                                                .doc(
                                                  snapshot
                                                      .data!.docs[index]["id"]
                                                      .toString(),
                                                )
                                                .delete();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return SizedBox();
                  }
                })));
  }
}
