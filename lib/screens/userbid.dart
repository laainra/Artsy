import 'package:flutter/material.dart';

class UserBidPage extends StatefulWidget {
  const UserBidPage({Key? key}) : super(key: key);
  @override
  _UserBidPageState createState() => _UserBidPageState();
}

class _UserBidPageState extends State<UserBidPage> {
  final List<Map<String, dynamic>> dataList = [
    {
      'image': 'assets/images/art1.png',
      'title': 'Item 1',
      'desc': 'Deskripsi item 1 yang overflownya ke bawah tiga baris.',
      'time': '1 day ago',
    },
    {
      'image': 'assets/images/art2.png',
      'title': 'Item 2',
      'desc': 'Deskripsi item 2 yang overflownya ke bawah tiga baris.',
      'time': '2 days ago',
    },
    {
      'image': 'assets/images/art3.png',
      'title': 'Item 3',
      'desc': 'Deskripsi item 3 yang overflownya ke bawah tiga baris.',
      'time': '3 days ago',
    },
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: TabBar(
              padding: EdgeInsets.all(40),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              isScrollable: false,
              tabs: [
                Tab(text: 'Bids'),
                Tab(text: 'Inquiries'),
              ],
            ),
          ),
        ),
        body: TabBarView(
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
                          'Discover works for your auction.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Browse and bid in auctions around the world, from online-only sales to benefit auction-all in the Artsy app',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Functionality for the button
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Explore Auctions",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            // Inquiries Tab
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.left,
                    'Inbox',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: dataList.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      itemBuilder: (context, index) {
                        final item = dataList[index];
                        return ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Row(
                            children: [
                              Image(
                                image: AssetImage(item['image']),
                                width: 100,
                                height: 100 *
                                    3 /
                                    4, // Assuming you want a 4:3 aspect ratio, adjust as needed
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 43, 43, 43),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          item['time'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      item['desc'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 66, 64, 64),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Tambahkan aksi ketika item diklik di sini
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
