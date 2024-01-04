import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    {
      'name': ' Velacio Cuy',
      'nationality': 'Dutch',
      'birthYear': '1912',
      'image': 'assets/images/artist6.png',
    },
    {
      'name': ' Mozhgan',
      'nationality': 'Dutch',
      'birthYear': '1804',
      'image': 'assets/images/artist7.png',
    },
  ];

  List<Map<String, dynamic>> filteredArtists = [];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
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
                  hintText: "Search artists, artworks, galleries, etc",
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
                  setState(() {
                    filteredArtists = trendingArtists
                        .where((artist) => artist['name']
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
              _searchFocusNode.hasFocus
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.clear();
                          _searchFocusNode.unfocus();
                          filteredArtists.clear();
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
                  : SizedBox(),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Recent Searches Section
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Searches",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 400,
                  height: 80,
                  child: Text(
                    "We'll save your recent searches here",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 240, 239, 239)),
                )
              ],
            ),
          ),

          // Trending Artists Section
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trending Artists",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  width: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredArtists.isNotEmpty
                        ? filteredArtists.length
                        : trendingArtists.length,
                    itemBuilder: (context, index) {
                      final artist = filteredArtists.isNotEmpty
                          ? filteredArtists[index]
                          : trendingArtists[index];
                      return Container(
                        width: 170,
                        margin: EdgeInsets.only(right: 16),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                artist['image'],
                                height: 100,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(artist['name'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    Text(
                                        artist['nationality'] +
                                            ", b." +
                                            artist['birthYear'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Artsy Collection Section
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Artsy Collection",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Container(
                  height: 250,
                  width: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ArtsyCollectionCard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArtsyCollectionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/art2.png",
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/art4.png",
                      height: 70,
                      width: 70,

                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                     "assets/images/art3.png",
                      height: 70,
                      width: 70,

                      fit: BoxFit.cover,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Collection Name",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Collection",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}