import 'package:artsy_prj/components/profile/collections.dart';
import 'package:artsy_prj/components/profile/insight.dart';
import 'package:artsy_prj/components/profile/saves.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';

class ProfilePage extends StatefulWidget {
  // final Map<String, dynamic> artworkDetails;
  const ProfilePage({
    Key? key,
    //  required this.artworkDetails
  }) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Function to go back to the previous page
              Navigator.pop(context);
            },
          ),
        ],
        title: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.grey,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180.0),
                    ),
                    child: Icon(Icons.person_2_outlined),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        "My Name",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "Member since 2023",
                        style: TextStyle(fontSize: 16, color: Colors.grey,),
                      ),
                    ],
                  )
                ]),
                TextButton.icon(
                    onPressed: () {
                      //
                    },
                    icon: Icon(Icons.location_pin, color: Colors.grey,),
                    label: Text("Indonesia", style: TextStyle( color: Colors.grey,),))
              ],
            )),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // TabBar
          Container(
            height: 40,
            child: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color.fromARGB(255, 86, 83, 83),
              isScrollable: false,
              tabs: [
                Tab(text: 'My Collection'),
                Tab(text: 'Insight'),
                Tab(text: 'Saves'),
              ],
            ),
          ),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CollectionsTab(),
                InsightTab(),
                SavesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
