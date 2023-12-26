import 'package:artsy_prj/screens/artworks.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/dbhelper.dart'; // Import your DBHelper class
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/screens/detailartwork.dart';
import 'dart:io';

class NewWorksSection extends StatefulWidget {
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
      'price': '€3,300',
    },
    {
      'title': 'Sally',
      'artistName': 'Ginny Casey',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'Half Gallery',
      'photos': 'assets/images/art2.png',
      'price': 'USD16,000',
    },
    {
      'title': 'Strength?',
      'artistName': 'Kevin Claiborne',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'WORTHLESSSTUDIOS Benefit Auction',
      'photos': 'assets/images/art3.png',

      'price': 'USD3,500',
    },
    {
      'title': 'Dancing Among the Flowers',
      'artistName': 'Eric Alfaro',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'Carousel Fine Art',
      'photos': 'assets/images/art4.png',

      'price': 'USD12,500',
    },
    {
      'title': 'The Moment That Things Start to Change',
      'artistName': 'Yusuf Epçin',
      'year': 2023, // Change from "2023" to 2023
      'galleryName': 'The Artchi Gallery',
      'photos': 'assets/images/art5.png',

      'price': '£1,200',
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
                        artworks: artItems,
                      ),
                    ),
                  );
                },
                child: Text(
                  "New Works for You",
                  style: TextStyle(fontSize: 16),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArtworksPage(
                        artworks: artItems,
                      ),
                    ),
                  );
                },
                child: Text(
                  ">",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                )),
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 410,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: artItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailArtworkPage(
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
                  child: Container(
                    child: Column(
                      children: [
                        Center(
                          child: artItems[index]['photos'] != null
                              ? artItems[index]['photos']
                                      .startsWith('assets/images')
                                  ? Image.asset(
                                      artItems[index]['photos'],
                                      height: 250,
                                    )
                                  : Image.file(
                                      File(artItems[index]['photos']),
                                      height: 250,
                                    )
                              : Image.asset(
                                      'assets/images/art1.png',
                                      height: 250,
                                    )
                        ),
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
                                Icon(Icons.favorite_border)
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
                              artItems[index]['galleryName'] ??
                                  'Unknown Gallery',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(121, 23, 22, 22),
                              ),
                            ),
                            Text(
                              artItems[index]['price'],
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
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
