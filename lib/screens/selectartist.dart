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
  List<Map<String, dynamic>> artist = [];
  // {
  //   'name': 'Leonardo Da Vinci ',
  //   'nationality': 'France',
  //   'birthYear': '1452',
  //   'photo': 'assets/images/artist1.png',
  // },
  // {
  //   'name': 'Vincent Van Gogh',
  //   'nationality': 'Dutch',
  //   'birthYear': '1853',
  //   'photo': 'assets/images/artist2.png',
  // },
  // {
  //   'name': 'Pablo Picasso',
  //   'nationality': 'Spanish',
  //   'birthYear': '1881',
  //   'photo': 'assets/images/artist3.png',
  // },
  // {
  //   'name': 'Claude Monet',
  //   'nationality': 'French ',
  //   'birthYear': '1840 ',
  //   'photo': 'assets/images/artist4.png',
  // },
  // {
  //   'name': ' Johannes Vermeer',
  //   'nationality': 'Dutch',
  //   'birthYear': '1632',
  //   'photo': 'assets/images/artist5.png',
  // },

  void fetchArtist() async {
    final data = await dbHelper.getAllArtists();
    setState(() {
      artist = data;
    });
    print("Data in the database:");
    for (var entry in data) {
      print(entry);
    }
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
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
              Expanded(
                  child: ListView.builder(
                      itemCount: artist.length,
                      itemBuilder: (context, index) {
                        final currentArtist = artist[index];
                        final imagePath = currentArtist["photo"] ??
                            ''; // Assuming "photo" contains the image path

                        Widget leadingWidget;

                        if (imagePath.isNotEmpty) {
                          final imageFile = File(imagePath);

                          if (imageFile.existsSync()) {
                            leadingWidget = Image.file(
                              imageFile,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            );
                          } else {
                            print('File does not exist: $imagePath');
                            // Handle the case where the file doesn't exist, you might want to provide a default image or show an error icon
                            leadingWidget = Icon(Icons.error, size: 50);
                          }
                        } else {
                          // Assuming "photo" is an asset path if not a file path
                          try {
                            leadingWidget = Image.asset(
                              imagePath,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            );
                          } catch (e) {
                            print('Error loading asset: $imagePath');
                            // Handle the case where the asset can't be loaded, you might want to provide a default image or show an error icon
                            leadingWidget = Icon(Icons.error, size: 50);
                          }
                        }
                        return ListTile(
                          leading: ClipOval(
                            child: Container(
                              width: 50, // Set the width and height as needed
                              height: 50,
                              child: leadingWidget,
                            ),
                          ),
                          title: Text(currentArtist['name']),
                          subtitle: Text(
                              "${currentArtist['nationality']} - ${currentArtist['birthYear']}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddArtworks(artist: currentArtist),
                              ),
                            );
                          },
                        );
                      })),
            ],
          ),
        ));
  }
}
