import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';
import 'package:artsy_prj/model/paymentmodel.dart';

class BankForm extends StatefulWidget {
  final Map<String, dynamic> artwork;
  final ShippingInfo? shipping;
  final Function(PaymentInfo) onSavePayment;
  final TabController tabController;
  const BankForm({
    Key? key,
    required this.artwork,
    required this.shipping,
    required this.onSavePayment,
    required this.tabController,
  }) : super(key: key);
  @override
  _BankFormState createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  final fullNameController = TextEditingController();

  final emailController = TextEditingController();
  final bankController = TextEditingController();
  bool saveBankForLaterUse = false;
  // String selectedPaymentMethod = "Bank Transfer";

  bool isFormFilled() {
    return fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        bankController.text.isNotEmpty; // Add this line
  }

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
            Image.asset(widget.artwork["image"][0], height: 100),
            SizedBox(height: 10),
            Text(widget.artwork["artist"]),
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
            Text(
              widget.artwork["gallery"],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text("Location", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Text("Price " + widget.artwork["price"]),
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
                  child: Text(widget.artwork["price"],
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
    // Shipping page UI
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
                SizedBox(height: 10),
                buildPaymentForm(),
                SizedBox(height: 10),
                buildArtworkInfo(),
                SizedBox(height: 10),
                buildProtectionInfo(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    String selectedPaymentMethod = "Bank Transfer";
                    PaymentInfo paymentInfo = PaymentInfo(
                        fullName: fullNameController.text,
                        email: emailController.text,
                        bankAcc: bankController.text,
                        paymentMethod: selectedPaymentMethod);
                    // widget.onSaveAndContinue(paymentInfo)
                    widget.onSavePayment(paymentInfo);

                    // Beralih ke tab berikutnya menggunakan _tabController
                    widget.tabController.animateTo(2);

                    // Call the callback function to pass shipping information
                    //                     Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ReviewPage(
                    //       shipping: widget.shipping,
                    //       artwork: widget.artwork,
                    //       payment: paymentInfo,
                    //     ),
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
          ], // Removed the extra square bracket here
        ),
      ),
    );
  }

  Widget buildPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTextField("Email", emailController, "Your Email"),
        buildTextField("Full Name", fullNameController, "Your Full Name"),
        buildTextField("Bank Account", bankController, "Your Bank Account"),
        Row(
          children: [
            Checkbox(
              value: saveBankForLaterUse,
              onChanged: (value) {
                setState(() {
                  saveBankForLaterUse = value!;
                });
              },
            ),
            Text("Save bank account for later use"),
          ],
        ),
      ],
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
