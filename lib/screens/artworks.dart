import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/screens/detailartwork.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:artsy_prj/components/priceFormat.dart';

class ArtworksPage extends StatefulWidget {
  final UserModel? user;
  final List<Map<String, dynamic>> artworks;
  const ArtworksPage({Key? key, required this.artworks, required this.user}) : super(key: key);

  @override
  State<ArtworksPage> createState() => _ArtworksPageState();
}

class _ArtworksPageState extends State<ArtworksPage> {
  var dbHelper = DBHelper();
  List<Map<String, dynamic>> artwork = [];

  @override
  void initState() {
    super.initState();
    _loadArtworkData();
  }

  void _loadArtworkData() async {
    final data = await dbHelper.getAllArtworks();
    setState(() {
      artwork = data;
    });
    print("Data in the database:");
    for (var entry in data) {
      print(entry);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Artworks",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                              String photoPath = widget.artworks[index]['photos'];

              Widget imageWidget;

              if (photoPath.startsWith('assets/images')) {
                imageWidget = Image.asset(
                  photoPath,
                  height: 250,
                  // You can add more properties here if needed
                );
              } else if (photoPath.startsWith(
                  '/storage/emulated/0/Android/data/com.example.artsy_prj/files/')) {
                imageWidget = Image.file(
                  File(photoPath),
                  height: 250,
                  // You can add more properties here if needed
                );
              } else {
                // Handle other cases or provide a default image
                imageWidget = Placeholder();
              }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailArtworkPage(
                          user: widget.user,
                          artworkDetails: widget.artworks[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 224, 220, 220)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                              child: imageWidget),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.artworks[index]['artistName'],
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${widget.artworks[index]['title']}, ${widget.artworks[index]['year']}',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(121, 23, 22, 22),
                          ),
                        ),
                        Text(
                          widget.artworks[index]['galleryName'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(121, 23, 22, 22),
                          ),
                        ),
                        Text(
                          PriceFormatter.formatPrice(widget.artworks[index]['price']),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: widget.artworks.length,
            ),
          ),
        ],
      ),
    );
  }
}
