import 'package:e_commerce_firebase/UI/screens/Auth/Sign%20in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    void onIntroEnd(context) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Sign_in()),
      );
    }

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xE0E0E0),
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Text(
            'Choose Products',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              height: 0,
            ),
          ),
          bodyWidget: Text(
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Color(0xFFA8A8A9),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.28,
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: 220.h,
              ),
              Center(
                child: Container(
                    width: 300.w,
                    height: 215.92.h,
                    child: Image.asset('assets/images/img2.png')),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            'Make Payment',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              height: 0,
            ),
          ),
          bodyWidget: Text(
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Color(0xFFA8A8A9),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.28,
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: 220.h,
              ),
              Center(
                child: Container(
                    width: 299.53.w,
                    height: 194.19.h,
                    child: Image.asset('assets/images/img3.png')),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            'Get Your Order',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              height: 0,
            ),
          ),
          bodyWidget:  Text(
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Color(0xFFA8A8A9),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.28,
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: 220.h,
              ),
              Center(
                child: Container(
                    width: 350.w,
                    height: 242.52.h,
                    child: Image.asset('assets/images/img4.png')),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
      ],
      onDone: () {
        onIntroEnd(context);
      },
      onSkip: () {
        onIntroEnd(context);
      },
      showSkipButton: true,
      showBackButton: false,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      back: Text(
        'Prev',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Colors.grey,
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
      ),
      next: Text(
        'Next',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Color(0xFFF73658),
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
      ),
      done: Text(
        'Get Started',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Color(0xFFF73658),
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    );
  }
}
