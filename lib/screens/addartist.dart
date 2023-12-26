import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/artistmodel.dart';
import 'dart:io';

class AddArtist extends StatefulWidget {
  const AddArtist({Key? key}) : super(key: key);
  @override
  _AddArtistState createState() => _AddArtistState();
}

class _AddArtistState extends State<AddArtist> {
  var dbHelper = DBHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController birthyearController = TextEditingController();
  TextEditingController deathyearController = TextEditingController();
  String? photoprofile;
  List<Map<String, dynamic>> artist = [];
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

  Widget buildTextField(String label, String hint,
      TextEditingController controller, bool isRequired, double? width) {
    return Container(
        width: width,
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(width: 8),
                if (isRequired)
                  Text(
                    "Required",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                // labelText: label,

                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Add Artist",
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
              // Fungsi untuk kembali ke halaman sebelumnya
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(180),
                    ),
                    child: Icon(Icons.person_outline, color: Colors.white),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    child: Text(
                      "Choose an Image",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    onPressed: () {
                      //
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              buildTextField(
                  "ARTIST NAME", "Artist Name", nameController, true, 370),
              buildTextField("NATIONALITY", "Nationality",
                  nationalityController, false, 370),
              Row(
                children: [
                  buildTextField("BIRTH YEAR", "Birth Year",
                      birthyearController, false, 180),
                  SizedBox(
                    width: 10,
                  ),
                  buildTextField("DEATH YEAR", "Death Year",
                      deathyearController, false, 180),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  String? photo = photoprofile;
                  final data = ArtistModel(
                    name: nameController.text,
                    nationality: nationalityController.text,
                    birthYear: birthyearController.text,
                    deathYear: deathyearController.text,
                    photo: photo.toString(),
                  );
                  dbHelper.insertArtist(data);
                  nameController.text = '';
                  nationalityController.text = '';
                  Navigator.pop(context);
                  refreshData();
                  showSnackBar("Add Artist Successful");
                  // Call the callback function to pass shipping information
                  // widget.onSavePayment(paymentInfo);
                  //                     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ReviewPage(
                  //       shipping: widget.shipping,
                  //       artwork: widget.artwork,
                  //       payment: paymentInfo
                  //     ),
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(370, 45),
                ),
                child: Text(
                  "Add Artist",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
