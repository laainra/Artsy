import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';

class PurchasePage extends StatefulWidget {
  final Map<String, dynamic> artworkDetails;
  final UserModel? user;
  const PurchasePage({Key? key, required this.artworkDetails,required this.user})
      : super(key: key);
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ShippingInfo? shippingInfo;
  PaymentInfo? paymentInfo;
  PaymentInfo? _paymentInfo;

  void onSavePayment(PaymentInfo paymentInfo) {
    // Simpan informasi pembayaran ke dalam state
    setState(() {
      _paymentInfo = paymentInfo;
    });

    // Cetak informasi pembayaran untuk memastikan bahwa sudah disimpan
    print("Payment Info received: $_paymentInfo");
  }

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
                Tab(text: 'Shipping >'),
                Tab(text: 'Payment >'),
                Tab(text: 'Review >'),
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
                    setState(() {
                      this.shippingInfo = shippingInfo;
                    });

                    // _tabController.animateTo(1); // Move to the next tab
                  },
                  tabController: _tabController,
                ),
                // Halaman Payment (pass required data to PaymentPage)
                PaymentPage(
                  shipping: shippingInfo,
                  artwork: widget.artworkDetails,
                  onSaveAndContinue: (paymentInfo) {
                    setState(() {
                      this.paymentInfo = paymentInfo;
                    });

                    // _tabController.animateTo(1); // Move to the next tab
                  },
                  tabController: _tabController,
                  user: widget.user,
                ),

                // Halaman Review (pass required data to ReviewPage)
                ReviewPage(
                  user: widget.user,
                    shipping: shippingInfo,
                    artwork: widget.artworkDetails,
                    payment: paymentInfo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
