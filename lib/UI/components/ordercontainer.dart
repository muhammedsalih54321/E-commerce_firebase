import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Ordercontainer extends StatelessWidget {
   final List<dynamic> img;
  final String discount;
 
  final String title;
  final String Price;
  final String offer;
  final String id;
  final double star;
  final String rating;
  final String date;
  final int index;
  const Ordercontainer({super.key, required this.img, required this.discount, required this.title, required this.Price, required this.offer, required this.id, required this.star, required this.index, required this.date, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 331.w,
      height: 191.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 14,
            offset: Offset(0, 6),
            spreadRadius: -8,
          ),
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 9,
            offset: Offset(0, -4),
            spreadRadius: -7,
          )
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 130.53.w,
                height: 125.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r)),
                ),
                child: Image.network(img[0]),
              ),
              SizedBox(width: 4.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    title,
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
                        date,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -1.10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        rating,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          height: 0.15,
                        ),
                      ),
                      RatingBar.builder(
                        itemSize: 15,
                        initialRating:star,
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 84.w,
                        height: 29.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.30, color: Color(0xFFCACACA)),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            ' ₹${offer}',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              height: 0.09,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        children: [
                          Text(
                            'upto ${discount}off',
                            style: GoogleFonts.plusJakartaSans(
                              color: Color(0xFFEA3030),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              height: 0.34,
                            ),
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          Text(
                            '₹${Price}',
                            style: GoogleFonts.plusJakartaSans(
                              color: Color(0xFFA6A6A6),
                              fontSize: 12.sp,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                              height: 0.15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Divider(
            thickness: .5,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Order (1)   :',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 0.15,
                  ),
                ),
                Text(
                  ' ₹${offer}',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: 0.15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
