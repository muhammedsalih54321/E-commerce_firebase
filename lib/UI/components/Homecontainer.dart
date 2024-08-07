import 'package:e_commerce_firebase/UI/screens/Home/Details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Homecontainer extends StatelessWidget {
  final List<dynamic> img;
  final String discount;
  final String about;
  final String title;
  final String Price;
  final String offer;
  final String id;
  final double star;
  final int index;

  const Homecontainer(
      {super.key,
      required this.img,
      required this.about,
      required this.title,
      required this.Price,
      required this.offer,
      required this.star,
      required this.index,
    required this.discount, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Details(img: img, discount: discount, about: about, title: title, Price: Price, offer: offer, star: star, index: index, id: id,))),
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
                    borderRadius: BorderRadius.circular(4.r)),
              ),
               child: Image.network(img[0]),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              title,
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
              about,
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
              '₹${offer}',
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
                  '₹${Price}',
                  style: GoogleFonts.montserrat(
                    decoration: TextDecoration.lineThrough,
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
                  discount,
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
            RatingBar.builder(
              itemSize: 15,
              initialRating: star,
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
      ),
    );
  }
}
