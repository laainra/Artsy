import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/model/artistmodel.dart';
import 'package:artsy_prj/model/gallerymodel.dart';

class ArtworkListPage extends StatefulWidget {
  const ArtworkListPage({Key? key}) : super(key: key);

  @override
  _ArtworkListState createState() => _ArtworkListState();
}

class _ArtworkListState extends State<ArtworkListPage> {
  var dbHelper = DBHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController materialsController = TextEditingController();
  TextEditingController provenanceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController frameController = TextEditingController();
  TextEditingController certificateController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  int? selectedGallery;
  int? selectedArtist;
  String? selectedRarity;
  String? selectedMedium;
  String? photos;

  List<String> galleries = ['Gallery A', 'Gallery B', 'Gallery C'];
  List<String> artists = ['Artist A', 'Artist B', 'Artist C'];
  List<String> rarities = [
    'Unique',
    'Limited Edition',
    'Open Edition',
    'Unknown Edition'
  ];
  List<String> mediums = [
    'Painting',
    'Sculpture',
    'Photography',
    'Print',
    'Mixed Media',
    'Performance Art',
    'Installation',
    'Video/Film/Animation',
    'Drawing',
    'Architecture',
    'Fashion Design and Wearable Art',
    'Jewelry',
    'Design/Decorative Art',
    'Textile Arts',
    'Posters',
    'Books and Portfolios',
    'Other',
    'Ephemera or Merchandise',
    'Reproduction',
    'NFT'
  ];

  List<Map<String, dynamic>> artwork = [];
  List<Map<String, dynamic>> artistsData = [];
  List<Map<String, dynamic>> galleriesData = [];

