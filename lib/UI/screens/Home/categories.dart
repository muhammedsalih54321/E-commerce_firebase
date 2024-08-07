import 'package:e_commerce_firebase/UI/components/Homecontainer.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final List<dynamic> product;
  const Categories({super.key, required this.product});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
        child: GridView.builder(
            itemCount: widget.product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 280 / 400,
                crossAxisSpacing: 6,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Homecontainer(
                img: widget.product[index]['Thumnail'],
                about: widget.product[index]['about'].toString(),
                title: widget.product[index]['title'].toString(),
                Price: widget.product[index]['price'].toString(),
                offer: widget.product[index]['offer'].toString(),
                star: double.parse(widget.product[index]['rating']),
                index: index,
                discount: widget.product[index]['discount'].toString(),
                id: widget.product[index]['id'].toString(),
              );
            }),
      ),
    );
  }
}
