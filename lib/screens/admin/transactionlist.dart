import 'package:flutter/material.dart';
import 'package:artsy_prj/model/transactionmodel.dart';
import 'dart:async';
import 'dart:io';
import 'package:artsy_prj/dbhelper.dart';

class TransactionListPage extends StatefulWidget {
  @override
  TransactionListPageState createState() => TransactionListPageState();
}

class TransactionListPageState extends State<TransactionListPage> {
  var dbHelper = DBHelper();
  List<Map<String, dynamic>> artistsData = [];
  List<Map<String, dynamic>> galleriesData = [];
  List<Map<String, dynamic>> transactionsData = [];

  Future<void> refreshData() async {
    await dbHelper.getAllTransactionsWithDetails().then((value) {
      setState(() {
        transactionsData = value;
      });
    });
  }

  @override
  void initState() {
    refreshData();
    dbHelper.getAllArtists().then((value) {
      setState(() {
        artistsData = value;
      });
    });
    dbHelper.getAllGalleries().then((value) {
      setState(() {
        galleriesData = value;
      });
    });
    dbHelper.getAllTransactionsWithDetails().then((value) {
      setState(() {
        transactionsData = value;
      });
    });
    super.initState();
  }

  Widget buildTransactionDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4), // Adjust the spacing between label and value
        Container(
          child: Text(
            value,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  String getGalleryNameById(dynamic galleryId) {
    if (galleryId is int) {
      var gallery = galleriesData.firstWhere(
          (element) => element['id'] == galleryId,
          orElse: () => {'name': 'Unknown Gallery'});
      return gallery['name'];
    } else {
      // Handle the case when galleryId is not an int (e.g., it might be a String)
      return 'Unknown Gallery';
    }
  }

  Future<void> validateTransaction(int transactionId, String newStatus) async {
    await dbHelper.updateTransactionStatus(transactionId, newStatus);
    _showSnackBar(context, "Transaction validated successfully");
    setState(() {});
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
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Transaction List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: transactionsData.length,
          itemBuilder: (context, index) {
            var currentTransaction = transactionsData[index];
            String photoPath =
                currentTransaction['artworkPhoto'] ?? 'assets/images/art4.png';

            Widget imageWidget;

            if (photoPath.startsWith('assets/images')) {
              imageWidget = Image.asset(
                photoPath,
                height: 120,
                // You can add more properties here if needed
              );
            } else if (photoPath.startsWith(
                '/storage/emulated/0/Android/data/com.example.artsy_prj/files/')) {
              imageWidget = Image.file(
                File(photoPath),
                height: 120,
                // You can add more properties here if needed
              );
            } else {
              // Handle other cases or provide a default image
              imageWidget = Placeholder();
            }
            return Card(
              child: Container(
                padding: EdgeInsets.all(2.0),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(180),
                          ),
                          child: Text(
                            (index + 1)
                                .toString(), // Display the index (add 1 to start from 1)
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        imageWidget,
                      ],
                    ),
                    buildTransactionDetailRow(
                        "Name:", currentTransaction["name"]),
                    buildTransactionDetailRow(
                        "Artwork Title:", currentTransaction["artworkTitle"]),
                    buildTransactionDetailRow(
                        "Total Amount:", currentTransaction["amount"]),
                    buildTransactionDetailRow(
                        "Address:", currentTransaction["address"]),
                    buildTransactionDetailRow(
                        "Status:", currentTransaction["status"]),
                    Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            currentTransaction["status"] == 'Success'
                                ? validateTransaction(
                                    currentTransaction['id'], 'Failed')
                                : validateTransaction(
                                    currentTransaction['id'], 'Success');
                          },
                          child: Text(
                            currentTransaction["status"] == 'Success'
                                ? 'Invalidate'
                                : 'Validate',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDeleteConfirmation(currentTransaction);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteTransaction(int id) async {
    if (id != null) {
      var dbHelper = DBHelper();
      dbHelper.deleteTransaction(id);
      _showSnackBar(context, "Data deleted successfully");
    } else {
      _showSnackBar(context, "Error deleting data ID is null.");
    }
  }

  void handleDelete(Map<String, dynamic> transaction) async {
    int id = transaction['id'];
    await _deleteTransaction(id);
    setState(() {});
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void showDeleteConfirmation(Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Transaction"),
          content: Text("Are you sure you want to delete this transaction?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                handleDelete(transaction);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
