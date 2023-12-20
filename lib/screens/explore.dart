import 'package:flutter/material.dart';
import 'package:artsy_prj/dbhelper.dart'; // Import your DBHelper class
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/screens/detailartwork.dart';

class ExplorePage extends StatefulWidget {
  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage> {
  final List<Map<String, dynamic>> artItems = [
    {
      'title': 'Ndebele Pattern',
      'artist': 'Esther Mahlangu',
      'year': 2021,
      'gallery': 'Tumo Gallery',
      'image': 'assets/images/art1.png',
      'harga': '€3,300',
    },
    {
      'title': 'Sally',
      'artist': 'Ginny Casey',
      'year': 2023,
      'gallery': 'Half Gallery',
      'image': 'assets/images/art2.png',
      'harga': 'USD16,000',
    },
    {
      'title': 'Strength?',
      'artist': 'Kevin Claiborne',
      'year': 2023,
      'gallery': 'WORTHLESSSTUDIOS Benefit Auction',
      'image': 'assets/images/art3.png',
      'harga': 'USD3,500',
    },
    {
      'title': 'Dancing Among the Flowers',
      'artist': 'Eric Alfaro',
      'year': 2023,
      'gallery': 'Carousel Fine Art',
      'image': 'assets/images/art4.png',
      'harga': 'USD12,500',
    },
    {
      'title': 'The Moment That Things Start to Change',
      'artist': 'Yusuf Epçin',
      'year': 2023,
      'gallery': 'The Artchi Gallery',
      'image': 'assets/images/art5.png',
      'harga': '£1,200',
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

    // Fetch artwork data with artist and gallery names using a join operation
    final artworkData = await dbHelper.getAllArtworksWithDetails();

    // Update the state with the fetched artwork data
    setState(() {
      artItems.clear();
      artItems.addAll(artworkData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Explore Artworks",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
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
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
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
                      child: Column(
                        children: [
                          Image.asset(
                            artItems[index]['image'],
                            height: 250,
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    artItems[index]['artistName'],
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
                                artItems[index]['galleryName'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(121, 23, 22, 22),
                                ),
                              ),
                              Text(
                                artItems[index]['harga'],
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
        ));
  }
}
