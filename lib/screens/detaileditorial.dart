import 'package:flutter/material.dart';
import 'package:artsy_prj/screens/payment.dart';

class DetailEditorialPage extends StatefulWidget {
  final Map<String, dynamic> editorialDetails;
  const DetailEditorialPage({Key? key, required this.editorialDetails})
      : super(key: key);

  @override
  State<DetailEditorialPage> createState() => _DetailEditorialPageState();
}

class _DetailEditorialPageState extends State<DetailEditorialPage> {
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
          Icon(
            Icons.share_outlined,
            size: 24,
            color: Colors.black,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Art",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: 300,
                            height: 299,
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  currentPage = index.toDouble();
                                });
                              },
                              children: (widget.editorialDetails['image']
                                      as List<String>)
                                  .map((imageUrl) {
                                return Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                );
                              }).toList(),
                            ),
                          ),
                          // Page indicators
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          (widget.editorialDetails['image'] as List<String>)
                              .length,
                          (index) => buildPageIndicator(index),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Text(
                  widget.editorialDetails['title'],
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.editorialDetails['author'],
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  widget.editorialDetails['created_at'],
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Text(
                  widget.editorialDetails['content'],
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.editorialDetails['author'],
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  widget.editorialDetails['author'] +
                      " is Artsy's Staff Writer",
                  style: TextStyle(fontSize: 13),
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
