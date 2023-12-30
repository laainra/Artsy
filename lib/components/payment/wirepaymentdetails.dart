import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/components/priceFormat.dart';
import 'dart:io';

class WireForm extends StatefulWidget {
  final Map<String, dynamic> artwork;
  final ShippingInfo? shipping;
  final Function(PaymentInfo) onSavePayment;
  final TabController tabController;
  final UserModel? user;
  const WireForm({
    Key? key,
    required this.artwork,
    required this.shipping,
    required this.onSavePayment,
    required this.tabController,
    required this.user,
  }) : super(key: key);

  @override
  _WireFormState createState() => _WireFormState();
}

class _WireFormState extends State<WireForm> {
  final String paymentMethod = "Wire Transfer";
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
                  child: Text(PriceFormatter.formatPrice(widget.shipping!.shippingPrice.toString()) ?? 'No Shipping Fee',
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
    return Container(
      margin: EdgeInsets.all(13),
      color: Colors.white,
      child: Center(
        child: Column(
          // shrinkWrap: true,
          children: [
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Details',
                  style: TextStyle(fontSize: 26),
                ),
                Text(
                  "• To pay by wire transfer, complete checkout, and a member of the Artsy team will contact you with next steps by email.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  overflow: TextOverflow.clip,
                ),
                // SizedBox(height: 10),
                Text(
                  "• Please inform your bank that you will be responsible for all wire transfer fees.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  overflow: TextOverflow.clip,
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "• Questions? Email ",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      TextSpan(
                        text: "orders@artsy.net",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildArtworkInfo(),
                SizedBox(height: 10),
                buildProtectionInfo(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    String selectedPaymentMethod = "Wire Transfer";
                    // Call the callback function to pass shipping information
                    PaymentInfo paymentInfo = PaymentInfo(
                        // fullName: fullNameController.text,
                        // email: widget.user.email,
                        paymentMethod: selectedPaymentMethod);
                    // widget.onSaveAndContinue(paymentInfo)
                    widget.onSavePayment(paymentInfo);

                    // Beralih ke tab berikutnya menggunakan _tabController
                    widget.tabController.animateTo(2);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ReviewPage(
                    //         shipping: widget.shipping,
                    //         artwork: widget.artwork,
                    //         payment: paymentInfo),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(350, 45),
                  ),
                  child: Text(
                    "Save and Continue",
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
                          style: TextStyle(fontSize: 13),
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
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
