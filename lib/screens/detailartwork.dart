import 'package:artsy_prj/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/screens/payment.dart';
import 'dart:io';
import 'package:artsy_prj/components/priceFormat.dart';

class DetailArtworkPage extends StatefulWidget {
  final UserModel? user;
  final Map<String, dynamic> artworkDetails;
  const DetailArtworkPage(
      {Key? key, required this.artworkDetails, required this.user})
      : super(key: key);

  @override
  State<DetailArtworkPage> createState() => _DetailArtworkPageState();
}

class _DetailArtworkPageState extends State<DetailArtworkPage> {
  final _pageController = PageController(viewportFraction: 1);
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toDouble();
        print(currentPage);
      });
    });
    super.initState();
  }

  final List<String> imageUrls = [
    'https://placekitten.com/400/800',
    'https://placekitten.com/600/800',
    'https://placekitten.com/800/800',
  ];

  @override
  Widget build(BuildContext context) {
    String photoPath = widget.artworkDetails['photos'];

    Widget imageWidget;

    if (photoPath.startsWith('assets/images')) {
      imageWidget = Image.asset(
        photoPath,
        height: 250,
        // You can add more properties here if needed
      );
    } else if (photoPath.startsWith(
        '/storage/emulated/0/Android/data/com.example.artsy_prj/files/')) {
      imageWidget = Image.file(
        File(photoPath),
        height: 250,
        // You can add more properties here if needed
      );
    } else {
      // Handle other cases or provide a default image
      imageWidget = Placeholder();
    }

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: Text(
            "<",
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
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // Functionality for the Create Alert button
              },
              icon: Icon(
                Icons.notifications_outlined,
                size: 24,
                color: Colors.black,
              ),
              label: Text("Create Alert", style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Container(
                  height: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: 300,
                            height: 300,
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  currentPage = index.toDouble();
                                });
                              },
                              children: [
                                imageWidget
                              ],
                            ),
                          ),
                          // Page indicators
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          imageUrls.length,
                          (index) => buildPageIndicator(index),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.black),
                          Text(" Save", style: TextStyle(color: Colors.black)),
                          SizedBox(width: 20),
                          Icon(Icons.share_outlined, color: Colors.black),
                          Text(" Share", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.artworkDetails['title'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.artworkDetails['artistName']! +
                      ", " +
                      widget.artworkDetails['year'].toString(),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                // List of information
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          "Medium",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 123, 121, 121)),
                        ),
                      ),
                      Container(
                          width: 150,
                          child: Text(
                            widget.artworkDetails['title'],
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          "Materials",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 123, 121, 121)),
                        ),
                      ),
                      Container(
                          width: 150,
                          child: Text(
                            widget.artworkDetails['title'],
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          "Size",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 123, 121, 121)),
                        ),
                      ),
                      Container(
                          width: 150,
                          child: Text(
                            widget.artworkDetails['title'],
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          "Rarity",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 123, 121, 121)),
                        ),
                      ),
                      Container(
                          width: 150,
                          child: Text(
                            widget.artworkDetails['title'],
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          "Certificate of Authenticity",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 123, 121, 121)),
                        ),
                      ),
                      Container(
                          width: 150,
                          child: Text(
                            widget.artworkDetails['title'],
                            overflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Frame",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 123, 121, 121)),
                      ),
                      Text(
                        widget.artworkDetails['title'],
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Signature",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 123, 121, 121)),
                      ),
                      Text(
                        widget.artworkDetails['title'],
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                ),

                // Divider
                const Divider(
                  color: Colors.black,
                ),
                const Text(
                  "About the Artist",
                  style: TextStyle(fontSize: 20),
                ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage('https://placekitten.com/200/200'),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.artworkDetails['artistName'],
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Description about the artist...",
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, right: 16),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Functionality for the Create Alert button
                        },
                        child: Text("Follow", style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                Text("Want to sell a work by " +
                    widget.artworkDetails['artistName'] +
                    '?'),
                Text(
                  "Consign with Artsy",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gallery",
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://placekitten.com/200/200'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(widget.artworkDetails['galleryName'] ??
                              'Unknown Gallery'),
                          Text(
                            "Gallery Location",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      )
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Question about this piece?",
                          style: TextStyle(fontSize: 9),
                          overflow: TextOverflow.clip,
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            // Functionality for the Create Alert button
                          },
                          icon: Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                          label: Text("Contact Gallery",
                              style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(height: 20),
                Text("Shipping and taxes",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 28)),
                Text(
                  "Taxes may apply at ckeckout. Ships from Indonesia",
                  overflow: TextOverflow.clip,
                ),
                Text("Shipping USD10 within Indonesia, USD160 rest of world.",
                    overflow: TextOverflow.clip),
                Text("VAT included in price"),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
          // Fixed container
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    PriceFormatter.formatPrice(widget.artworkDetails['price']),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 28),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "excl. Shipping and Taxes",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 98, 96, 96),
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Login Button
                      OutlinedButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, '/login');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          minimumSize: Size(160, 50),
                          // Add a margin of 20 to all edges
                        ),
                        child: Text(
                          'Make an Offer',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the payment page or handle purchase logic
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PurchasePage(
                                user: widget.user,
                                // Pass relevant details to the payment page if needed
                                artworkDetails: widget.artworkDetails,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(160, 50),
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Purchase",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage.round() == index ? Colors.black : Colors.grey,
      ),
    );
  }
}
