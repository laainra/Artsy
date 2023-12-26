import 'package:artsy_prj/components/payment/paymentsuccess.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';

class ReviewPage extends StatelessWidget {
  final ShippingInfo? shipping;
  final PaymentInfo? payment;
  final Map<String, dynamic> artwork;

  const ReviewPage({
    Key? key,
    required this.shipping,
    required this.artwork,
    required this.payment,
  }) : super(key: key);

  Widget buildArtworkInfo() {
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
            Image.asset(artwork["image"][0], height: 100),
            SizedBox(height: 10),
            Text(artwork["artist"]),
            SizedBox(height: 10),
            Text(
              artwork["title"] + ", " + artwork["year"].toString(),
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),
            Text(
              artwork["gallery"],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text("Location", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text("Price " + artwork["price"]),
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
                  child: Text(artwork["price"],
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
              //     shipping!.shippingMethod == "Shipping") ...[
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
              //         Text('${shipping!.fullName}'),
              //         Text('${shipping!.addressLine1}'),
              //         Text('${shipping!.addressLine2}'),
              //         Text(
              //             '${shipping!.city}, ${shipping!.state} ${shipping!.postalCode}'),
              //         Text('${shipping!.country}'),
              //         Text('${shipping!.phoneNumber}'),
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
              if (shipping != null &&
                  shipping!.shippingMethod == "Shipping") ...[
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
                      //     shipping!.shippingMethod == "Shipping") ...[

                      Text(
                          '${shipping!.shippingOption} delivery (USD${shipping!.shippingPrice})'),

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
                    //     shipping!.shippingMethod == "Shipping") ...[
                    Text('${payment?.paymentMethod}'),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentSuccessPage(
                              shipping: shipping,
                              artwork: artwork,
                              payment: payment,
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
