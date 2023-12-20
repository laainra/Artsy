import 'package:flutter/material.dart';

class SavesTab extends StatefulWidget {
  const SavesTab({Key? key}) : super(key: key);
  @override
  _SavesTabState createState() => _SavesTabState();
}

class _SavesTabState extends State<SavesTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 217, 207, 207),
                    border: Border.all(
                        color: Colors.black, width: 1), // Border added here
                  ),
                  child: Icon(Icons.browser_not_supported_outlined),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 217, 207, 207),
                    border: Border.all(
                        color: Colors.black, width: 1),
                  ),
                  child: Icon(Icons.browser_not_supported_outlined),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 217, 207, 207),
                    border: Border.all(
                        color: Colors.black, width: 1), // Border added here
                  ),
                  child: Icon(Icons.browser_not_supported_outlined),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 217, 207, 207),
                    border: Border.all(
                        color: Colors.black, width: 1), // Border added here
                  ),
                  child: Icon(Icons.browser_not_supported_outlined),
                )
              ],
            ),
            Text("Saved Artworks"),
            Text(
              "0 Artworks",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ));
  }
}
