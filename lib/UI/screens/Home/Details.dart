import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:e_commerce_firebase/UI/screens/Cart.dart';
import 'package:e_commerce_firebase/UI/screens/Home/Buy%20now.dart';
import 'package:e_commerce_firebase/UI/screens/Wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Details extends StatefulWidget {
  final List<dynamic> img;
  final String discount;
  final String about;
  final String title;
  final String Price;
  final String offer;
  final double star;
  final int index;
  final String id;
  const Details(
      {super.key,
      required this.img,
      required this.discount,
      required this.about,
      required this.title,
      required this.Price,
      required this.offer,
      required this.star,
      required this.index,
      required this.id});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int currentindex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool favourate = false;
  bool loading = false;
  final firestorecollection = FirebaseFirestore.instance.collection('Users');
  @override
  void initState() {
    checkFavourate();

    super.initState();
  }

  Future<void> checkFavourate() async {
    final firestoreCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('favouratecourse');

    QuerySnapshot querySnapshot = await firestoreCollection.get();

    // Get data from docs and convert map to List

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['id'].toString() == widget.id.toString()) {
        print("item found");
        setState(() {
          favourate = true;
        });
      } else {
        print("item not found");
      }
    }

    // print("hi"+querySnapshot.docs.map((e){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Cart()));
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 235.h,
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: widget.img.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Container(
                          width: 340.w,
                          height: 213.h,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.img[index].toString()),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
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
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                      count: widget.img.length,
                      effect: WormEffect(
                          dotHeight: 10.h,
                          dotWidth: 10.w,
                          radius: 10.r,
                          dotColor: Color.fromARGB(255, 205, 201, 201),
                          activeDotColor: Color(0xFFFFA3B3)),
                    ),
                  ],
                )),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title.toString(),
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    height: 0.06,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      checkFavourate();
                      if (favourate == true) {
                        firestorecollection
                            .doc(auth.currentUser!.uid.toString())
                            .collection("favouratecourse")
                            .doc(widget.id.toString())
                            .delete()
                            .then(
                          (value) {
                          
                            setState(() {
                              favourate = false;
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            ToastMessage()
                                .toastmessage(message: error.toString());
                          },
                        );
                      } else {
                        firestorecollection
                            .doc(auth.currentUser!.uid.toString())
                            .collection("favouratecourse")
                            .doc(widget.id.toString())
                            .set({
                          "id": widget.id.toString(),
                          "title": widget.title.toString(),
                          "Thumnail": widget.img,
                          "rating": widget.star.toString(),
                          "about": widget.about.toString(),
                          "price": widget.Price.toString(),
                          "offer": widget.offer.toString(),
                          "discount": widget.discount.toString()
                        }).then(
                          (value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                              content: Text('Go to Wish list'),
                              action: SnackBarAction(
                                  label: 'Wish List',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Wishlist()));
                                  }),
                            ));
                           
                          },
                        ).onError(
                          (error, stackTrace) {
                            ToastMessage()
                                .toastmessage(message: error.toString());
                          },
                        );
                      }
                    },
                    icon: favourate == true
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border_outlined))
              ],
            ),
            RatingBar.builder(
              itemSize: 18,
              initialRating: double.parse(widget.star.toString()),
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
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Text(
                  '₹${widget.Price.toString()}',
                  style: GoogleFonts.montserrat(
                    decoration: TextDecoration.lineThrough,
                    color: Color(0xFF808488),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 0.11,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  '₹${widget.offer.toString()}',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 0.11,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  widget.discount.toString(),
                  style: GoogleFonts.montserrat(
                    color: Color(0xFFFE735C),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 0.16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              'Product Details',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 0.08,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.about.toString(),
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  loading = true;
                });
                firestorecollection
                    .doc(auth.currentUser!.uid.toString())
                    .collection("cartcourse")
                    .doc(widget.id.toString())
                    .set({
                  "id": widget.id.toString(),
                  "title": widget.title.toString(),
                  "Thumnail": widget.img,
                  "rating": widget.star.toString(),
                  "about": widget.about.toString(),
                  "price": widget.Price.toString(),
                  "offer": widget.offer.toString(),
                  "discount": widget.discount.toString()
                }).then(
                  (value) {
                       setState(() {
                  loading = false;
                });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                              content: Text('Go to Cart Page'),
                              action: SnackBarAction(
                                  label: 'Cart Page',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Cart()));
                                  }),
                            ));
                  },
                ).onError(
                  (error, stackTrace) {
                    ToastMessage().toastmessage(message: error.toString());
                  },
                );
              },
              child: Container(
                  width: double.infinity.w,
                  height: 55.h,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF3E92FF), Color(0xFF0B3689)],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r)),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loading
                          ? CircularProgressIndicator()
                          : Text(
                              'Add to cart',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                    ],
                  ))),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Buynow(
                          img: widget.img,
                          discount: widget.discount.toString(),
                          about: widget.about.toString(),
                          title: widget.title.toString(),
                          Price: widget.Price.toString(),
                          offer: widget.offer.toString(),
                          star: double.parse(widget.star.toString()),
                          index: widget.index,
                          id: widget.id.toString()))),
              child: Container(
                  width: double.infinity.w,
                  height: 55.h,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF70F8A8), Color(0xFF31B669)],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r)),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Buy Now',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )
                    ],
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
