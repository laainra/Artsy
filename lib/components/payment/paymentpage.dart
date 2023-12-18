import 'package:artsy_prj/components/payment/wirepaymentdetails.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/ccpaymentdetail.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';
import 'package:artsy_prj/components/payment/bankpaymentdetails.dart';

class PaymentPage extends StatefulWidget {
  // final Function(PaymentInfo, ShippingInfo) onSaveAndContinue;
  final TabController tabController;
  final Function(PaymentInfo) onSaveAndContinue;
  final Map<String, dynamic> artwork;
  final ShippingInfo? shipping;

  const PaymentPage({
    Key? key,
    required this.shipping,
    required this.artwork,
    required this.onSaveAndContinue,
    required this.tabController,
  }) : super(key: key);
  // Define onSaveAndContinue method and paymentInfo variable

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isBankSelected = false;
  bool isCCSelected = false;
  bool isWireSelected = false;
  bool isSelectedBankTf = false;
  bool isSaveBank = false;
  bool isSaveCC = true;
  bool billingShipping = true;
  // PaymentInfo? paymentInfo;
  PaymentInfo? _paymentInfo;

  void onSavePayment(paymentInfo) {
    // Simpan informasi pembayaran ke dalam state
    setState(() {
      _paymentInfo = paymentInfo;
    });

    // Cetak informasi pembayaran untuk memastikan bahwa sudah disimpan
    print("Payment Info received: $_paymentInfo");
  }

  @override
  Widget build(BuildContext context) {
    // Shipping page UI
    return Material(
        child: Container(
      margin: EdgeInsets.all(13),
      color: Colors.white,
      child: Center(
        child: ListView(
          children: [
            Text(
              'Payment method',
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio<bool?>(
                        activeColor: Colors.black,
                        value: true,
                        groupValue: isBankSelected,
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              isBankSelected = value;
                              isCCSelected = !value;
                              isWireSelected = !value;
                            });
                          }
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text(
                              "ACH Bank transfer",
                              style: TextStyle(
                                decoration: isBankSelected &&
                                        !isCCSelected &&
                                        !isWireSelected
                                    ? TextDecoration.underline
                                    : null,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isBankSelected &&
                                !isCCSelected &&
                                !isWireSelected,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: isBankSelected &&
                                      !isCCSelected &&
                                      !isWireSelected == true
                                  ? 300
                                  : 0,
                              height: isBankSelected &&
                                      !isCCSelected &&
                                      !isWireSelected == true
                                  ? 30
                                  : 0,
                              child: Text(
                                "US Bank Account Only",
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
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio<bool?>(
                        activeColor: Colors.black,
                        value: true,
                        groupValue: isCCSelected,
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              isBankSelected = !value;
                              isCCSelected = value;
                              isWireSelected = !value;
                            });
                          }
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text(
                              "Credit Card",
                              style: TextStyle(
                                decoration: !isBankSelected &&
                                        isCCSelected &&
                                        !isWireSelected
                                    ? TextDecoration.underline
                                    : null,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !isBankSelected &&
                                isCCSelected &&
                                !isWireSelected,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: !isBankSelected &&
                                      isCCSelected &&
                                      !isWireSelected == true
                                  ? 300
                                  : 0,
                              height: !isBankSelected &&
                                      isCCSelected &&
                                      !isWireSelected == true
                                  ? 30
                                  : 0,
                              child: Text(
                                "",
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
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio<bool?>(
                        activeColor: Colors.black,
                        value: true,
                        groupValue: isWireSelected,
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              isBankSelected = !value;
                              isCCSelected = !value;
                              isWireSelected = value;
                            });
                          }
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text(
                              "Wire transfer",
                              style: TextStyle(
                                decoration: !isBankSelected &&
                                        !isCCSelected &&
                                        isWireSelected
                                    ? TextDecoration.underline
                                    : null,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !isBankSelected &&
                                !isCCSelected &&
                                isWireSelected,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: !isBankSelected &&
                                      !isCCSelected &&
                                      isWireSelected == true
                                  ? 300
                                  : 0,
                              height: !isBankSelected &&
                                      !isCCSelected &&
                                      isWireSelected == true
                                  ? 30
                                  : 0,
                              child: Text(
                                "",
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

                Visibility(
                    visible: isBankSelected && !isCCSelected && !isWireSelected,
                    child: Column(
                      children: [
                        BankForm(
                          artwork: widget.artwork,
                          shipping: widget.shipping,
                          tabController: widget.tabController,
                          onSavePayment: widget.onSaveAndContinue,
                        )
                      ],
                    )),
                Visibility(
                    visible: !isBankSelected && isCCSelected && !isWireSelected,
                    child: Column(
                      children: [
                        CCForm(
                          artwork: widget.artwork,
                          shipping: widget.shipping,
                          tabController: widget.tabController,
                          onSavePayment: widget.onSaveAndContinue,
                          // onSavePayment: onSavePayment
                        )
                      ],
                    )),
                Visibility(
                    visible: !isBankSelected && !isCCSelected && isWireSelected,
                    child: Column(
                      children: [
                        WireForm(
                          artwork: widget.artwork,
                          shipping: widget.shipping,
                          tabController: widget.tabController,
                          onSavePayment: widget.onSaveAndContinue,
                        )
                      ],
                    )),

                // Container>Column[Image,Text,Text,Text,Text,Divider,Row[Container>Text,Container>Text]),

                SizedBox(
                  height: 20,
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
    ));
  }
}
