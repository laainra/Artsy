import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  bool isHintFilled = false;
  var checkVerifyId = false;
  var checkVerifyEmail = false;
  Widget buildTextField(String label, String hint,
      TextEditingController controller, bool isHintFilled) {
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
              style:
                  TextStyle(color: isHintFilled ? Colors.black : Colors.grey),
              decoration: InputDecoration(
                // labelText: label,

                hintText: hint,
                hintStyle:
                    TextStyle(color: isHintFilled ? Colors.black : Colors.grey),
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
                  "FULL NAME", "Enter Full Name", nameController, isHintFilled),
              buildTextField("PRIMARY LOCATION", "Enter Your Location",
                  locationController, isHintFilled),
              buildTextField("PROFESSION", "Profession or job title",
                  professionController, isHintFilled),
              buildTextField(
                  "OTHER RELEVANT POSITIONS",
                  "Memberships, institutions, positions",
                  positionController,
                  isHintFilled),
              buildTextField(
                  "ABOUT", "Add a brief bio", positionController, isHintFilled),
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
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
