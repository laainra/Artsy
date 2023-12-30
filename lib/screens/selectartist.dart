import 'package:flutter/gestures.dart';
import 'package:artsy_prj/screens/addartwork.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/artistmodel.dart';
import 'dart:io';

class SelectArtist extends StatefulWidget {
  @override
  _SelectArtistState createState() => _SelectArtistState();
}

class _SelectArtistState extends State<SelectArtist> {
  var dbHelper = DBHelper();
  FocusNode _searchFocusNode = FocusNode();
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> artist = [
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

  void fetchArtist() async {
    final artistData = await dbHelper.getAllArtists();
    setState(() {
      artist.addAll(artistData);
    });
  }

  @override
  void initState() {
    fetchArtist();
    super.initState();
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
          "Select Artist",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
              borderRadius: BorderRadius.circular(2),
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
                            _searchFocusNode.unfocus();
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
          RichText(
            overflow: TextOverflow.clip,
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: "Can't find the artist? '",
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: "Add their name",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/add-artist');
                    },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: artist.map((artist) {
              String photoPath = artist['image'];

              Widget imageWidget;
              if (photoPath.startsWith('assets/images')) {
                imageWidget = Image.asset(
                  fit: boxFit.cover,
                  photoPath,
                  height: 250,
                );
              } else if (photoPath.startsWith(
                  '/storage/emulated/0/Android/data/com.example.artsy_prj/files/')) {
                imageWidget = Image.file(
                  fit: boxFit.cover,
                  File(photoPath),
                  height: 250,
                );
              } else {
                imageWidget = Placeholder();
              }
              return ListTile(
                leading: Container(
                  width: 50, // Set the width and height as needed
                  height: 50,
                  child: imageWidget,
                ),
                title: Text(artist['name']),
                subtitle:
                    Text("${artist['nationality']} - ${artist['birthYear']}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddArtworks(artist: artist),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
