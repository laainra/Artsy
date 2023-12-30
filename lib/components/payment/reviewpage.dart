import 'package:artsy_prj/components/payment/paymentsuccess.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/model/transactionmodel.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';
import 'package:artsy_prj/components/priceFormat.dart';
import 'dart:io';

import '../../dbhelper.dart';

class ReviewPage extends StatefulWidget {
  final ShippingInfo? shipping;
  final PaymentInfo? payment;
  final UserModel? user;
  final Map<String, dynamic> artwork;

  const ReviewPage({
    Key? key,
    required this.shipping,
    required this.artwork,
    required this.payment,
    required this.user,
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
   Widget buildArtworkInfo() {
    String photoPath = widget.artwork['photos'];

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
            Text(widget.artwork["artistName"]!),
            SizedBox(height: 10),
            Text(
              widget.artwork["title"] +
                  ", " +
                  widget.artwork["year"].toString(),
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),
            Text(widget.artwork['galleryName'] ?? 'Unknown Gallery',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text("Location", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text(
                "Price " + PriceFormatter.formatPrice(widget.artwork['price'])),
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
                  child: Text(
                      PriceFormatter.formatPrice(widget.artwork['price']),
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
                  child: Text("Calculated in next steps",
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
                  child: Text("Calculated in next steps",
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
                  child: Text("Waiting for final costs",
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
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.check_circle),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your purchase is protected",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(text: "*Learn more about "),
                    TextSpan(
                      text: "Artsy's buyer protection. ",
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double calculateTotalAmount() {
    double artworkPrice = double.parse(widget.artwork["price"]);
    double shippingCost = widget.shipping != null
        ? (widget.shipping!.shippingPrice as double?) ?? 0.0
        : 0.0;

    // Add any additional costs or calculations here
    double additionalCosts = 0.0;

    // Calculate the total amount
    double totalAmount = artworkPrice + shippingCost + additionalCosts;

    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    // Review page UI
    return Material(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Review Purchase",
                style: TextStyle(fontSize: 26),
              ),
              SizedBox(
                height: 10,
              ),
              // if (shipping != null &&
              //     widget.shipping!.shippingMethod == "Shipping") ...[
              //   Container(
              //     padding: EdgeInsets.all(10),
              //     height: 220,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.grey,
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               "Ship to",
              //               style: TextStyle(fontSize: 13),
              //             ),
              //             Text(
              //               "Change",
              //               style: TextStyle(
              //                   fontSize: 13,
              //                   decoration: TextDecoration.underline),
              //             )
              //           ],
              //         ),
              //         Text('${widget.shipping!.fullName}'),
              //         Text('${widget.shipping!.addressLine1}'),
              //         Text('${widget.shipping!.addressLine2}'),
              //         Text(
              //             '${widget.shipping!.city}, ${widget.shipping!.state} ${widget.shipping!.postalCode}'),
              //         Text('${widget.shipping!.country}'),
              //         Text('${widget.shipping!.phoneNumber}'),
              //       ],
              //     ),
              //   ),
              // ],

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
                    if (widget.shipping != null &&
                        widget.shipping!.shippingMethod == "Shipping") ...[
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
                        '${widget.shipping!.fullName}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${widget.shipping!.addressLine1}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${widget.shipping!.addressLine2}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${widget.shipping!.city}, ${widget.shipping!.state} ${widget.shipping!.postalCode}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${widget.shipping!.country}',
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '${widget.shipping!.phoneNumber}',
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
              if (widget.shipping != null &&
                  widget.shipping!.shippingMethod == "Shipping") ...[
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
                            "Shipping",
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
                      //     widget.shipping!.shippingMethod == "Shipping") ...[

                      Text(
                          '${widget.shipping!.shippingOption} delivery (${PriceFormatter.formatPrice(widget.shipping!.shippingPrice.toString()) ?? 'No Shipping Fee'})'),

                      // ],
                    ],
                  ),
                ),
              ],
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
                    //     widget.shipping!.shippingMethod == "Shipping") ...[
                    Text('${widget.payment?.paymentMethod}'),
                    // ],
                  ],
                ),
              ),
              SizedBox(height: 10),
              buildArtworkInfo(),
              SizedBox(height: 10),
              buildProtectionInfo(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final TransactionModel transaction = TransactionModel(
                    userId: widget.user?.id as int, // Assuming userId is an int
                    artworkId: widget.artwork['id']
                        as int, // Set the artwork ID accordingly
                    paymentMethod: widget.payment?.paymentMethod,
                    amount:
                        calculateTotalAmount().toString(), // Implement this method to calculate the total amount
                    status:
                        'Pending', // You can set the initial status as needed
                    shippingMethod: widget.shipping?.shippingMethod,
                    description: 'Artwork Purchase',
                    address: widget.shipping != null
                        ? '${widget.shipping!.fullName}, ${widget.shipping!.phoneNumber}, ${widget.shipping!.addressLine1}, ${widget.shipping!.city}, ${widget.shipping!.state} ${widget.shipping!.postalCode}, ${widget.shipping!.country}'
                        : 'Pick up at Gallery', // Set the address based on shipping or pick up
                    createdAt: DateTime.now().toString(),
                  );
                  print('Transaction userId: ${transaction.userId}');
                  print('Transaction artworkId: ${transaction.artworkId}');
                  print(
                      'Transaction paymentMethod: ${transaction.paymentMethod}');
                  print('Transaction amount: ${transaction.amount}');
                  print('Transaction status: ${transaction.status}');
                  print(
                      'Transaction shippingMethod: ${transaction.shippingMethod}');
                  print('Transaction description: ${transaction.description}');
                  print('Transaction address: ${transaction.address}');
                  print('Transaction createdAt: ${transaction.createdAt}');
                  // Insert the transaction into the database
                  final DBHelper dbHelper = DBHelper();
                  // final int transactionId =
                      await dbHelper.insertTransaction(transaction);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentSuccessPage(
                              shipping: widget.shipping,
                              artwork: widget.artwork,
                              payment: widget.payment,
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
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              RichText(
                overflow: TextOverflow.clip,
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: "By clicking Submit, I agree to Artsy's ",
                      style: TextStyle(fontSize: 13),
                    ),
                    TextSpan(
                      text: 'Conditions of Sale',
                      style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              // if (shipping != null) ...[
              //   Text('Shipping Info:'),
              //   Text('Full Name: ${widget.shipping!.fullName}'),
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
