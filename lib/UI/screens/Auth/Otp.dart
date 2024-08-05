import 'package:e_commerce_firebase/UI/components/Bottomnavigation.dart';
import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Otp extends StatefulWidget {
  final String verificationid;
  const Otp({super.key, required this.verificationid});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final Otp = TextEditingController();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            'Otp \nScreen?\n',
                            style: GoogleFonts.montserrat(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: Otp,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.w, color: Color(0xFFDDDDDD))),
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.w, color: Color(0xFFDDDDDD))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.w, color: Color(0xFFDDDDDD)),
                                    borderRadius: BorderRadius.circular(5)),
                                hintText: 'Enter Otp',
                                hintStyle: GoogleFonts.poppins(
                                  color: Color(0xFF7C7C7C),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 0.10,
                                )),
                            validator: (Phone) {
                              if (Phone!.isEmpty || Phone.length < 6) {
                                return 'Enter your Otp';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        
                          SizedBox(
                            height: 50.h,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  final crendital =
                                      PhoneAuthProvider.credential(
                                          verificationId: widget.verificationid,
                                          smsCode: Otp.text.toString());
                                  try {
                                    await auth.signInWithCredential(crendital);
                                    setState(() {
                                      loading = false;
                                    });
                                  } catch (e) {
                                    ToastMessage()
                                        .toastmessage(message: e.toString());
                                  }
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Bottomnavigation()));
                                }
                              },
                              child: Container(
                                  width: 317.w,
                                  height: 55.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF73658),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r)),
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loading
                                          ? CircularProgressIndicator()
                                          : Text(
                                              'VERIFY',
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
                          ),
                          SizedBox(height: 40),
                        ]))))));
  }
}
