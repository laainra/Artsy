import 'package:flutter/material.dart';

class ExploreSection extends StatefulWidget {
  const ExploreSection({Key? key}) : super(key: key);

  @override
  State<ExploreSection> createState() => _ExploreSectionState();
}

class _ExploreSectionState extends State<ExploreSection> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Set a fixed height or use constraints as per your layout
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 200,
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.black),
                  margin: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 300,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1607355739828-0bf365440db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1444&q=80",
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    "data",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    "data",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  // Navigator.pushNamed(context, '/login');
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  minimumSize: Size(160, 45),
                                ),
                                child: Text(
                                  'Read Article',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Add other Container widgets as needed...
              ],
            ),
          ),
          Center(
            child: Row(
              children: List.generate(
                3,
                (index) {
                  return Container(
                    margin: EdgeInsets.only(right: 5),
                    alignment: Alignment.centerLeft,
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
