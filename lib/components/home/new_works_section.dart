import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/screens/artworks.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/components/priceFormat.dart';
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/screens/detailartwork.dart';
import 'dart:io';

class NewWorksSection extends StatefulWidget {
  final UserModel? user;
  const NewWorksSection({Key? key, required this.user}) : super(key: key);
  @override
  NewWorksSectionState createState() => NewWorksSectionState();
}

class NewWorksSectionState extends State<NewWorksSection> {
  final List<Map<String, dynamic>> artItems = [
    {
      'title': 'Ndebele Pattern',
      'artistName': 'Esther Mahlangu',
      'year': 2021,
      'galleryName': 'Tumo Gallery',
      'photos': 'assets/images/art1.png',
      'price': '3300',
    },
    {
      'title': 'Sally',
      'artistName': 'Ginny Casey',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'Half Gallery',
      'photos': 'assets/images/art2.png',
      'price': '16000',
    },
    {
      'title': 'Strength?',
      'artistName': 'Kevin Claiborne',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'WORTHLESSSTUDIOS Benefit Auction',
      'photos': 'assets/images/art3.png',

      'price': '3500',
    },
    {
      'title': 'Dancing Among the Flowers',
      'artistName': 'Eric Alfaro',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'Carousel Fine Art',
      'photos': 'assets/images/art4.png',

      'price': '12500',
    },
    {
      'title': 'The Moment That Things Start to Change',
      'artistName': 'Yusuf Epçin',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'The Artchi Gallery',
      'photos': 'assets/images/art5.png',

      'price': '1200',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Fetch artwork data from the database when the widget initializes
    fetchArtworkData();
  }

  void fetchArtworkData() async {
    var dbHelper = DBHelper();

    // Fetch artwork data with artistName and galleryName names using a join operation
    final artworkData = await dbHelper.getAllArtworksWithDetails();

    // Update the state with the fetched artwork data
    setState(() {
      // artItems.clear();
      artItems.addAll(artworkData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtworksPage(
                      user: widget.user,
                      artworks: artItems,
                    ),
                  ),
                );
              },
              child: Text(
                "New Works for You",
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtworksPage(
                      user: widget.user,
                      artworks: artItems,
                    ),
                  ),
                );
              },
              child: Text(
                ">",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 410,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: artItems.length,
            itemBuilder: (context, index) {
              String photoPath = artItems[index]['photos'];

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

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailArtworkPage(
                        user: widget.user,
                        artworkDetails: artItems[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  width: 250,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Center(child: imageWidget),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                artItems[index]['artistName'] ??
                                    'Unknown Artist',
                                style: TextStyle(fontSize: 13),
                              ),
                              Icon(Icons.favorite_border),
                            ],
                          ),
                          Text(
                            '${artItems[index]['title']}, ${artItems[index]['year']}',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(121, 23, 22, 22),
                            ),
                          ),
                          Text(
                            artItems[index]['galleryName'] ?? 'Unknown Gallery',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(121, 23, 22, 22),
                            ),
                          ),
                          Text(
                            PriceFormatter.formatPrice(
                                artItems[index]['price'].toString()),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
