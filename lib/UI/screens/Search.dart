import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_firebase/UI/components/searchcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final search = TextEditingController();
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
              suffixIcon: Icon(Icons.search_rounded),
              filled: true,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 1.w, color: Color(0xFFDDDDDD)),
              ),
              hintText: 'Serch ...',
              hintStyle: GoogleFonts.poppins(
                color: Color(0xFF7C7C7C),
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              )),
          validator: (email) {
            if (email!.isEmpty) {
              return 'Search Here';
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
