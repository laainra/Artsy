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
      height: 350, // Set a fixed height or use constraints as per your layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            // Wrap the Column with Expanded
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
                        width: 120,
                        height: 350,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1607355739828-0bf365440db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1444&q=80",
                          ),
                        ),
                      ),
                      Expanded(
                        // Wrap the Column with Expanded
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
                                          "What is Lorem Ipsum?",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Lorep  ipsum dolor color ndsdhiuhusLorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/login');
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
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.black),
                  margin: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 350,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1607355739828-0bf365440db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1444&q=80",
                          ),
                        ),
                      ),
                      Expanded(
                        // Wrap the Column with Expanded
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
                                          "What is Lorem Ipsum?",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Lorep  ipsum dolor color ndsdhiuhusLorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/login');
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
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.black),
                  margin: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 350,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1607355739828-0bf365440db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1444&q=80",
                          ),
                        ),
                      ),
                      Expanded(
                        // Wrap the Column with Expanded
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
                                          "What is Lorem Ipsum?",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Lorep  ipsum dolor color ndsdhiuhusLorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/login');
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
                ),

                // Add other Container widgets as needed...
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Row(
              children: List.generate(
                3,
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
