import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';

class ShippingForm extends StatefulWidget {
  final Map<String, dynamic> artwork;
  final TabController tabController;
  final Function(ShippingInfo) onSaveAndContinue;
  const ShippingForm({
    Key? key,
    required this.artwork,
    required this.onSaveAndContinue,
    required this.tabController,
  }) : super(key: key);
  @override
  _ShippingFormState createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final stateController = TextEditingController();
  final postalController = TextEditingController();
  bool isShippingSelected = true;
  bool isPrioritySelected = false;
  bool isStandartSelected = false;
  String selectedCountry = '';
  bool saveAddressForLaterUse = false;
  String selectedDeliveryMethod = '';
  String selectedShippingOption = '';
  int selectedShippingPrice = 0;

  bool isFormFilled() {
    return fullNameController.text.isNotEmpty &&
        selectedCountry.isNotEmpty &&
        addressLine1Controller.text.isNotEmpty &&
        addressLine2Controller.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        postalController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty;
  }

  void _showCountryPickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select Country',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: countryList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(countryList[index]),
                      onTap: () {
                        setState(() {
                          selectedCountry = countryList[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
// ...

Widget buildShippingOption(String title, String description, int price,
    {bool underline = false, bool isActive = false}) {
  return InkWell(
    onTap: () {
      setState(() {
        selectedShippingOption = title;
        selectedShippingPrice = price;
      });
    },
    child: Container(
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio(
            activeColor: Colors.black,
            value: title,
            groupValue: selectedShippingOption,
            onChanged: (String? value) {
              setState(() {
                selectedShippingOption = value!;
                selectedShippingPrice = price;
              });
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 270,
                height: 30,
                child: Text(
                  title,
                  style: underline
                      ? TextStyle(decoration: TextDecoration.underline)
                      : null,
                ),
              ),
              Container(
                width: 270,
                height: 180,
                child: Text(
                  description,
                  overflow: TextOverflow.clip,
                  style: underline
                      ? TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: const Color.fromARGB(255, 176, 173, 173))
                      : TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 176, 173, 173)),
                ),
              ),
              Container(
                width: 250,
                height: 30,
                child: Text(
                  "USD" + price.toString(),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

// ...


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
            Text("Price " + widget.artwork["harga"]),
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
                  child: Text(widget.artwork["harga"],
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
                    fontSize: 16,
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
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Delivery method',
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Shipping',
                        groupValue: selectedDeliveryMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedDeliveryMethod = value as String;
                            isShippingSelected = true;
                            // }
                          });
                        },
                      ),
                      Text('Shipping'),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isShippingSelected ? 70 : 130,
                  padding: EdgeInsets.only(bottom: isShippingSelected ? 0 : 40),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                      left: BorderSide(
                        color: Colors.grey,
                      ),
                      right: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: "Arrange for pickup",
                        groupValue: isShippingSelected,
                        onChanged: (value) {
                          setState(() {
                            selectedDeliveryMethod = value as String;
                            // if (!isShippingSelected) {
                            isShippingSelected = false;
                            // }
                          });
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text(
                              'Arrange for Pickup (Free)',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          // Adding Visibility widget here
                          Visibility(
                            visible: !isShippingSelected,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: isShippingSelected ? 0 : 300,
                              height: isShippingSelected ? 0 : 40,
                              child: Text(
                                'After your order is confirmed, a specialist will contact you to coordinate pickup.',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Delivery address',
                  style: TextStyle(fontSize: 26),
                ),
                SizedBox(height: 10),
                isShippingSelected
                    ? buildShippingForm()
                    : Visibility(
                        visible: !isShippingSelected,
                        child: Container(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                Text(
                                  "What is this?",
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.right,
                                ),
                                buildTextField("Email", emailController),
                                buildTextField(
                                    "Phone Number", phoneNumberController)
                              ],
                            )),
                      ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: isShippingSelected,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // shrinkWrap: true,
                      children: [
                        Text("Add a new address",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 24,
                        ),
                        Text("Artsy shipping option",
                            textAlign: TextAlign.left),
                        Text(
                          "All options are eligible for Artsy's Buyer Protection policy, which protects against damage and loss",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        ),
                        buildShippingOption(
                          "Standard",
                          "Delivers to your door in 3-5 business days once packaged and shipped via a common carrier, depending on destination and prompt payment of applicable duties and taxes",
                          579,
                          isActive: !isPrioritySelected,
                        ),
                        buildShippingOption(
                          "Priority",
                          "Delivers to your door in 2-4 business days once packaged and shipped via a common carrier, depending on destination and prompt payment of applicable duties and taxes",
                          667,
                          underline: true,
                          isActive: isPrioritySelected,
                        ),
                        // Add more shipping options if needed
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            buildArtworkInfo(),
            SizedBox(
              height: 15,
            ),
            buildProtectionInfo(),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                ShippingInfo shippingInfo = ShippingInfo(
                  fullName: fullNameController.text,
                  country: selectedCountry,
                  addressLine1: addressLine1Controller.text,
                  addressLine2: addressLine2Controller.text,
                  city: cityController.text,
                  state: stateController.text,
                  postalCode: postalController.text,
                  phoneNumber: phoneNumberController.text,
                  saveAddressForLaterUse: saveAddressForLaterUse,
                  shippingMethod: selectedDeliveryMethod,
                  shippingOption: selectedShippingOption,
                  shippingPrice: selectedShippingPrice,
                );

                // Panggil callback untuk menyimpan data dan berpindah ke tab berikutnya
                widget.onSaveAndContinue(shippingInfo);

                // Beralih ke tab berikutnya menggunakan _tabController
                widget.tabController.animateTo(1);

                //  _tabController.animateTo(1);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentPage(
                //       shipping: shippingInfo,
                //       artwork: widget.artwork,
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
      ),
    );
  }

  List<String> countryList = [
    "United States",
    "Canada",
    "China",
    "India",
    "Brazil",
    "Argentina",
    "Russia",
    "Australia",
    "Indonesia",
    "Pakistan",
    "Mexico",
    "Japan",
    "Germany",
    "France",
    "United Kingdom",
    "Italy",
    "South Korea",
    "Saudi Arabia",
    "Turkey",
    "South Africa",
    "Nigeria",
    "Egypt",
    "Algeria",
    "Angola",
    "Colombia",
    "Venezuela",
    "Peru",
    "Chile",
    "Thailand",
    "Malaysia",
  ];

  Widget buildShippingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTextField("Full Name", fullNameController),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.black,
            side: BorderSide(color: Colors.grey),
            fixedSize: Size(400, 50), // Atur lebar dan tinggi sesuai kebutuhan
          ),
          onPressed: () {
            _showCountryPickerModal(context);
          },
          child: Text(
            'Select Country',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black54),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        buildTextField("Address Line 1", addressLine1Controller),
        buildTextField("Address Line 2 (Optional)", addressLine2Controller),
        buildTextField("City", cityController),
        buildTextField("State/Province/Region", stateController),
        buildTextField("Postal Code", postalController),
        buildTextField("Phone Number", phoneNumberController),
        Row(
          children: [
            Checkbox(
              value: saveAddressForLaterUse,
              onChanged: (value) {
                setState(() {
                  saveAddressForLaterUse = value!;
                });
              },
            ),
            Text("Save shipping address for later use"),
          ],
        ),
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
