import 'package:artsy_prj/screens/detaileditorial.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/dbhelper.dart'; // Import your DBHelper class
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/screens/detailartwork.dart';

class EditorialSection extends StatefulWidget {
  @override
  EditorialSectionState createState() => EditorialSectionState();
}

// id INTEGER PRIMARY KEY,
// title TEXT,
// created_at TEXT,
// author TEXT,
// content TEXT,
// image TEXT
class EditorialSectionState extends State<EditorialSection> {
  late String _formattedDate;
  late List<Map<String, dynamic>> articles;

  @override
  void initState() {
    super.initState();
    _formattedDate = _getFormattedDate();
    articles = [
      {
        'title': 'The Most Expensive Works Sold at Auction',
        'created_at': _formattedDate,
        'author': 'Nao Nanano',
        'image': [
          'assets/images/art1.png',
          'assets/images/art2.png',
          'assets/images/art1.png'
        ],
        'content':
            "While 2022 at auction was a 'return to routine' after the COVID-19 pandemic, 2023 was a year of more subdued action under the hammer. This year, the top 100 lots at auction totaled USD2.4 billion, a notable drop from USD4.1 billion in 2022. In this environment, two artworks sold for over USD100 million- Pablo Picasso's Femme à la montre (1932) and Gustav Klimt's Dame mit Fächer (Lady with a Fan) (1917)-compared to six works in 2022. Just "
      },
      {
        'title': 'Artee Povera pioneer Giovanni Anselmo has died',
        'created_at': _formattedDate,
        'author': 'Andrew',
        'image': [
          'assets/images/art3.png',
          'assets/images/art2.png',
          'assets/images/art1.png'
        ],
        'content':
            "While 2022 at auction was a 'return to routine' after the COVID-19 pandemic, 2023 was a year of more subdued action under the hammer. This year, the top 100 lots at auction totaled USD2.4 billion, a notable drop from USD4.1 billion in 2022. In this environment, two artworks sold for over USD100 million- Pablo Picasso's Femme à la montre (1932) and Gustav Klimt's Dame mit Fächer (Lady with a Fan) (1917)-compared to six works in 2022. Just "
      },
      {
        'title': 'Artee Povera pioneer Giovanni Anselmo has died',
        'created_at': _formattedDate,
        'author': 'Shelly Cell',
        'image': [
          'assets/images/art2.png',
          'assets/images/art3.png',
          'assets/images/art1.png'
        ],
        'content':
            "While 2022 at auction was a 'return to routine' after the COVID-19 pandemic, 2023 was a year of more subdued action under the hammer. This year, the top 100 lots at auction totaled USD2.4 billion, a notable drop from USD4.1 billion in 2022. In this environment, two artworks sold for over USD100 million- Pablo Picasso's Femme à la montre (1932) and Gustav Klimt's Dame mit Fächer (Lady with a Fan) (1917)-compared to six works in 2022. Just "
      },
    ];
  }

  String _getFormattedDate() {
    DateTime currentDate = DateTime.now();

    // List of month names
    List<String> monthNames = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    // Get month, day, and year
    int month = currentDate.month;
    String monthName = monthNames[month];
    int day = currentDate.day;
    int year = currentDate.year;

    // Format the date as "Dec 14, 2023"
    String formattedDate = "$monthName $day, $year";

    return formattedDate;
  }

  @override
  // void initState() {
  //   super.initState();
  //   // Fetch artwork data from the database when the widget initializes
  //   fetchArtworkData();
  // }

// void fetchArtworkData() async {
//   var dbHelper = DBHelper();

//   // Fetch artwork data with artist and gallery names using a join operation
//   final artworkData = await dbHelper.getAllArtworksWithDetails();

//   // Update the state with the fetched artwork data
//   setState(() {
//     articles.clear();
//     articles.addAll(artworkData);
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Artsy Editorial",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              ">",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
            )
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 600,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailEditorialPage(
                        editorialDetails: articles[index],
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
                        Row(
                          children: [
                            Image.asset(
                              articles[index]['image'][0],
                              height: 250,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              articles[index]['image'][0],
                              height: 250,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Art",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(121, 23, 22, 22),
                              ),
                            ),
                            Text(
                              articles[index]['title'],
                              style: TextStyle(fontSize: 22),
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              articles[index]['author'],
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              articles[index]['created_at'],
                              style: TextStyle(fontSize: 12, color: Colors.grey),
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