  void refreshData() async {
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
  void initState() {
    refreshData();
    _getAllArtists().then((value) {
      setState(() {
        artistsData = value;
      });
    });
    _getAllGalleries().then((value) {
      setState(() {
        galleriesData = value;
      });
    });
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _getAllArtists() async {
    try {
      final db = await dbHelper.database;
      return db.query(DBHelper.artistTable);
    } catch (e) {
      print('Error retrieving all artists: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _getAllGalleries() async {
    try {
      final db = await dbHelper.database;
      return db.query(DBHelper.galleryTable);
    } catch (e) {
      print('Error retrieving all galleries: $e');
      return [];
    }
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
        photos = destinationFile.path;
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
      titleController.clear();
      materialsController.clear();
      provenanceController.clear();
      locationController.clear();
      notesController.clear();
      conditionController.clear();
      frameController.clear();
      certificateController.clear();
      yearController.clear();
      heightController.clear();
      widthController.clear();
      depthController.clear();
      priceController.clear();
      selectedGallery = null;
      selectedArtist = null;
      selectedRarity = null;
      selectedMedium = null;
      photos = null;
    });
  }

  void Form(id) async {
    if (id != null) {
      final dataupdate = artwork.firstWhere((element) => element["id"] == id);
      titleController.text = dataupdate["title"];
      materialsController.text = dataupdate["materials"];
      provenanceController.text = dataupdate["provenance"];
      locationController.text = dataupdate["location"];
      notesController.text = dataupdate["notes"];
      conditionController.text = dataupdate["condition"];
      frameController.text = dataupdate["frame"];
      certificateController.text = dataupdate["certificate"];
      yearController.text = dataupdate["year"].toString();
      heightController.text = dataupdate["height"].toString();
      widthController.text = dataupdate["width"].toString();
      depthController.text = dataupdate["depth"].toString();
      priceController.text = dataupdate["price"].toString();
      selectedGallery = dataupdate["gallery"];
      selectedArtist = dataupdate["artist"];
      selectedRarity = dataupdate["rarity"];
      selectedMedium = dataupdate["medium"];
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
                  decoration: const InputDecoration(hintText: "Artwork Name"),
                ),
                TextField(
                  controller: materialsController,
                  decoration: const InputDecoration(hintText: "Materials"),
                ),
                TextField(
                  controller: provenanceController,
                  decoration: const InputDecoration(hintText: "Provenance"),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(hintText: "Location"),
                ),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(hintText: "Notes"),
                ),
                TextField(
                  controller: conditionController,
                  decoration: const InputDecoration(hintText: "Condition"),
                ),
                TextField(
                  controller: frameController,
                  decoration: const InputDecoration(hintText: "Frame"),
                ),
                TextField(
                  controller: certificateController,
                  decoration: const InputDecoration(hintText: "Certificate"),
                ),
                TextField(
                  controller: yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Year"),
                ),
                TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Height"),
                ),
                TextField(
                  controller: widthController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Width"),
                ),
                TextField(
                  controller: depthController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Depth"),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Price"),
                ),
                // Artist Dropdown
                DropdownButtonFormField<int>(
                  value: selectedArtist,
                  hint: Text('Select Artist'),
                  onChanged: (value) {
                    setState(() {
                      selectedArtist = value;
                    });
                  },
                  items: artistsData.map((artist) {
                    return DropdownMenuItem<int>(
                      value: artist['id'],
                      child: Text(artist['name']),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),

                // Gallery Dropdown
                DropdownButtonFormField<int>(
                  value: selectedGallery,
                  hint: Text('Select Gallery'),
                  onChanged: (value) {
                    setState(() {
                      selectedGallery = value;
                    });
                  },
                  items: galleriesData.map((gallery) {
                    return DropdownMenuItem<int>(
                      value: gallery['id'],
                      child: Text(gallery['name']),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),

                // Rarity Dropdown
                DropdownButtonFormField<String>(
                  value: selectedRarity,
                  hint: Text('Select Rarity'),
                  onChanged: (value) {
                    setState(() {
                      selectedRarity = value;
                    });
                  },
                  items: rarities.map((rarity) {
                    return DropdownMenuItem<String>(
                      value: rarity,
                      child: Text(rarity),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),

                // Medium Dropdown
                DropdownButtonFormField<String>(
                  value: selectedMedium,
                  hint: Text('Select Medium'),
                  onChanged: (value) {
                    setState(() {
                      selectedMedium = value;
                    });
                  },
                  items: mediums.map((medium) {
                    return DropdownMenuItem<String>(
                      value: medium,
                      child: Text(medium),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () async {
                    getFilePicker();
                  },
                  child: Row(
                    children: const [
                      Text("Choose Image"),
                      Icon(Icons.camera),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (id != null) {
                      String? photoartwork = photos;
                      final data = ArtworkModel(
                        id: id,
                        title: titleController.text,
                        materials: materialsController.text,
                        provenance: provenanceController.text,
                        location: locationController.text,
                        notes: notesController.text,
                        condition: conditionController.text,
                        frame: frameController.text,
                        certificate: certificateController.text,
                        year: int.parse(yearController.text),
                        height: double.parse(heightController.text),
                        width: double.parse(widthController.text),
                        depth: double.parse(depthController.text),
                        price: priceController.text,
                        galleryId: selectedGallery,
                        artistId: selectedArtist,
                        rarity: selectedRarity!,
                        medium: selectedMedium!,
                        photos: photoartwork.toString(),
                      );
                      dbHelper.updateArtwork(data);
                      titleController.text = '';
                      clearForm();
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Update successful");
                    } else {
                      String? photoartwork = photos;
                      final data = ArtworkModel(
                        title: titleController.text,
                        materials: materialsController.text,
                        provenance: provenanceController.text,
                        location: locationController.text,
                        notes: notesController.text,
                        condition: conditionController.text,
                        frame: frameController.text,
                        certificate: certificateController.text,
                        year: int.parse(yearController.text),
                        height: double.parse(heightController.text),
                        width: double.parse(widthController.text),
                        depth: double.parse(depthController.text),
                        price: priceController.text,
                        galleryId: selectedGallery,
                        artistId: selectedArtist,
                        rarity: selectedRarity!,
                        medium: selectedMedium!,
                        photos: photoartwork.toString(),
                      );
                      dbHelper.insertArtwork(data);
                      titleController.text = '';
                      clearForm();
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Add Artwork Successful");
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
        title: Text("Artwork List", style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: artwork.length,
        itemBuilder: (context, index) {
          final currentArtwork = artwork[index];
          return Container(
            child: ListTile(
              leading: currentArtwork["photos"] != null
                  ? Image.file(File(currentArtwork["photos"]))
                  : FlutterLogo(),
              title: Text(currentArtwork["title"] ?? ''),
              subtitle: Text('Year: ${currentArtwork["year"]}' ?? ''),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Form(currentArtwork["id"]);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        dbHelper.deleteArtwork(currentArtwork["id"] ?? 0);
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
          Form(null);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
