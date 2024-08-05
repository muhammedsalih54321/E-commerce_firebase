import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:e_commerce_firebase/UI/screens/Auth/Otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final Phone = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

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
                            'Phone \nAuthentication!\n',
                            style: GoogleFonts.montserrat(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: Phone,
                            maxLength: 10,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                prefix: Text(
                                  '+91 ',
                                  style: TextStyle(color: Colors.black),
                                ),
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
                                hintText: 'Phone Number',
                                hintStyle: GoogleFonts.poppins(
                                  color: Color(0xFF7C7C7C),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 0.10,
                                )),
                            validator: (Phone) {
                              if (Phone!.isEmpty || Phone.length < 10) {
                                return 'Enter your mobile number';
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
                                  auth.verifyPhoneNumber(
                                    phoneNumber: "+91${Phone.text.toString()}",
                                    verificationCompleted: (_) {
                                      setState(() {
                                        loading = true;
                                      });
                                    },
                                    verificationFailed: (error) {
                                      ToastMessage().toastmessage(
                                          message: error.toString());
                                    },
                                    codeSent: (String verificationId,
                                        int? token) async {
                                      // final signature = await SmsAutoFill().getAppSignature;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Otp(
                                                    verificationid:
                                                        verificationId,
                                                  )));
                                    },
                                    codeAutoRetrievalTimeout: (error) {
                                      ToastMessage().toastmessage(
                                          message: error.toString());
                                    },
                                  );
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
                                              'SUBMIT',
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
