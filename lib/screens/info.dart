import 'package:artsy_prj/components/info/earnmore.dart';
import 'package:artsy_prj/components/info/how.dart';
import 'package:artsy_prj/components/info/salesstrategy.dart';
import 'package:artsy_prj/components/info/sellart.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            // padding: EdgeInsets.all(15),
            child: ListView(
          children: [
            SellArtSection(),
            EarnMoreSection(),
            SalesStrategySection(),
            HowSection()
          ],
        )));
  }
}
