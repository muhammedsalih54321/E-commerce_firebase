import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_tracker/order_tracker.dart';

class Ordertracking extends StatefulWidget {
  final String Tracker;
  const Ordertracking({super.key, required this.Tracker});

  @override
  State<Ordertracking> createState() => _OrdertrackingState();
}

class _OrdertrackingState extends State<Ordertracking> {
  late Status status;
  @override
  void initState() {
    checkStatus();

    super.initState();
  }

  void checkStatus() {
    if (widget.Tracker == "Order Placed") {
      status = Status.order;
    }
    if (widget.Tracker == "Shipped") {
      status = Status.shipped;
    }
    if (widget.Tracker == "Out of delevery") {
      status = Status.outOfDelivery;
    }
    if (widget.Tracker == "Delivered") {
      status = Status.delivered;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextDto> orderList = [
      TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
      TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
      TextDto("Your item has been picked up by courier partner.",
          "Tue, 29th Mar '22 - 5:00pm"),
    ];

    List<TextDto> shippedList = [
      TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
      TextDto("Your item has been received in the nearest hub to you.", null),
    ];

    List<TextDto> outOfDeliveryList = [
      TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
    ];

    List<TextDto> deliveredList = [
      TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Tracker',
          style: GoogleFonts.montserrat(
            color: Color(0xFF1D1B20),
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            height: 0.05,
            letterSpacing: 0.20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: OrderTracker(
          status: status,
          activeColor: Colors.green,
          inActiveColor: Colors.grey[300],
          orderTitleAndDateList: orderList,
          shippedTitleAndDateList: shippedList,
          outOfDeliveryTitleAndDateList: outOfDeliveryList,
          deliveredTitleAndDateList: deliveredList,
        ),
      ),
    );
  }
}
