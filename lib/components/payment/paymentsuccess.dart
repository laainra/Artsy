import 'package:artsy_prj/components/home/home.dart';
import 'package:artsy_prj/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';
import 'dart:math';
import 'package:artsy_prj/components/priceFormat.dart';
import 'package:artsy_prj/screens/formlogin.dart';
import 'dart:io';

class PaymentSuccessPage extends StatelessWidget {
  final UserModel? user;
  final ShippingInfo? shipping;
  final PaymentInfo? payment;
  final Map<String, dynamic> artwork;

  const PaymentSuccessPage({
    Key? key,
    required this.user,
    required this.shipping,
    required this.artwork,
    required this.payment,
  }) : super(key: key);

  double calculateTotalAmount() {
    double artworkPrice = double.parse(artwork["price"]);
    double shippingCost =
        shipping != null ? (shipping!.shippingPrice as double?) ?? 0.0 : 0.0;

    double totalAmount = artworkPrice + shippingCost + taxAmount();

    return totalAmount;
  }

  double taxAmount() {
    double artworkPrice = double.parse(artwork["price"]);
    double shippingCost =
        shipping != null ? (shipping!.shippingPrice as double?) ?? 0.0 : 0.0;

    double tax = 0.11 * (artworkPrice + shippingCost);

    return tax;
  }

