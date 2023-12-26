import 'package:artsy_prj/model/artistmodel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/artworkmodel.dart';

class AddArtworks extends StatefulWidget {
  final Map<String, dynamic> artist;
  // final ArtistModel artist;
  const AddArtworks({Key? key, required this.artist}) : super(key: key);
  @override
  _AddArtworksState createState() => _AddArtworksState();
}

class _AddArtworksState extends State<AddArtworks> {
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
  bool isRequired = false;
  int? selectedGallery;
  int? selectedArtist;

  String? _selectedMedium = '';
  String? _selectedRarity = '';
  String? selectedPhotos = '';
  String? photos = '';

  List<String> galleries = ['Gallery A', 'Gallery B', 'Gallery C'];
  List<String> artists = ['Artist A', 'Artist B', 'Artist C'];
  // List<String> rarities = [
  //   'Unique',
  //   'Limited Edition',
  //   'Open Edition',
  //   'Unknown Edition'
  // ];
  // List<String> mediums = [
  //   'Painting',
  //   'Sculpture',
  //   'Photography',
  //   'Print',
  //   'Mixed Media',
  //   'Performance Art',
  //   'Installation',
  //   'Video/Film/Animation',
  //   'Drawing',
  //   'Architecture',
  //   'Fashion Design and Wearable Art',
  //   'Jewelry',
  //   'Design/Decorative Art',
  //   'Textile Arts',
  //   'Posters',
  //   'Books and Portfolios',
  //   'Other',
  //   'Ephemera or Merchandise',
  //   'Reproduction',
  //   'NFT'
  // ];
  List<String> mediums = [];
  List<String> rarities = [];

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
    rarities = ['Unique', 'Limited Edition', 'Open Edition', 'Unknown Edition'];
    mediums = [
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
    _selectedMedium = mediums.first;
    _selectedRarity = rarities.first;
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
    //
    // Fungsi untuk memilih file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // Menampilkan dialog pemilih file
      type: FileType.custom, // Menentukan tipe file yang diizinkan
      allowedExtensions: [
        'jpg',
        'png',
        'webm'
      ], // Menentukan ekstensi file yang diizinkan
    );

    if (result != null) {
      // Jika file dipilih
      PlatformFile sourceFile =
          result.files.first; // Mengambil file pertama dari hasil pemilihan
      final destination =
          await getExternalStorageDirectory(); // Mendapatkan direktori penyimpanan eksternal
      File? destinationFile = File(
          '${destination!.path}/${sourceFile.name.hashCode}'); // Menentukan path tujuan file
      final newFile = File(sourceFile.path!)
          .copy(destinationFile!.path); // Menyalin file ke lokasi tujuan
      setState(() {
        photos =
            destinationFile.path; // Memperbarui path foto dengan path tujuan
      });
      File(sourceFile.path!).delete(); // Menghapus file sumber setelah disalin
      return destinationFile.path; // Mengembalikan path tujuan
    } else {
      return "Dokumen belum diupload"; // Mengembalikan pesan jika dokumen belum diupload
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  width: 5,
                ),
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

  Widget buildDropdown(
    String label,
    String selectedValue,
    bool isRequired,
    double? width,
    List<DropdownMenuItem<String>> items,
  ) {
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
              SizedBox(
                width: 5,
              ),
              if (isRequired)
                Text(
                  "Required",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedValue,
            hint: Text('Select'),
            decoration: InputDecoration(
              hintText: "Select",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              setState(() {
                if (label == "MEDIUM") {
                  _selectedMedium = val!;
                } else if (label == "RARITY") {
                  _selectedRarity = val!;
                }
              });
            },
            items: items,
          ),
        ],
      ),
    );
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
              // Fungsi untuk kembali ke halaman sebelumnya
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.artist['image']),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.artist["name"]),
                      Text(
                        widget.artist["nationality"],
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              buildTextField("TITLE", "Title", titleController, true, 370),
              buildDropdown(
                "MEDIUM",
                _selectedMedium!,
                true,
                370,
                mediums.map((medium) {
                  return DropdownMenuItem<String>(
                    value: medium,
                    child: Text(medium),
                  );
                }).toList(),
              ),
              buildTextField(
                  "YEAR", "Year Created", yearController, false, 370),
              buildTextField(
                  "MATERIALS", "Materials", materialsController, false, 370),
              buildDropdown(
                "RARITY",
                _selectedRarity!,
                false,
                370,
                rarities.map((rarity) {
                  return DropdownMenuItem<String>(
                    value: rarity,
                    child: Text(rarity),
                  );
                }).toList(),
              ),
              Text(
                "DIMENSIONS",
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.start,
              ),
              Row(
                children: [
                  buildTextField(
                      "HEIGHT", "Height", heightController, false, 110),
                  SizedBox(
                    width: 10,
                  ),
                  buildTextField("WIDTH", "Width", widthController, false, 110),
                  SizedBox(
                    width: 10,
                  ),
                  buildTextField("DEPTH", "Depth", depthController, false, 110),
                ],
              ),
              buildTextField("PRICE PAIN", "USD\$ Price Paid", priceController,
                  false, 370),
              Container(
                  width: 370,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "PROVENANCE",
                            style: TextStyle(fontSize: 13),
                          ),
                          if (isRequired)
                            Text(
                              "Required",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextField(
                        maxLines: null,
                        controller: provenanceController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Describe how you acquired the artwork",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                        ),
                      ),
                    ],
                  )),
              buildTextField("LOCATION", "Enter city where artwork is located",
                  locationController, false, 370),
              Container(
                  width: 370,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NOTES",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        maxLines: null,
                        controller: notesController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Add Notes",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                        ),
                      ),
                    ],
                  )),
              Divider(),
              GestureDetector(
                onTap: () async {
                  getFilePicker();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PHOTOS",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(">"),
                    ],
                  ),
                ),
              ),
              Divider(),
              ElevatedButton(
                onPressed: () {

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
                        rarity: _selectedRarity!,
                        medium: _selectedMedium!,
                        photos: photoartwork.toString(),
                      );
                      dbHelper.insertArtwork(data);
                      titleController.text = '';
                      Navigator.pop(context);
                      refreshData();
                      showSnackBar("Add Artwork Successful");
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
                  "Complete",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
