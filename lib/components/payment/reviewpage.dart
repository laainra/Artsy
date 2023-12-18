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

  @override
  Widget build(BuildContext context) {
    // Review page UI
    return Material(
      child: Container(
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ship to",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          "Change",
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    if (shipping != null &&
                        shipping!.shippingMethod == "Shipping") ...[
                      Text('${shipping!.fullName}'),
                      Text('${shipping!.addressLine1}'),
                      Text('${shipping!.addressLine2}'),
                      Text(
                          '${shipping!.city}, ${shipping!.state} ${shipping!.postalCode}'),
                      Text('${shipping!.country}'),
                      Text('${shipping!.phoneNumber}'),
                    ],
                  ],
                ),
              ),
              if (shipping != null &&
                  shipping!.shippingMethod == "Shipping") ...[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping",
                            style: TextStyle(fontSize: 13),
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
                          '${shipping!.shippingOption} delivery (${shipping!.shippingPrice})'),

                      // ],
                    ],
                  ),
                ),
              ],
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: [
                    if (shipping != null &&
                        shipping!.shippingMethod == "Shipping") ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ship to",
                            style: TextStyle(fontSize: 13),
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
                            style: TextStyle(fontSize: 13),
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
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(fontSize: 13),
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
              ElevatedButton(
                onPressed: () {
//
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(350, 45),
                ),
                child: const Text(
                  "submit",
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
              Text('k ${payment?.paymentMethod ?? 'N/A'}'),
              Text('kj ${shipping?.shippingMethod ?? 'N/A'}'),
              Text('kj ${shipping?.shippingOption ?? 'N/A'}'),
              Text('kj ${shipping?.shippingPrice ?? 'N/A'}'),

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
