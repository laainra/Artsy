import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';

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
                ShippingForm(artwork: widget.artworkDetails),
                // Halaman Payment (pass required data to PaymentPage)
                PaymentPage(shipping: {}, artwork: widget.artworkDetails),
                // Halaman Review (pass required data to ReviewPage)
                ReviewPage(
                    shipping: {}, artwork: widget.artworkDetails, payment: {}),
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
  const ShippingForm({Key? key, required this.artwork}) : super(key: key);
  @override
  _ShippingFormState createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
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
        buildTextField("Address Line 1", TextEditingController()),
        buildTextField("Address Line 2 (Optional)", TextEditingController()),
        buildTextField("City", TextEditingController()),
        buildTextField("State/Province/Region", TextEditingController()),
        buildTextField("Postal Code", TextEditingController()),
        buildTextField("Phone Number", TextEditingController()),
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

class PaymentPage extends StatelessWidget {
  final Map<String, dynamic> shipping;
  final Map<String, dynamic> artwork;

  const PaymentPage({Key? key, required this.shipping, required this.artwork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Payment page UI
    return Container(
      color: Colors.green,
      child: Center(
        child:
            Text('Payment Page\n${shipping.toString()}\n${artwork.toString()}'),
      ),
    );
  }
}

class ReviewPage extends StatelessWidget {
  final Map<String, dynamic> shipping;
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
