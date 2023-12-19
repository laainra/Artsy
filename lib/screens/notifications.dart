import 'package:flutter/material.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: TextButton(
          child: Text(
            "<",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
          ),
          onPressed: () {
            // Fungsi untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                child: Text(
                  "Activity",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              TabBar(
                padding: EdgeInsets.all(10),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                isScrollable: false,
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Alerts'),
                ],
              ),
              Expanded(
                // Wrap TabBarView with Expanded
                child: TabBarView(
                  children: [
                    // Bids Tab
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(40),
                            child: Column(
                              children: [
                                Text(
                                  'Follow artist and galleries to stay up to date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Keep track of the art and events you love and get recommendations based on who you follow',
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(40),
                            child: Column(
                              children: [
                                Text(
                                  'Hunting for particular artwork?',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Create alerts on an artist or artwork page and get notifications here when there's a match",
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Inquiries Tab
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
