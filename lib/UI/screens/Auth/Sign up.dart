import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/UI/components/Bottomnavigation.dart';
import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:e_commerce_firebase/UI/screens/Auth/Phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
   final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final Conformpassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  final firestore = FirebaseFirestore.instance.collection('Users');
  var isobscure;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    isobscure = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  Future<void> signinwithgoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Bottomnavigation()));
        ToastMessage().toastmessage(message: 'succusfully completed');
      }
    } catch (e) {
      ToastMessage().toastmessage(message: e.toString());
    }
  }

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
                    height: 10.h,
                  ),
                  Text(
                    'Create an \naccount!\n',
                    style: GoogleFonts.montserrat(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                   TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: name,
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
                        hintText: 'User name',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        )),
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Enter Your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: email,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
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
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: password,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF3F3F3),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF616161),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFA8A8A9)),
                            borderRadius: BorderRadius.circular(10.r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFA8A8A9)),
                            borderRadius: BorderRadius.circular(10.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFA8A8A9)),
                            borderRadius: BorderRadius.circular(10.r)),
                        hintText: 'password  ',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isobscure = !isobscure;
                              });
                            },
                            icon: isobscure
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: Color(0xFF616161),
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: Color(0xFF616161),
                                    size: 20,
                                  ))),
                    obscureText: isobscure,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6) {
                        return 'Enter a valid password!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller: Conformpassword,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF3F3F3),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF616161),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFA8A8A9)),
                            borderRadius: BorderRadius.circular(10.r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFA8A8A9)),
                            borderRadius: BorderRadius.circular(10.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFA8A8A9)),
                            borderRadius: BorderRadius.circular(10.r)),
                        hintText: 'Conform Password  ',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isobscure = !isobscure;
                              });
                            },
                            icon: isobscure
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: Color(0xFF616161),
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: Color(0xFF616161),
                                    size: 20,
                                  ))),
                    obscureText: isobscure,
                    validator: (passwords) {
                      if (passwords!.isEmpty || passwords.length < 6) {
                        return 'Enter a valid password!';
                      }
                      if (password.text != Conformpassword.text) {
                        return 'Check your password!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'By clicking the Register button, you agree\nto the public offe',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF676767),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          await auth
                              .createUserWithEmailAndPassword(
                                  email: email.text.toString(),
                                  password: password.text.toString())
                              .then(
                            (value) async {
                              firestore.doc(value.user!.uid.toString()).set({
                                "id": value.user!.uid.toString(),
                                "name": name.text.toString(),
                                "email": email.text.toString(),
                                "Profile": "",
                              });

                              setState(() {
                                loading = false;
                              });
                              ToastMessage()
                                  .toastmessage(message: 'Succesfull');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Bottomnavigation()));
                            },
                          ).onError(
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
                                borderRadius: BorderRadius.circular(4.r)),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              loading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'SIGN UP',
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
                  SizedBox(height: 30.h),
                  Center(
                    child: Text(
                      'OR Continue with -',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF575757),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Phone())),
                        child: Container(
                          width: 54.w,
                          height: 54.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFBF3F5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFF73658)),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          signinwithgoogle();
                        },
                        child: Container(
                          width: 54.w,
                          height: 54.h,
                          padding: const EdgeInsets.all(15),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                              color: Color(0xFFFBF3F5),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFFF73658)),
                                borderRadius: BorderRadius.circular(50),
                              )),
                          child: Image.asset(
                            'assets/images/img5.png',
                            height: 80.h,
                            width: 80.w,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height:15.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I Already Have an Account',
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF575757),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Sign_up()));
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                            decoration: TextDecoration.underline,
                            color: Color(0xFFF73658),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
