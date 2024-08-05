import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final forgot = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  bool loading = false;
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
                            'Forgot \nPassword?\n',
                            style: GoogleFonts.montserrat(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: forgot,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xFF616161),
                                ),
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.w, color: Color(0xFFA8A8A9)),
                                    borderRadius: BorderRadius.circular(10.r)),
                                fillColor: Color(0xFFF3F3F3),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.w, color: Color(0xFFA8A8A9)),
                                    borderRadius: BorderRadius.circular(10.r)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.w, color: Color(0xFFA8A8A9)),
                                    borderRadius: BorderRadius.circular(10.r)),
                                hintText: 'email address',
                                hintStyle: GoogleFonts.poppins(
                                  color: Color(0xFF7C7C7C),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 0.10,
                                )),
                            validator: (email) {
                              if (email!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(email)) {
                                return 'Enter a valid email!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            '* We will send you a message to set or reset\nyour new password',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF676767),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Center(
                            child: GestureDetector(
                               onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await auth
                            .sendPasswordResetEmail(
                                email: forgot.text.toString())
                            .then(
                              (value) => {
                                ToastMessage().toastmessage(
                                    message:
                                        'Send your email for  Recover password'),
                                Navigator.pop(context)
                              },
                            )
                            .onError(
                              (error, stackTrace) => ToastMessage()
                                  .toastmessage(message: error.toString()),
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
