import 'package:artsy_prj/components/profile/collections.dart';
import 'package:artsy_prj/components/profile/insight.dart';
import 'package:artsy_prj/components/profile/saves.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/model/shippingmodel.dart';
import 'package:artsy_prj/model/paymentmodel.dart';
import 'package:artsy_prj/components/payment/shippingform.dart';
import 'package:artsy_prj/components/payment/reviewpage.dart';
import 'package:artsy_prj/components/payment/paymentpage.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

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
      body: Column(
        children: [
          // Custom Header
          Container(
            padding: EdgeInsets.only(top: 40, left: 15, right: 15),
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.user.profileImage != null
                                ? Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image.file(
                                        File(widget.user.profileImage!)),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(Icons.person_outline,
                                        color: Colors.white),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.user.name != null)
                                  Text(
                                    widget.user.name!,
                                    style: TextStyle(fontSize: 19),
                                  )
                                else
                                  Text(
                                    "My Name",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                Text(
                                  "Member since ${widget.user.createdAt != null ? DateTime.parse(widget.user.createdAt!).year : 'Unknown'}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(
                              user: widget.user,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    //
                  },
                  icon: Icon(
                    Icons.location_pin,
                    color: Colors.grey,
                  ),
                  label: Text(
                    widget.user.location != null
                        ? widget.user.location!
                        : "Unknown",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // TabBar
          Container(
            height: 50,
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
