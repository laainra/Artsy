import 'package:flutter/material.dart';

class SelectArtist extends StatefulWidget {
  @override
  _SelectArtistState createState() => _SelectArtistState();
}

class _SelectArtistState extends State<SelectArtist> {
  FocusNode _searchFocusNode = FocusNode();
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> trendingArtists = [
    {
      'name': 'Leonardo Da Vinci ',
      'nationality': 'France',
      'birthYear': '1452',
      'image': 'assets/images/artist1.png',
    },
    {
      'name': 'Vincent Van Gogh',
      'nationality': 'Dutch',
      'birthYear': '1853',
      'image': 'assets/images/artist2.png',
    },
    {
      'name': 'Pablo Picasso',
      'nationality': 'Spanish',
      'birthYear': '1881',
      'image': 'assets/images/artist3.png',
    },
    {
      'name': 'Claude Monet',
      'nationality': 'French ',
      'birthYear': '1840 ',
      'image': 'assets/images/artist4.png',
    },
    {
      'name': ' Johannes Vermeer',
      'nationality': 'Dutch',
      'birthYear': '1632',
      'image': 'assets/images/artist5.png',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Add a listener to the FocusNode to update the state
    _searchFocusNode.addListener(() {
      setState(() {});
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
          "Edit Profile",
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
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            height: 50,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(_searchFocusNode.hasFocus ? 2 : 2),
              border: Border.all(color: Colors.grey),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8, right: 10),
                    hintText: "Search for artists on Artsy",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                  onChanged: (value) {
                    // Handle search input change
                  },
                ),
                _searchFocusNode.hasFocus
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _searchController.clear();
                            _searchFocusNode.unfocus(); // Remove focus
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                      )
                    : SizedBox(), // Empty container if not focused
              ],
            ),
          ),
          RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
            TextSpan(text: "Can't find the artist?"),
            TextSpan(
                text: "Add their name",
                style: TextStyle(decoration: TextDecoration.underline)),
          ])),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(Icons.person_outline, color: Colors.white),
              ),
              Text("Nama Artist")
            ],
          ),
        ],
      ),
    );
  }
}
