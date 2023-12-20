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
                      Text(
                        "Art",
                        style: TextStyle(fontSize: 15),
                      ),
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
                          widget.editorialDetails.length,
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
