import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/UI/components/Bottomnavigation.dart';
import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;

  final firestorecollection = FirebaseFirestore.instance.collection('Users');
  final date = DateTime.now().add(Duration(days: 7));
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    firestorecollection
        .doc(auth.currentUser!.uid.toString())
        .collection("order")
        .doc(widget.id.toString())
        .set({
      "id": widget.id.toString(),
      "stutus":"Order Placed",
      'date':
          '${date.day.toString()} ${DateFormat('MMM').format(date)} ${date.year.toString()}',
      "title": widget.title.toString(),
      "Thumnail": widget.img,
      "rating": widget.star.toString(),
      "about": widget.about.toString(),
      "price": widget.Price.toString(),
      "offer": widget.offer.toString(),
      "discount": widget.discount.toString()
    }).then(
      (value) {
       
      },
    ).onError(
      (error, stackTrace) {
        ToastMessage().toastmessage(message: error.toString());
      },
    );

    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });

        return AlertDialog(
            title: CircleAvatar(
              backgroundColor: Color(0xFFF73658),
              radius: 40.r,
              child: Center(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
            ),
            content: Text(
              'Payment done successfully.',
              style: GoogleFonts.montserrat(
                color: Color(0xFF222222),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 0.14,
              ),
            ));
      },
    ).then(
      (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Bottomnavigation()));
      },
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                  onTap: () {
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_test_gKANZdsNdLqaQs',
                      'amount': 100,
                      'name': 'Acme Corp.',
                      'description': 'Fine T-Shirt',
                      'retry': {'enabled': true, 'max_count': 1},
                      'send_sms_hash': true,
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'test@razorpay.com'
                      },
                      'external': {
                        'wallets': ['paytm']
                      }
                    };
                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                        handlePaymentErrorResponse);
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        handlePaymentSuccessResponse);
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                        handleExternalWalletSelected);
                    razorpay.open(options);
                  },
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
