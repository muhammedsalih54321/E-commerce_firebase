import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/UI/components/Bottomnavigation.dart';
import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:e_commerce_firebase/UI/screens/Home/Details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final firestorecollection = FirebaseFirestore.instance.collection('Users');
  final date = DateTime.now().add(Duration(days: 7));
  final auth = FirebaseAuth.instance;
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    print('hello');
    final firestoreCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('cartcourse');

    QuerySnapshot querySnapshot = await firestoreCollection.get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      firestorecollection
          .doc(auth.currentUser!.uid.toString())
          .collection("order")
          .doc(querySnapshot.docs[i]['id'].toString())
          .set({
        "id": querySnapshot.docs[i]['id'].toString(),
        "stutus": "Order Placed",
        'date':
            '${date.day.toString()} ${DateFormat('MMM').format(date)} ${date.year.toString()}',
        "title": querySnapshot.docs[i]['title'].toString(),
        "Thumnail": querySnapshot.docs[i]['Thumnail'],
        "rating": querySnapshot.docs[i]['rating'].toString(),
        "about": querySnapshot.docs[i]['about'].toString(),
        "price": querySnapshot.docs[i]['price'].toString(),
        "offer": querySnapshot.docs[i]['offer'].toString(),
        "discount": querySnapshot.docs[i]['discount'].toString()
      }).then(
        (value) {
          ToastMessage().toastmessage(message: 'added');
        },
      ).onError(
        (error, stackTrace) {
          ToastMessage().toastmessage(message: error.toString());
        },
      );
    }

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
    final auth = FirebaseAuth.instance;
    final cart = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('cartcourse')
        .snapshots();
    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('cartcourse');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart',
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
              stream: cart,
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
                  dynamic sum = 0;
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    sum = sum +
                        double.parse(
                            snapshot.data!.docs[i]['offer'].toString());
                  }
                  print('loaded');
                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                              id: snapshot
                                                  .data!.docs[index]['id']
                                                  .toString(),
                                            ))),
                                child: Container(
                                  width: 170.w,
                                  height: 241.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            snapshot
                                                .data!.docs[index]['discount']
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
                                                      snapshot.data!
                                                          .docs[index]["id"]
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
                            }),
                      ),
                      Container(
                        height: 60.h,
                        width: double.infinity.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${sum.toString()}',
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF1D1B20),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                height: 0.05,
                                letterSpacing: 0.20,
                              ),
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
                                  width: 200.w,
                                  height: 48.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF73658),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Place Order',
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
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              })),
    );
  }
}