  Widget buildArtworkInfo() {
    String photoPath = artwork['photos'];

    Widget imageWidget;

    if (photoPath.startsWith('assets/images')) {
      imageWidget = Image.asset(
        photoPath,
        height: 120,
        // You can add more properties here if needed
      );
    } else if (photoPath.startsWith(
        '/storage/emulated/0/Android/data/com.example.artsy_prj/files/')) {
      imageWidget = Image.file(
        File(photoPath),
        height: 120,
        // You can add more properties here if needed
      );
    } else {
      // Handle other cases or provide a default image
      imageWidget = Placeholder();
    }
    return Container(
      width: 365,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      // margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            imageWidget,
            SizedBox(height: 10),
            Text(artwork["artistName"]!),
            SizedBox(height: 10),
            Text(
              artwork["title"] + ", " + artwork["year"].toString(),
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),
            Text(artwork['galleryName'] ?? 'Unknown Gallery',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text("Location", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text("Price " + PriceFormatter.formatPrice(artwork['price'])),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  width: 80,
                  child: Text(
                    "Price",
                    style: TextStyle(color: Colors.grey),
                  )),
              Container(
                  width: 200,
                  child: Text(PriceFormatter.formatPrice(artwork['price']),
                      style: TextStyle(color: Colors.grey)))
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  width: 80,
                  child: Text(
                    "Shipping",
                    style: TextStyle(color: Colors.grey),
                  )),
              Container(
                  width: 200,
                  child: Text(
                      PriceFormatter.formatPrice(
                              shipping!.shippingPrice.toString()) ??
                          'No Shipping Fee',
                      style: TextStyle(color: Colors.grey)))
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  width: 80,
                  child: Text(
                    "Tax*",
                    style: TextStyle(color: Colors.grey),
                  )),
              Container(
                  width: 200,
                  child: Text(
                      PriceFormatter.formatPrice(taxAmount().toString()),
                      style: TextStyle(color: Colors.grey)))
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  width: 80,
                  child: Text(
                    "Total",
                    style: TextStyle(color: Colors.grey),
                  )),
              Container(
                  width: 200,
                  child: Text(
                      PriceFormatter.formatPrice(
                          calculateTotalAmount().toString()),
                      style: TextStyle(color: Colors.grey)))
            ]),
            SizedBox(
              height: 15,
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    children: [
                  TextSpan(text: "*Additional duties and taxes "),
                  TextSpan(
                      text: "may apply at import ",
                      style: TextStyle(decoration: TextDecoration.underline)),
                ])),
            SizedBox(height: 10),
            // Add more details as needed
          ],
        ),
      ),
    );
  }

  Widget buildProtectionInfo() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Color.fromARGB(186, 215, 215, 215)),
      width: 365,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.check_circle),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Congratulations! This artwork will be addressed to your Collection once the gallery confirms the order.",
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "View and manage all artworks in your Collection through your ",
                      ),
                      TextSpan(
                        text: "profile. ",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getDayAfterToday() {
    DateTime today = DateTime.now();
    DateTime dayAfterToday = today.add(Duration(days: 1));

    // Use DateFormat if you want to format the day name
    // Example: import 'package:intl/intl.dart';
    // String formattedDay = DateFormat('EEEE').format(dayAfterToday);

    return dayAfterToday.weekday == 7
        ? 'Sunday'
        : dayAfterToday.weekday == 1
            ? 'Monday'
            : dayAfterToday.weekday == 2
                ? 'Tuesday'
                : dayAfterToday.weekday == 3
                    ? 'Wednesday'
                    : dayAfterToday.weekday == 4
                        ? 'Thursday'
                        : dayAfterToday.weekday == 5
                            ? 'Friday'
                            : 'Saturday';
  }

  int generateRandomOrderNumber() {
    Random random = Random();
    return random.nextInt(900000000) + 100000000;
  }

  @override
  Widget build(BuildContext context) {
    // Review page UI
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(
              "X",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w100,
              ),
            ),
            onPressed: () {
              // Function to go back to the previous page
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          "Purchase",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.topLeft,
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 110,
                  height: 80,
                ),
              ),
              Text(
                "Thank you, your order has been submitted",
                style: TextStyle(fontSize: 26),
                overflow: TextOverflow.clip,
              ),
              Text("Order #${generateRandomOrderNumber()}"),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Color.fromARGB(186, 215, 215, 215)),
                width: 365,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Icon(Icons.check_circle),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You will receive a confirmation email by ${getDayAfterToday()}",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              buildArtworkInfo(),
              SizedBox(height: 10),
              buildProtectionInfo(),
              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.all(15),
                height: 225,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (shipping != null &&
                        shipping!.shippingMethod == "Shipping") ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ship to",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(
                            "Change",
                            style: TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                      Text(
                        '${shipping!.fullName}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${shipping!.addressLine1}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${shipping!.addressLine2}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${shipping!.city}, ${shipping!.state} ${shipping!.postalCode}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${shipping!.country}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${shipping!.phoneNumber}',
                        overflow: TextOverflow.clip,
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pick up (Location of Gallery)",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Change",
                            style: TextStyle(
                                fontSize: 13,
                                decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                      Text(
                        "After your order is confirmed, a specialist will contact yo to cordinate pickup.",
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(15),
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Change",
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    // if (shipping != null &&
                    //     shipping!.shippingMethod == "Shipping") ...[
                    Text('${payment?.paymentMethod}'),
                    // ],
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              user: user,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(350, 45),
                ),
                child: Text(
                  "Back To Home",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "Need Help? ",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextSpan(
                        text: 'Visit our help center',
                        style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' or '),
                      TextSpan(
                        text: 'ask a question',
                        style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // if (shipping != null) ...[
              //   Text('Shipping Info:'),
              //   Text('Full Name: ${shipping!.fullName}'),
              // Text('k ${payment?.paymentMethod ?? 'N/A'}'),
              // Text('kj ${shipping?.shippingMethod ?? 'N/A'}'),
              // Text('kj ${shipping?.shippingOption ?? 'N/A'}'),
              // Text('kj ${shipping?.shippingPrice ?? 'N/A'}'),

              // ] else
              //   ...[],
              // Text('Artwork Info: ${artwork.toString()}'),
              // if (payment != null) ...[
              //   Text('Payment Info:'),
              // Text('Nama: ${payment!.fullName}'),
              // ] else ...[
              //   Text('Wire Transfer')
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
