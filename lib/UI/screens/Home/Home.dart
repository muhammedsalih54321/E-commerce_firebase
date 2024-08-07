import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/UI/components/Homecontainer.dart';
import 'package:e_commerce_firebase/UI/screens/Home/Deal%20of%20the%20day.dart';
import 'package:e_commerce_firebase/UI/screens/Home/Trending%20Products.dart';
import 'package:e_commerce_firebase/UI/screens/Home/categories.dart';
import 'package:e_commerce_firebase/UI/screens/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final search = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance.collection('Beauty').snapshots();
  final firestore2 =
      FirebaseFirestore.instance.collection('banners').snapshots();
  final firestore3 =
      FirebaseFirestore.instance.collection('Deal of the day').snapshots();
      final firestore4 =
      FirebaseFirestore.instance.collection('Trending Product').snapshots();
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            CupertinoIcons.line_horizontal_3_decrease,
            color: Colors.black,
          ),
          centerTitle: true,
          title: Image.asset(
            'assets/images/img6.png',
            height: 100.h,
            width: 110.w,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: IconButton(onPressed: (){
                 Navigator.push(context,MaterialPageRoute(builder: (_)=>Orders()));
              }, icon: Icon(Icons.account_balance_wallet_rounded))
            )
          ],
          bottom: Tab(
            height: 80.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Form(
                key: formKey,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: search,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFBBBBBB),
                      ),
                      suffixIcon: Icon(
                        Icons.mic_none_rounded,
                        color: Color(0xFFBBBBBB),
                      ),
                      filled: true,
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
                          borderRadius: BorderRadius.circular(6.r)),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
                          borderRadius: BorderRadius.circular(6.r)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
                          borderRadius: BorderRadius.circular(6.r)),
                      hintText: 'Search any Product',
                      hintStyle: GoogleFonts.montserrat(
                        color: Color(0xFFBBBBBB),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      )),
                  validator: (search) {
                    if (search!.isEmpty) {
                      return 'type any thing';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'All Features',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0.07),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 70.h,
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firestore,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('error'),
                            );
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.w, right: 5.h),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Categories(product: snapshot.data!.docs[index]['Products'],))),
                                    child: Container(
                                      height: 80.h,
                                      width: 56.w,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 25.r,
                                            backgroundImage: NetworkImage(snapshot
                                                .data!.docs[index]['Thumnail']
                                                .toString()),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['title']
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                              color: Color(0xFF21003D),
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              height: 0.16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 220.h,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firestore2,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('error'),
                            );
                          }
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                CarouselSlider.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context, int index,
                                      int realIndex) {
                                    return Container(
                                      height: 189.h,
                                      width: 340.w,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]['img']
                                              .toString()),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    reverse: false,
                                    height: 189.h,
                                    enlargeCenterPage: true,
                                    autoPlay: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    viewportFraction: 1.5.sp,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentindex = index;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                AnimatedSmoothIndicator(
                                  activeIndex: currentindex,
                                  count: snapshot.data!.docs.length,
                                  effect: WormEffect(
                                      dotHeight: 10.h,
                                      dotWidth: 10.w,
                                      radius: 10.r,
                                      dotColor:
                                          Color.fromARGB(255, 205, 201, 201),
                                      activeDotColor: Color(0xFFFFA3B3)),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        })),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 343.w,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFF4392F8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Deal of the Day',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 0.08,
                          ),
                        ),
                        GestureDetector(
                           onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Dealoftheday())),
                          child: Container(
                            width: 89.w,
                            height: 28.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.h,
                            ),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'View all',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                  size: 20.sp,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 241.h,
                  child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: firestore3,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('error'),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:  EdgeInsets.only(right: 10.w),
                                    child: Homecontainer(
                                        img: snapshot
                                            .data!.docs[index]['Thumnail']
                                            ,
                                        about: snapshot.data!.docs[index]['about']
                                            .toString(),
                                        title: snapshot.data!.docs[index]['title']
                                            .toString(),
                                        Price: snapshot.data!.docs[index]['price']
                                            .toString(),
                                        offer: snapshot.data!.docs[index]['offer']
                                            .toString(),
                                        star: double.parse(snapshot
                                            .data!.docs[index]['rating']
                                            .toString()),
                                        index: index,
                                        discount: snapshot
                                            .data!.docs[index]['discount']
                                            .toString(), id:snapshot
                                            .data!.docs[index]['id']
                                            .toString() ,),
                                  );
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          })),
                ),
                SizedBox(
                  height: 10.h,
                ),
                 SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 343.w,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFC6D86),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trending Products',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 0.08,
                          ),
                        ),
                        GestureDetector(
                             onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Trendingproducts())),
                          child: Container(
                            width: 89.w,
                            height: 28.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.h,
                            ),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'View all',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 0.11,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color: Colors.white,
                                  size: 20.sp,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 241.h,
                  child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: firestore4,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('error'),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:  EdgeInsets.only(right: 10.w),
                                    child: Homecontainer(
                                        img: snapshot
                                            .data!.docs[index]['Thumnail']
                                           ,
                                        about: snapshot.data!.docs[index]['about']
                                            .toString(),
                                        title: snapshot.data!.docs[index]['title']
                                            .toString(),
                                        Price: snapshot.data!.docs[index]['price']
                                            .toString(),
                                        offer: snapshot.data!.docs[index]['offer']
                                            .toString(),
                                        star: double.parse(snapshot
                                            .data!.docs[index]['rating']
                                            .toString()),
                                        index: index,
                                        discount: snapshot
                                            .data!.docs[index]['discount']
                                            .toString(), id:snapshot
                                            .data!.docs[index]['id']
                                            .toString(),),
                                  );
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          })),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ));
  }
}
