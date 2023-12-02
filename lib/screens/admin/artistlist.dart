import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/artistmodel.dart';

// Future<List<ArtistModel>> fetchUserFromDatabase() async {
//   var dbHelper = DBHelper();
//   var db = await dbHelper.database;

//   if (db != null) {
//     List<Map<String, dynamic>> maps = await dbHelper.getAllArtists();
//     // Convert the list of maps to a list of ArtistModel
//     return List.generate(maps.length, (index) {
//       return ArtistModel(
//         id: maps[index]['id'],
//         name: maps[index]['name'],
//         nationality: maps[index]['nationality'],
//         birthYear: maps[index]['birthYear'],
//         deathYear: maps[index]['deathYear'],
//         photo: maps[index]['photo'],
//       );
//     });
//   } else {
//     return [];
//   }
// }

class ArtistList extends StatefulWidget {
  const ArtistList({Key? key}) : super(key: key);

  @override
  _ArtistListState createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  var dbHelper = DBHelper(); //
  TextEditingController nameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController birthYearController = TextEditingController();
  TextEditingController deathYearController = TextEditingController();
  List<Map<String, dynamic>> artist = [];
  String? photoprofile;

  void refreshData() async {
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
    refreshData();
    super.initState();
  }

  Future<String> getFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'webm'],
    );

    if (result != null) {
      PlatformFile sourceFile = result.files.first;
      final destination = await getExternalStorageDirectory();
      File? destinationFile =
          File('${destination!.path}/${sourceFile.name.hashCode}');
      final newFile = File(sourceFile.path!).copy(destinationFile!.path);
      setState(() {
        photoprofile = destinationFile.path;
      });
      File(sourceFile.path!).delete();
      return destinationFile.path;
    } else {
      return "Photo not uploaded!";
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void Form(id) async {
    if (id != null) {
      final dataupdate = artist.firstWhere((element) => element["id"] == id);
      nameController.text = dataupdate["name"];
      nationalityController.text = dataupdate["nationality"] ?? '';
      birthYearController.text = dataupdate["birthYear"] ?? '';
      deathYearController.text = dataupdate["deathYear"] ?? '';
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 800,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Artist Name"),
                ),
                TextField(
                  controller: nationalityController,
                  decoration: const InputDecoration(hintText: "Nationality"),
                ),
                TextField(
                  controller: birthYearController,
                  decoration: const InputDecoration(hintText: "Birth Year"),
                ),
                TextField(
                  controller: deathYearController,
                  decoration: const InputDecoration(hintText: "Death Year"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    getFilePicker();
                  },
                  child: Row(
                    children: const [
                      Text("Pilih Gambar"),
                      Icon(Icons.camera),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (id != null) {
                      String? photo = photoprofile;
                      final data = ArtistModel(
                        id: id,
                        name: nameController.text,
                        nationality: nationalityController.text,
                        birthYear: birthYearController.text,
                        deathYear: deathYearController.text,
                        photo: photo.toString(),
                      );
                      dbHelper.updateArtist(data);
                      nameController.text = '';
                      nationalityController.text = '';
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Update successful");
                    } else {
                      String? photo = photoprofile;
                      final data = ArtistModel(
                        name: nameController.text,
                        nationality: nationalityController.text,
                        birthYear: birthYearController.text,
                        deathYear: deathYearController.text,
                        photo: photo.toString(),
                      );
                      dbHelper.insertArtist(data);
                      nameController.text = '';
                      nationalityController.text = '';
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Add Artist Successful");
                    }
                  },
                  child: Text(id == null ? "add" : 'Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Artist List"),
      ),
      body: ListView.builder(
        itemCount: artist.length,
        itemBuilder: (context, index) {
          final currentArtist = artist[index];
          return Container(
            child: ListTile(
              leading: currentArtist["photo"] != null
                  ? Image.file(
                      File(currentArtist["photo"] ?? ''),
                    )
                  : FlutterLogo(),
              title: Text(currentArtist["name"] ?? ''),
              subtitle: Text('b. ${currentArtist["birthYear"]}' ?? ''),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Form(currentArtist["id"]);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        dbHelper.deleteArtist(currentArtist["id"] ?? 0);
                        refreshData();
                        showSnackBar("Delete successful");
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Form(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
