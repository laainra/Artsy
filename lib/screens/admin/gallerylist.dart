import 'package:flutter/material.dart';
import 'dart:io';
import 'package:artsy_prj/model/gallerymodel.dart'; //
import 'dart:async'; //
import 'package:artsy_prj/dbhelper.dart'; //
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class GalleryListPage extends StatefulWidget {
  const GalleryListPage({Key? key}) : super(key: key);

  @override
  _GalleryListPageState createState() => _GalleryListPageState();
}

class _GalleryListPageState extends State<GalleryListPage> {
  var dbHelper = DBHelper(); //

  List<Map<String, dynamic>> galleries = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? photo;

  void refreshData() async {
    final data = await dbHelper.getAllGalleries();
    setState(() {
      galleries = data;
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
        photo = destinationFile.path;
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

  void clearForm() {
    setState(() {
      nameController.clear();
      locationController.clear();
      descriptionController.clear();
      photo = null;
    });
  }

  void galleryForm(id) async {
    if (id != null) {
      final dataupdate = galleries.firstWhere((element) => element["id"] == id);
      nameController.text = dataupdate["name"];
      locationController.text = dataupdate["location"];
      descriptionController.text = dataupdate["description"];
      // photoController.text = dataupdate["photo"]; // Assuming you have a photo controller
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
                  decoration: const InputDecoration(hintText: "Gallery Name"),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(hintText: "Location"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: "Description"),
                ),
                // Implement your photo input field here
                ElevatedButton(
                  onPressed: () async {
                    getFilePicker();
                  },
                  child: Row(
                    children: const [
                      Text("Select Photo"),
                      Icon(Icons.camera),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Implement your add/update logic here

                    if (id != null) {
                      // Update logic
                      String? photogallery = photo;
                      final data = GalleryModel(
                        id: id,
                        name: nameController.text,
                        location: locationController.text,
                        description: descriptionController.text,
                        photo: photogallery.toString(),
                      );
                      dbHelper.updateGallery(data);
                      clearForm();
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Update successful");
                    } else {
                      // Add logic
                      String? photogallery = photo;
                      final data = GalleryModel(
                        name: nameController.text,
                        location: locationController.text,
                        description: descriptionController.text,
                        photo: photogallery.toString(),
                      );
                      dbHelper.insertGallery(data);
                      clearForm();
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Add Gallery Successful");
                    }
                  },
                  child: Text(id == null ? "Add" : 'Update'),
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
        title: Text("Gallery List"),
      ),
      body: ListView.builder(
        itemCount: galleries.length,
        itemBuilder: (context, index) {
          final currentGallery = galleries[index];
          return Container(
            child: ListTile(
              leading: currentGallery["photo"] != null
                  ? Image.file(
                      File(currentGallery["photo"] ?? ''),
                    )
                  : FlutterLogo(),
              title: Text(currentGallery["name"] ?? ''),
              subtitle: Text(currentGallery["location"] ?? ''),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        galleryForm(currentGallery["id"]);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        dbHelper.deleteGallery(currentGallery["id"] ?? 0);
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
          galleryForm(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
