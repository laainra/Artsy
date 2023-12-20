import 'package:flutter/material.dart';

class AddArtist extends StatefulWidget {
  const AddArtist({Key? key}) : super(key: key);
  @override
  _AddArtistState createState() => _AddArtistState();
}

class _AddArtistState extends State<AddArtist> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController birthyearController = TextEditingController();
  TextEditingController deathyearController = TextEditingController();

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
              buildTextField(
                  "ARTIST NAME", "Artist Name", nameController, true, 320),
              buildTextField("NATIONALITY", "Nationality",
                  nationalityController, false, 320),
              Row(
                children: [
                  buildTextField("BIRTH YEAR", "Birth Year",
                      birthyearController, false, 170),
                  buildTextField("DEATH YEAR", "Death Year",
                      deathyearController, false, 170),
                ],
              ),
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
                  "Add Artist",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
