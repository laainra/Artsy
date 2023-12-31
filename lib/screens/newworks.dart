import 'package:artsy_prj/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/dbhelper.dart'; // Import your DBHelper class
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/screens/detailartwork.dart';

class NewWorksPage extends StatefulWidget {
  final UserModel? user;
  const NewWorksPage({Key? key, required this.user})
      : super(key: key);
  @override
  NewWorksPageState createState() => NewWorksPageState();
}

class NewWorksPageState extends State<NewWorksPage> {
  final List<Map<String, dynamic>> artItems = [
    {
      'title': 'Ndebele Pattern',
      'artist': 'Esther Mahlangu',
      'year': 2021, // Change from "2021" to 2021
      'gallery': 'Tumo Gallery',
      'image': 'assets/images/art1.png',
      'harga': '3,300',
    },
    {
      'title': 'Sally',
      'artist': 'Ginny Casey',
      'year': 2023, // Change from "2023" to 2023
      'gallery': 'Half Gallery',
      'image': 'assets/images/art2.png',
      'harga': 'USD16,000',
    },
    {
      'title': 'Strength?',
      'artist': 'Kevin Claiborne',
      'year': 2023, // Change from "2023" to 2023
      'gallery': 'WORTHLESSSTUDIOS Benefit Auction',
      'image': 'assets/images/art3.png',
      'harga': 'USD3,500',
    },
    {
      'title': 'Dancing Among the Flowers',
      'artist': 'Eric Alfaro',
      'year': 2023, // Change from "2023" to 2023
      'gallery': 'Carousel Fine Art',
      'image': 'assets/images/art4.png',
      'harga': 'USD12,500',
    },
    {
      'title': 'The Moment That Things Start to Change',
      'artist': 'Yusuf Epçin',
      'year': 2023, // Change from "2023" to 2023
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New Works for You",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              ">", // Change from "<" to ">"
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
            )
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 380,
          child: ListView.builder(
  // scrollDirection: Axis.verti,
  itemCount: artItems.length,
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArtworkPage(user:widget.user,artworkDetails: artItems[index]),
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
              Image.asset(
                artItems[index]['image'],
                height: 250,
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  },
),

        ),
      ],
    );
  }
}
