import 'package:flutter/material.dart';

class AddArtworks extends StatefulWidget {
  const AddArtworks({Key? key}) : super(key: key);
  @override
  _AddArtworksState createState() => _AddArtworksState();
}

class _AddArtworksState extends State<AddArtworks> {
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
  String? selectedRarity;
  String? selectedMedium;
  List<String> selectedPhotos = [];
  List<String> photos = [];

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

  Widget buildDropdown(String label, String value, bool isRequired,
      double? width, List<DropdownMenuItem<String>> item) {
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
                if (isRequired)
                  Text(
                    "Required",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
                value: value,
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
                    value = val!;
                  });
                },
                items: item),
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.person_outline, color: Colors.white),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text("Name"),
                      Text(
                        'Nationality',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
              buildTextField("TITLE", "Title", titleController, true, 320),
              buildDropdown(
                "MEDIUM",
                selectedMedium!,
                true,
                320,
                mediums.map((medium) {
                  return DropdownMenuItem<String>(
                    value: medium,
                    child: Text(medium),
                  );
                }).toList(),
              ),
              buildTextField(
                  "YEAR", "Year Created", yearController, false, 320),
              buildTextField(
                  "MATERIALS", "Materials", materialsController, false, 320),
              buildDropdown(
                "RARITY",
                selectedRarity!,
                false,
                320,
                rarities.map((rarity) {
                  return DropdownMenuItem<String>(
                    value: rarity,
                    child: Text(rarity),
                  );
                }).toList(),
              ),
              Text(
                "DIMENSIONS",
                style: TextStyle(fontSize: 13),
              ),
              Row(
                children: [
                  buildTextField(
                      "HEIGHT", "Height", heightController, true, 100),
                  buildTextField("WIDTH", "Width", widthController, true, 100),
                  buildTextField("DEPTH", "Depth", depthController, true, 100),
                ],
              ),
              buildTextField("PRICE PAIN", "USD\$ Price Paid", priceController,
                  false, 320),
              Container(
                  width: 320,
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
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                    ],
                  )),
              buildTextField("LOCATION", "Enter city where artwork is located",
                  locationController, false, 320),
              Container(
                  width: 320,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      Text(
                        "NOTES",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        maxLines: null,
                        controller: provenanceController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Add Notes",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                    ],
                  )),
              Divider(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        //
                      },
                      child: Text(
                        "PHOTOS",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Text(">"),
                  ],
                ),
              ),
              Divider(),
              ElevatedButton(
                onPressed: () {
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
                  minimumSize: Size(350, 45),
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
