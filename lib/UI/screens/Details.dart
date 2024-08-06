import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Details extends StatefulWidget {
    final String img;
  final String discount;
  final String about;
  final String name;
  final String Price;
  final String offer;
  final double star;
  final int index;
  const Details({super.key, required this.img, required this.discount, required this.about, required this.name, required this.Price, required this.offer, required this.star, required this.index});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int currentindex = 0;
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
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
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
                            color: Colors.black,
                            image: DecorationImage(
                              image: NetworkImage(widget.img[index].toString()),
                              fit: BoxFit.fill,
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
                      count: 3,
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
            Text(
              'NIke Sneakers',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Vision Alta Men’s Shoes Size (All Colours)',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            RatingBar.builder(
              itemSize: 18,
              initialRating: 3,
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
                  '₹2500',
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
                  '₹999',
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
                  '50%Off',
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
              'Perhaps the most iconic sneaker of all-time, this original "Chicago"? colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the',
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
                      Text(
                        'Go to cart',
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
