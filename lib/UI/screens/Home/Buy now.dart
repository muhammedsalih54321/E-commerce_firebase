import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Buynow extends StatefulWidget {
  final List<dynamic> img;
  final String discount;
  final String about;
  final String title;
  final String Price;
  final String offer;
  final double star;
  final int index;
  final String id;
  const Buynow(
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
  State<Buynow> createState() => _BuynowState();
}

class _BuynowState extends State<Buynow> {
  final date = DateTime.now().add(Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shopping Bag',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            height: 0.09,
            letterSpacing: -0.41,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity.w,
              height: 153.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 123.w,
                    height: 153.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r)),
                    ),
                    child: Image.network(widget.img[0]),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        widget.title,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 0.09,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: 170.w,
                        child: Text(
                          maxLines: 2,
                          widget.about,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            maxLines: 2,
                            'Delivery by ',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            maxLines: 2,
                            '${date.day.toString()} ${DateFormat('MMM').format(date)} ${date.year.toString()}',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -1.10,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    Image.asset(
                      'assets/images/img8.png',
                      height: 30.h,
                      width: 40.w,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      'Apply Coupons',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: -0.70,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Select',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFFF73658),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.70,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Divider(
              thickness: .5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              'Order Payment Details',
              style: GoogleFonts.montserrat(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: -0.70,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Amount',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.70,
                  ),
                ),
                Text(
                  '₹${widget.offer}',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    Text(
                      'Convenience',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.70,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Know more',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFF73658),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Apply Coupon',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFFE91611),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Fee',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.70,
                  ),
                ),
                Text(
                  'Free',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFFF73658),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Divider(
              thickness: .5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Total',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.70,
                  ),
                ),
                Text(
                  '₹${widget.offer}',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Wrap(
              children: [
                Text(
                  'EMI Available',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.70,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Details',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFFF73658),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Divider(
              thickness: .5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${widget.offer}',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    Text(
                      'View Details',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFF73658),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                
                  child: Container(
                      width: 219.w,
                      height: 48.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF73658),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proceed to Payment',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 17.sp,
                              height: 0.08,
                              letterSpacing: -0.41,
                            ),
                          )
                        ],
                      ))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
