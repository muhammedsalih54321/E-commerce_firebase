import 'package:e_commerce_firebase/UI/components/Bottomnavigation.dart';
import 'package:e_commerce_firebase/UI/components/Toastmessage.dart';
import 'package:e_commerce_firebase/UI/screens/Auth/Forgotpassword.dart';
import 'package:e_commerce_firebase/UI/screens/Auth/Phone.dart';
import 'package:e_commerce_firebase/UI/screens/Auth/Sign%20up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final email = TextEditingController();
  final password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  var isobscure;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    isobscure = true;
    super.initState();
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Bottomnavigation()));
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
                    height: 40.h,
                  ),
                  Text(
                    'Welcome \nBack!\n',
                    style: GoogleFonts.montserrat(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: email,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF616161),
                        ),
                        filled: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.w, color: Color(0xFFA8A8A9)), borderRadius: BorderRadius.circular(10.r)),
                        fillColor: Color(0xFFF3F3F3),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.w, color: Color(0xFFA8A8A9)), borderRadius: BorderRadius.circular(10.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
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
                  SizedBox(
                    height: 2.h,
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
                            borderSide:
                                BorderSide(width: 1.w, color: Color(0xFFA8A8A9)), borderRadius: BorderRadius.circular(10.r)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.w, color: Color(0xFFA8A8A9)
                                ),
                                 borderRadius: BorderRadius.circular(10.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Forgotpassword()));
                          },
                          child: Text(
                            'Forget Password?',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFFF73658),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.24,
                            ),
                          ))
                    ],
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
                          await auth
                              .signInWithEmailAndPassword(
                                  email: email.text.toString(),
                                  password: password.text.toString())
                              .then(
                                (value) => {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => Bottomnavigation())),
                                  setState(() {
                                    loading = false;
                                  }),
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
                                borderRadius: BorderRadius.circular(4.r)),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              loading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'LOGIN',
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
                    height: 30.h,
                  ),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Phone())),
                        child: Container(
                          width: 54.w,
                          height: 54.h,
                          padding: const EdgeInsets.all(15),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFBF3F5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFFF73658)),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                          ),
                          child: Icon(
                            Icons.phone,
                            color: Colors.black,
                            size: 28.sp,
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
                          width: 54,
                          height: 54,
                          padding: const EdgeInsets.all(15),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                              color: Color(0xFFFBF3F5),
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(width: 1, color: Color(0xFFF73658)),
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
                    height: 30.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create An Account',
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
                          ' Sign up',
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
