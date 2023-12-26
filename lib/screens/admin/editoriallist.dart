import 'package:artsy_prj/model/editorialmodel.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async'; //
import 'package:artsy_prj/dbhelper.dart'; //
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditorialListPage extends StatefulWidget {
  const EditorialListPage({Key? key}) : super(key: key);

  @override
  _EditorialListPageState createState() => _EditorialListPageState();
}

class _EditorialListPageState extends State<EditorialListPage> {
  var dbHelper = DBHelper(); //

  List<Map<String, dynamic>> editorials = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String? image;

  void refreshData() async {
    final data = await dbHelper.getAllEditorials();
    setState(() {
      editorials = data;
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
      allowMultiple: true,  
      allowedExtensions: ['jpg', 'png', 'webm'],
    );

    if (result != null) {
      PlatformFile sourceFile = result.files.first;
      final destination = await getExternalStorageDirectory();
      File? destinationFile =
          File('${destination!.path}/${sourceFile.name.hashCode}');
      final newFile = File(sourceFile.path!).copy(destinationFile!.path);
      setState(() {
        image = destinationFile.path;
      });
      File(sourceFile.path!).delete();
      return destinationFile.path;
    } else {
      return "image not uploaded!";
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
      titleController.clear();
      authorController.clear();
      contentController.clear();
      image = null;
    });
  }

  void editorialForm(id) async {
    if (id != null) {
      final dataupdate = editorials.firstWhere((element) => element["id"] == id);
      titleController.text = dataupdate["title"];
      authorController.text = dataupdate["author"];
      contentController.text = dataupdate["content"];
      // imageController.text = dataupdate["image"]; // Assuming you have a image controller
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
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "Editorial title"),
                ),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(hintText: "author"),
                ),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(hintText: "content"),
                ),
                // Implement your image input field here
                ElevatedButton(
                  onPressed: () async {
                    getFilePicker();
                  },
                  child: Row(
                    children: const [
                      Text("Select image"),
                      Icon(Icons.camera),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Implement your add/update logic here

                    if (id != null) {
                      // Update logic
                      String? imageEditorial = image;
                      final data = EditorialModel(
                        id: id,
                        title: titleController.text,
                        author: authorController.text,
                        content: contentController.text,
                        image: imageEditorial.toString(),
                      );
                      dbHelper.updateEditorial(data);
                      clearForm();
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Update successful");
                    } else {
                      // Add logic
                      String? imageEditorial = image;
                      final data = EditorialModel(
                        title: titleController.text,
                        author: authorController.text,
                        content: contentController.text,
                        image: imageEditorial.toString(),
                      );
                      dbHelper.insertEditorial(data);
                      clearForm();
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Add Editorial Successful");
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
            // Fungsi untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
              backgroundColor: Colors.white,
        title: Text("Editorial List",style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: editorials.length,
        itemBuilder: (context, index) {
          final currentEditorial = editorials[index];
          return Container(
            child: ListTile(
              leading: currentEditorial["image"][0] != null
                  ? Image.file(
                      File(currentEditorial["image"][0] ?? ''),
                    )
                  : FlutterLogo(),
              title: Text(currentEditorial["title"] ?? ''),
              subtitle: Text(currentEditorial["author"] ?? ''),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        editorialForm(currentEditorial["id"]);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        dbHelper.deleteEditorial(currentEditorial["id"] ?? 0);
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
        backgroundColor: Colors.black,
        onPressed: () {
          editorialForm(null);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
