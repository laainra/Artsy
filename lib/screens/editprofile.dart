import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({Key? key, required this.user}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  bool isHintFilled = true;
  var checkVerifyId = false;
  var checkVerifyEmail = false;
  String profileImage = '';
  final DBHelper db = DBHelper();
  bool isFilePickerActive = false;

  Future<String> getFilePicker() async {
    if (isFilePickerActive) {
      // File picker is already active, return or show a message
      return "File picker is already active";
    }

    // Set the flag to indicate that the file picker is now active
    setState(() {
      isFilePickerActive = true;
    });

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
        profileImage =
            destinationFile.path; // Memperbarui path foto dengan path tujuan
      });
      File(sourceFile.path!).delete(); // Menghapus file sumber setelah disalin
      return destinationFile.path; // Mengembalikan path tujuan
    } else {
      return "Dokumen belum diupload"; // Mengembalikan pesan jika dokumen belum diupload
    }
  }

  @override
  void initState() {
    super.initState();

    // Set initial values for TextFields
    nameController.text = widget.user.name ?? '';
    locationController.text = widget.user.location ?? '';
    professionController.text = widget.user.profession ?? '';
    positionController.text = widget.user.positions ?? '';
    aboutController.text = widget.user.about ?? '';
    profileImage = widget.user.profileImage ?? '';
  }

  Widget buildTextField(
      String label, String hint, TextEditingController controller) {
    bool isHintFilled = controller.text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            style: TextStyle(color: isHintFilled ? Colors.black : Colors.grey),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: controller.text.isNotEmpty ? Colors.black : Colors.grey,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
            onTap: () {
              setState(() {
                isHintFilled = controller.text.isNotEmpty;
              });
            },
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
              Navigator.pop(context, widget.user);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    child: profileImage != null
                        ? Center(
                            child: ClipOval(
                              child: Image.file(
                                width: 88,
                                height: 88,
                                fit: BoxFit.cover,
                                File(widget.user.profileImage ?? ""),
                              ),
                            ),
                          )
                        : Center(child: FlutterLogo()),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    child: Text(
                      "Choose an Image",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    onPressed: () async {
                      getFilePicker();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              buildTextField(
                "FULL NAME",
                nameController.text.isNotEmpty
                    ? widget.user.name ?? "Enter Full Name"
                    : "Enter Full Name",
                nameController,
              ),
              buildTextField(
                "PRIMARY LOCATION",
                locationController.text.isNotEmpty
                    ? widget.user.location ?? "Enter Your Location"
                    : "Enter Your Location",
                locationController,
              ),
              buildTextField(
                "PROFESSION",
                professionController.text.isNotEmpty
                    ? widget.user.profession ?? "Profession or job title"
                    : "Profession or job title",
                professionController,
              ),
              buildTextField(
                "OTHER RELEVANT POSITIONS",
                positionController.text.isNotEmpty
                    ? widget.user.positions ??
                        "Memberships, institutions, positions"
                    : "Memberships, institutions, positions",
                positionController,
              ),
              buildTextField(
                "ABOUT",
                aboutController.text.isNotEmpty
                    ? widget.user.about ?? "Add a brief bio"
                    : "Add a brief bio",
                aboutController,
              ),
              CheckboxListTile(
                activeColor: Colors.black,
                checkColor: Colors.white,
                title: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "Verify Your ID ",
                        style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: ' For details, see ',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                        text: 'FAQs',
                        style: TextStyle(
                          // fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                          text: ' or contact ',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                        text: 'verification@artsy.net',
                        style: TextStyle(
                          // fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(180.0),
                //   side: BorderSide(color: Colors.grey),
                // ),
                value: checkVerifyId,
                onChanged: (value) {
                  setState(() {
                    checkVerifyId = value!;
                  });
                },
              ),
              SizedBox(height: 13),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.black,
                title: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "Verify Your Email ",
                        style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              ' Secure your acount and receive updates about your transactions on Artsy ',
                          style: TextStyle(
                              color: checkVerifyEmail
                                  ? Colors.grey
                                  : Colors.black)),
                    ],
                  ),
                ),

                controlAffinity: ListTileControlAffinity.leading,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(180.0),
                //   side: BorderSide(color: Colors.grey),
                // ),
                value: checkVerifyEmail,
                onChanged: (value) {
                  setState(() {
                    checkVerifyEmail = value!;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  UserModel updatedUser = UserModel(
                      id: widget.user.id,
                      name: nameController.text,
                      location: locationController.text,
                      profession: professionController.text,
                      positions: positionController.text,
                      about: aboutController.text,
                      profileImage: profileImage.toString(),
                      email: widget.user.email,
                      password: widget.user.password,
                      createdAt: widget.user.createdAt);

                  print(
                      "Data before update: ${widget.user.toString().toString()}");
                  print("Data after update: $updatedUser");
                  db.updateUser(updatedUser);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        user: updatedUser, // Pass the updated user to Settings
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(350, 45),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }

}
