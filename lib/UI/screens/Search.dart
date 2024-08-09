import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_firebase/UI/components/searchcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  SpeechToText _speechToText = SpeechToText();
  final search = TextEditingController();
  var islistening = false;
  bool _speechEnabled = false;

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    print('init');
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
    print('start');
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    print('stop');
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      search.text = result.recognizedWords;
    });
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  final Serachcollection =
      FirebaseFirestore.instance.collection('Deal of the day').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TextFormField(
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            setState(() {});
          },
          controller: search,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFFBBBBBB),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(3),
                child: AvatarGlow(
                  animate: islistening,
                  duration: Duration(milliseconds: 200),
                  glowColor: Colors.black,
                  repeat: true,
                  glowCount: 2,
                  curve: Curves.bounceIn,
                  glowShape: BoxShape.circle,
                  child: GestureDetector(
                    onTap: _speechToText.isNotListening
                        ? _startListening
                        : _stopListening,
                    child: CircleAvatar(
                      radius: 5.r,
                      backgroundColor: Colors.black,
                      child: Center(
                        child: Icon(
                          _speechToText.isNotListening
                              ? Icons.mic_off
                              : Icons.mic,
                          color: Color(0xFFBBBBBB),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              filled: true,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
                  borderRadius: BorderRadius.circular(6.r)),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
                  borderRadius: BorderRadius.circular(6.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.w, color: Color(0xFFA8A8A9)),
                  borderRadius: BorderRadius.circular(6.r)),
              hintText: 'Search any Product',
              hintStyle: GoogleFonts.montserrat(
                color: Color(0xFFBBBBBB),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0.10,
              )),
          validator: (search) {
            if (search!.isEmpty) {
              return 'type any thing';
            }
            return null;
          },
        ),
      ),
      Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: Serachcollection,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('error'),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final name =
                          snapshot.data!.docs[index]["title"].toString();
                      if (search.text.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Searchcontainer(
                            img: snapshot.data!.docs[index]['Thumnail'],
                            about:
                                snapshot.data!.docs[index]['about'].toString(),
                            title:
                                snapshot.data!.docs[index]['title'].toString(),
                            Price:
                                snapshot.data!.docs[index]['price'].toString(),
                            offer:
                                snapshot.data!.docs[index]['offer'].toString(),
                            star: double.parse(snapshot
                                .data!.docs[index]['rating']
                                .toString()),
                            index: index,
                            discount: snapshot.data!.docs[index]['discount']
                                .toString(),
                            id: snapshot.data!.docs[index]['id'].toString(),
                          ),
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(search.text.toLowerCase().toLowerCase())) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Searchcontainer(
                            img: snapshot.data!.docs[index]['Thumnail'],
                            about:
                                snapshot.data!.docs[index]['about'].toString(),
                            title:
                                snapshot.data!.docs[index]['title'].toString(),
                            Price:
                                snapshot.data!.docs[index]['price'].toString(),
                            offer:
                                snapshot.data!.docs[index]['offer'].toString(),
                            star: double.parse(snapshot
                                .data!.docs[index]['rating']
                                .toString()),
                            index: index,
                            discount: snapshot.data!.docs[index]['discount']
                                .toString(),
                            id: snapshot.data!.docs[index]['id'].toString(),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return SizedBox();
                }
              })),
    ])));
  }
}
