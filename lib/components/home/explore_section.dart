import 'package:artsy_prj/screens/detaileditorial.dart';
import 'package:flutter/material.dart';

class ExploreSection extends StatefulWidget {
  const ExploreSection({Key? key}) : super(key: key);

  @override
  State<ExploreSection> createState() => _ExploreSectionState();
}

class _ExploreSectionState extends State<ExploreSection> {
  final _pageController = PageController(viewportFraction: 1);
  double currentPage = 0;
  late String _formattedDate;
  late List<Map<String, dynamic>> articles;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toDouble();
        print(currentPage);
      });
    });
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
            {
        'title': 'Jeffrey Gibons 15-Year Survey',
        'created_at': _formattedDate,
        'author': 'Clare Gemima',
        'image': [
          'assets/images/art5.png',
          'assets/images/art1.png',
          'assets/images/art3.png'
        ],
        'content':
            "While 2022 at auction was a 'return to routine' after the COVID-19 pandemic, 2023 was a year of more subdued action under the hammer. This year, the top 100 lots at auction totaled USD2.4 billion, a notable drop from USD4.1 billion in 2022. In this environment, two artworks sold for over USD100 million- Pablo Picasso's Femme à la montre (1932) and Gustav Klimt's Dame mit Fächer (Lady with a Fan) (1917)-compared to six works in 2022. Just "
      },
            {
        'title': 'Pauline Botys Sex-Positive Pop Art Is Having',
        'created_at': _formattedDate,
        'author': 'Shelly Cell',
        'image': [
          'assets/images/art2.png',
          'assets/images/art3.png',
          'assets/images/art1.png'
        ],
        'content':
            "As a beautiful blonde woman, whose looks frequently distracted from her talent and intelligence, British Pop artist Pauline Boty felt a natural affinity with Marilyn Monroe. Boty painted her on a number of occasions, but while Andy Warhol and other male Pop artists tended to focus on Monroe as a passive sex symbol, Boty's portrayals are more empathetic. In Colour Her Gone (1962), for instance, painted shortly after Monroe's tragic death by suicide, Boty surrounds her heroine with roses, two grey abstract panels on either side."
      },
      {
        'title': 'Apolonia Sokol Turns Her Life into Art',
        'created_at': _formattedDate,
        'author': 'Maxwell Rabb',
        'image': [
          'assets/images/art4.png',
          'assets/images/art3.png',
          'assets/images/art2.png'
        ],
        'content':
            "I don't believe there's a difference between my personal being and my work, Apolonia Sokol told Artsy before a recent screening of Apolonia, Apolonia, a new documentary film spanning 13 years of the French artist's life directed by her friend, Danish director Léa Glob. The film intimately chronicles Sokols artistic and personal growth-evidence, in itself, of her belief that art develops alongside life. Reflecting on the period documented by the movie, she added, The paintings get better, and the thoughts, the philosophy, and everything gets sharper. Thats a natural thing"
      },
      {
        'title': '8 Asian Women Artists Turning',
        'created_at': _formattedDate,
        'author': 'Alexis Ong',
        'image': [
          'assets/images/art4.png',
          'assets/images/art5.png',
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
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                // Use the first image from the current article
                String firstImage = articles[index]['image'][0];
                return Container(
                  decoration: BoxDecoration(color: Colors.black),
                  margin: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 350,
                        child: Image.asset(
                          firstImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Wrap(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          articles[index]['title'],
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          articles[index]['content'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailEditorialPage(
                                          editorialDetails: articles[index],
                                        ),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    minimumSize: Size(130, 35),
                                  ),
                                  child: Text(
                                    'Read Article',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Row(
              children: List.generate(
                articles.length,
                (index) {
                  return Container(
                    margin: EdgeInsets.only(right: 5),
                    alignment: Alignment.center,
                    height: 9,
                    width: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          currentPage == index ? Colors.black : Colors.black12,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
