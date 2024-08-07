import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase/UI/components/Homecontainer.dart';
import 'package:flutter/material.dart';

class Dealoftheday extends StatefulWidget {
  const Dealoftheday({super.key});

  @override
  State<Dealoftheday> createState() => _DealofthedayState();
}

class _DealofthedayState extends State<Dealoftheday> {
  final firestore3 =
      FirebaseFirestore.instance.collection('Deal of the day').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore3,
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
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 280 / 400,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Homecontainer(
                          img: snapshot.data!.docs[index]['Thumnail'],
                          about: snapshot.data!.docs[index]['about'].toString(),
                          title: snapshot.data!.docs[index]['title'].toString(),
                          Price: snapshot.data!.docs[index]['price'].toString(),
                          offer: snapshot.data!.docs[index]['offer'].toString(),
                          star: double.parse(
                              snapshot.data!.docs[index]['rating'].toString()),
                          index: index,
                          discount:
                              snapshot.data!.docs[index]['discount'].toString(),
                          id: snapshot.data!.docs[index]['id'].toString(),
                        );
                      });
                } else {
                  return SizedBox();
                }
              })),
    );
  }
}
