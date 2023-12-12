import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';
import 'package:artsy_prj/model/shippingmodel.dart';

class PurchasePage extends StatefulWidget {
  final Map<String, dynamic> artworkDetails;
  const PurchasePage({Key? key, required this.artworkDetails})
      : super(key: key);
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ShippingInfo? shippingInfo;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
          // TabBar
          Container(
            height: 40,
            child: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color.fromARGB(255, 86, 83, 83),
              isScrollable: false,
              tabs: [
                Tab(text: 'Shipping   >'),
                Tab(text: 'Payment   >'),
                Tab(text: 'Review  >'),
              ],
            ),
          ),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Halaman Shipping (pass required data to ShippingPage)
                ShippingForm(
                  artwork: widget.artworkDetails,
                  onSaveAndContinue: (shippingInfo) {
                    _tabController.animateTo(1); // Move to the next tab
                  },
                ),
                // Halaman Payment (pass required data to PaymentPage)
                PaymentPage(
                    shipping: shippingInfo, artwork: widget.artworkDetails),
                // Halaman Review (pass required data to ReviewPage)
                ReviewPage(
                    shipping: shippingInfo,
                    artwork: widget.artworkDetails,
                    payment: {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShippingForm extends StatefulWidget {
  final Map<String, dynamic> artwork;
  final Function(ShippingInfo) onSaveAndContinue;
  const ShippingForm(
      {Key? key, required this.artwork, required this.onSaveAndContinue})
      : super(key: key);
  @override
  _ShippingFormState createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalrController = TextEditingController();
  bool isShippingSelected = true;
  String selectedCountry = '';
  bool saveAddressForLaterUse = false;

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

  @override
  Widget build(BuildContext context) {
    // Shipping page UI
    return Container(
      margin: EdgeInsets.all(13),
      color: Colors.white,
      child: Center(
        child: ListView(
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
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: true,
                        groupValue: isShippingSelected,
                        onChanged: (value) {
                          setState(() {
                            isShippingSelected = value as bool;
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
                        value: false,
                        groupValue: isShippingSelected,
                        onChanged: (value) {
                          setState(() {
                            isShippingSelected = value as bool;
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
                          // Menambahkan widget Visibility di sini
                          Visibility(
                            visible: !isShippingSelected,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: isShippingSelected ? 0 : 300,
                              height: isShippingSelected
                                  ? 0
                                  : 40, // Menyembunyikan teks ketika tidak aktif
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
                          child: Text(
                            "What is this?",
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                Visibility(
                  visible: !isShippingSelected,
                  child: buildTextField("Phone Number", phoneNumberController),
                ),
                // Container>Column[Image,Text,Text,Text,Text,Divider,Row[Container>Text,Container>Text]),
                Container(
                  width: 330,
                  height: 600,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(widget.artwork["image"][0], height: 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.artwork["artist"],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            widget.artwork["title"] +
                                ", " +
                                widget.artwork["year"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.artwork["gallery"],
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Location", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Price " + widget.artwork["harga"]),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                          height: 10,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "*Additional duties and taxes "),
                              TextSpan(
                                  text: "may apply at import ",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                            ])),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(186, 215, 215, 215)),
                  width: 365,
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your purchace is protected",
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
                                            decoration:
                                                TextDecoration.underline)),
                                  ])),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                      postalCode: postalrController.text,
                      phoneNumber: phoneNumberController.text,
                      saveAddressForLaterUse: saveAddressForLaterUse,
                    );

                    // Call the callback function to pass shipping information
                    widget.onSaveAndContinue(shippingInfo);
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
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
        buildTextField("Postal Code", postalrController),
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

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> artwork;
  final ShippingInfo? shipping;

  const PaymentPage({Key? key, required this.shipping, required this.artwork})
      : super(key: key);
  // Define onSaveAndContinue method and paymentInfo variable
  void onSaveAndContinue(Map<String, dynamic> paymentInfo) {
    // Implement your logic here
    // This method will be called when the button is pressed
  }
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isSelectedBankTf = false;

  @override
  Widget build(BuildContext context) {
    // Shipping page UI
    return Container(
      margin: EdgeInsets.all(13),
      color: Colors.white,
      child: Center(
        child: ListView(
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
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: true,
                        groupValue: isSelectedBankTf,
                        onChanged: (value) {},
                      ),
                      Text('Shipping'),
                    ],
                  ),
                ),

                // Container>Column[Image,Text,Text,Text,Text,Divider,Row[Container>Text,Container>Text]),
                Container(
                  width: 330,
                  height: 600,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(widget.artwork["image"][0], height: 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.artwork["artist"],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            widget.artwork["title"] +
                                ", " +
                                widget.artwork["year"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.artwork["gallery"],
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Location", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Price " + widget.artwork["harga"]),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                          height: 10,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "*Additional duties and taxes "),
                              TextSpan(
                                  text: "may apply at import ",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                            ])),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(186, 215, 215, 215)),
                  width: 365,
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your purchace is protected",
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
                                            decoration:
                                                TextDecoration.underline)),
                                  ])),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> paymentInfo = {};
                    // Call the callback function to pass shipping information
                    widget.onSaveAndContinue(paymentInfo);
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
                          style: TextStyle(
                            fontSize: 13,
                          ),
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

class ReviewPage extends StatelessWidget {
  final ShippingInfo? shipping;
  final Map<String, dynamic> artwork;
  final Map<String, dynamic> payment;

  const ReviewPage(
      {Key? key,
      required this.shipping,
      required this.artwork,
      required this.payment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Review page UI
    return Container(
      color: Colors.orange,
      child: Center(
        child: Text(
            'Review Page\n${shipping.toString()}\n${artwork.toString()}\n${payment.toString()}'),
      ),
    );
  }
}
