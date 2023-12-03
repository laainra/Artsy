import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/model/artistmodel.dart';
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/model/gallerymodel.dart';
import 'package:artsy_prj/model/showmodel.dart';
import 'package:artsy_prj/model/artworkshowmodel.dart';
import 'package:artsy_prj/model/auctionmodel.dart';
import 'package:artsy_prj/model/resultauctionmodel.dart';
import 'package:artsy_prj/model/editorialmodel.dart';

class DBHelper {
  static Database? _database;
  static const String artworkTable = 'artworks';
  static const String artistTable = 'artists';
  static const String galleryTable = 'galleries';
  static const String userTable = 'users';
  static const String showTable = 'shows';
  static const String artworkShowTable = 'artwork_shows';
  static const String auctionTable = 'auctions';
  static const String resultAuctionTable = 'result_auctions';
  static const String editorialTable = 'editorials';

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await initDB();
      return _database!;
    } catch (e) {
      print('Database initialization error: $e');
      rethrow;
    }
  }

  Future<Database> initDB() async {
    try {
      String path = join(await getDatabasesPath(), 'artsydb3');
      return await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (e) {
      print('Database opening error: $e');
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $userTable (
          id INTEGER PRIMARY KEY,
          email TEXT,
          password TEXT,
          profileImage TEXT,
          name TEXT,
          location TEXT,
          profession TEXT,
          positions TEXT,
          about TEXT,
          createdAt TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE $artistTable (
          id INTEGER PRIMARY KEY,
          name TEXT,
          nationality TEXT,
          birthYear TEXT,
          deathYear TEXT,
          photo TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE $galleryTable (
          id INTEGER PRIMARY KEY,
          name TEXT,
          location TEXT,
          description TEXT,
          photo TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE $artworkTable (
          id INTEGER PRIMARY KEY,
          title TEXT,
          medium TEXT,
          year TEXT,
          materials TEXT,
          rarity TEXT,
          height REAL,
          width REAL,
          depth REAL,
          price TEXT,
          provenance TEXT,
          location TEXT,
          notes TEXT,
          photos TEXT,
          condition TEXT,
          frame TEXT,
          certificate TEXT,
          artistId TEXT,
          galleryId TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE $showTable (
          id INTEGER PRIMARY KEY,
          name TEXT,
          start_date TEXT,
          end_date TEXT,
          gallery TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE $artworkShowTable (
          id INTEGER PRIMARY KEY,
          artworkId INTEGER,
          showId INTEGER,
          FOREIGN KEY (artworkId) REFERENCES $artworkTable(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
          FOREIGN KEY (showId) REFERENCES $showTable(id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )
      ''');

      await db.execute('''
        CREATE TABLE $auctionTable (
          id INTEGER PRIMARY KEY,
          artworkId INTEGER,
          presenter TEXT,
          description TEXT,
          start_datetime TEXT,
          end_datetime TEXT,
          FOREIGN KEY (artworkId) REFERENCES $artworkTable(id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )
      ''');

      await db.execute('''
        CREATE TABLE $resultAuctionTable (
          id INTEGER PRIMARY KEY,
          auctionId INTEGER,
          userId INTEGER,
          amount REAL,
          FOREIGN KEY (auctionId) REFERENCES $auctionTable(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
          FOREIGN KEY (userId) REFERENCES $userTable(id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )
      ''');

      await db.execute('''
        CREATE TABLE $editorialTable (
          id INTEGER PRIMARY KEY,
          title TEXT,
          created_at TEXT,
          author TEXT,
          content TEXT,
          image TEXT
        )
      ''');
    } catch (e) {
      print('Table creation error: $e');
      rethrow;
    }
  }

// Insert a user into the database
  Future<void> insertUser(UserModel user) async {
    try {
      final db = await database;
      await db.insert(userTable, user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting user: $e');
    }
  }

  // Retrieve a user by ID from the database
  Future<UserModel?> getUser(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        return null;
      }

      return UserModel.fromMap(maps.first);
    } catch (e) {
      print('Error retrieving user: $e');
      return null;
    }
  }

Future<UserModel?> getLogin(String email, String password) async {
  try {
    var dbClient = await database;
    var res = await dbClient.rawQuery("SELECT * FROM user WHERE email = '$email' and password = '$password'");
    
    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return null;
  } catch (e) {
    // Handle exceptions here, such as printing an error message or logging
    print("Error in getLogin: $e");
    return null; // Return null or handle the error according to your needs
  }
}


  // Retrieve all users from the database
  Future<List<UserModel>> getAllUsers() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(userTable);

      return List.generate(maps.length, (i) {
        return UserModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error retrieving all users: $e');
      return [];
    }
  }

  // Update a user in the database
  Future<void> updateUser(UserModel user) async {
    try {
      final db = await database;
      await db.update(userTable, user.toMap(),
          where: 'id = ?', whereArgs: [user.id]);
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // Delete a user by ID from the database
  Future<void> deleteUser(int id) async {
    try {
      final db = await database;
      await db.delete(userTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  // Insert an artist into the database
  Future<void> insertArtist(ArtistModel artist) async {
    try {
      final db = await database;
      await db.insert(artistTable, artist.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting artist: $e');
    }
  }

  // Retrieve an artist by ID from the database
  Future<ArtistModel?> getArtist(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query(artistTable, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        return null;
      }

      return ArtistModel.fromMap(maps.first);
    } catch (e) {
      print('Error retrieving artist: $e');
      return null;
    }
  }

  // Retrieve all artists from the database
  Future<List<Map<String, dynamic>>> getAllArtists() async {
    try {
      final db = await database;
      return db.query(artistTable);
    } catch (e) {
      print('Error retrieving all artists: $e');
      return [];
    }
  }

  // Update an artist in the database
  Future<void> updateArtist(ArtistModel artist) async {
    try {
      final db = await database;
      await db.update(artistTable, artist.toMap(),
          where: 'id = ?', whereArgs: [artist.id]);
    } catch (e) {
      print('Error updating artist: $e');
    }
  }

  // Delete an artist by ID from the database
  Future<void> deleteArtist(int id) async {
    try {
      final db = await database;
      await db.delete(artistTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting artist: $e');
    }
  }

  // Insert an artwork into the database
  Future<void> insertArtwork(ArtworkModel artwork) async {
    try {
      final db = await database;
      await db.insert(artworkTable, artwork.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting artwork: $e');
    }
  }

  // Retrieve an artwork by ID from the database
  Future<ArtworkModel?> getArtwork(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query(artworkTable, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        return null;
      }

      return ArtworkModel.fromMap(maps.first);
    } catch (e) {
      print('Error retrieving artwork: $e');
      return null;
    }
  }

  // Retrieve all artworks from the database
  Future<List<Map<String, dynamic>>> getAllArtworks() async {
    try {
      final db = await database;
      return db.query(artworkTable);
    } catch (e) {
      print('Error retrieving all artworks: $e');
      return [];
    }
  }

  // Update an artwork in the database
  Future<void> updateArtwork(ArtworkModel artwork) async {
    try {
      final db = await database;
      await db.update(artworkTable, artwork.toMap(),
          where: 'id = ?', whereArgs: [artwork.id]);
    } catch (e) {
      print('Error updating artwork: $e');
    }
  }

  // Delete an artwork by ID from the database
  Future<void> deleteArtwork(int id) async {
    try {
      final db = await database;
      await db.delete(artworkTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting artwork: $e');
    }
  }

  // Insert a gallery into the database
  Future<void> insertGallery(GalleryModel gallery) async {
    try {
      final db = await database;
      await db.insert(galleryTable, gallery.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting gallery: $e');
    }
  }

  // Retrieve a gallery by ID from the database
  Future<GalleryModel?> getGallery(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query(galleryTable, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        return null;
      }

      return GalleryModel.fromMap(maps.first);
    } catch (e) {
      print('Error retrieving gallery: $e');
      return null;
    }
  }

  // Retrieve all galleries from the database
  Future<List<Map<String, dynamic>>> getAllGalleries() async {
    try {
      final db = await database;
      return db.query(galleryTable);
    } catch (e) {
      print('Error retrieving all galleries: $e');
      return [];
    }
  }

  // Update a gallery in the database
  Future<void> updateGallery(GalleryModel gallery) async {
    try {
      final db = await database;
      await db.update(galleryTable, gallery.toMap(),
          where: 'id = ?', whereArgs: [gallery.id]);
    } catch (e) {
      print('Error updating gallery: $e');
    }
  }

  // Delete a gallery by ID from the database
  Future<void> deleteGallery(int id) async {
    try {
      final db = await database;
      await db.delete(galleryTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting gallery: $e');
    }
  }

  // Insert a show into the database
  Future<void> insertShow(ShowModel show) async {
    try {
      final db = await database;
      await db.insert(showTable, show.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting show: $e');
    }
  }

  // Retrieve a show by ID from the database
  Future<ShowModel?> getShow(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query(showTable, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        return null;
      }

      return ShowModel.fromMap(maps.first);
    } catch (e) {
      print('Error retrieving show: $e');
      return null;
    }
  }

  // Retrieve all shows from the database
  Future<List<ShowModel>> getAllShows() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(showTable);

      return List.generate(maps.length, (i) {
        return ShowModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error retrieving all shows: $e');
      return [];
    }
  }

  // Update a show in the database
  Future<void> updateShow(ShowModel show) async {
    try {
      final db = await database;
      await db.update(showTable, show.toMap(),
          where: 'id = ?', whereArgs: [show.id]);
    } catch (e) {
      print('Error updating show: $e');
    }
  }

  // Delete a show by ID from the database
  Future<void> deleteShow(int id) async {
    try {
      final db = await database;
      await db.delete(showTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting show: $e');
    }
  }

  // // Insert an artwork-show relationship into the database
  // Future<void> insertArtworkShow(ArtworkShowModel artworkShow) async {
  //   final db = await database;
  //   await db.insert(artworkShowTable, artworkShow.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // // Retrieve an artwork-show relationship by ID from the database
  // Future<ArtworkShowModel?> getArtworkShow(int id) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps =
  //       await db.query(artworkShowTable, where: 'id = ?', whereArgs: [id]);

  //   if (maps.isEmpty) {
  //     return null;
  //   }

  //   return ArtworkShowModel.fromMap(maps.first);
  // }

  // // Retrieve all artwork-show relationships from the database
  // Future<List<ArtworkShowModel>> getAllArtworkShows() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(artworkShowTable);

  //   return List.generate(maps.length, (i) {
  //     return ArtworkShowModel.fromMap(maps[i]);
  //   });
  // }

  // // Update an artwork-show relationship in the database
  // Future<void> updateArtworkShow(ArtworkShowModel artworkShow) async {
  //   final db = await database;
  //   await db.update(artworkShowTable, artworkShow.toMap(),
  //       where: 'id = ?', whereArgs: [artworkShow.id]);
  // }

  // // Delete an artwork-show relationship by ID from the database
  // Future<void> deleteArtworkShow(int id) async {
  //   final db = await database;
  //   await db.delete(artworkShowTable, where: 'id = ?', whereArgs: [id]);
  // }

  // Insert an auction into the database
  Future<void> insertAuction(AuctionModel auction) async {
    try {
      final db = await database;
      await db.insert(auctionTable, auction.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting auction: $e');
    }
  }

  // Retrieve an auction by ID from the database
  Future<AuctionModel?> getAuction(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query(auctionTable, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        return null;
      }

      return AuctionModel.fromMap(maps.first);
    } catch (e) {
      print('Error retrieving auction: $e');
      return null;
    }
  }

  // Retrieve all auctions from the database
  Future<List<AuctionModel>> getAllAuctions() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(auctionTable);

      return List.generate(maps.length, (i) {
        return AuctionModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error retrieving all auctions: $e');
      return [];
    }
  }

  // Update an auction in the database
  Future<void> updateAuction(AuctionModel auction) async {
    try {
      final db = await database;
      await db.update(auctionTable, auction.toMap(),
          where: 'id = ?', whereArgs: [auction.id]);
    } catch (e) {
      print('Error updating auction: $e');
    }
  }

  // Delete an auction by ID from the database
  Future<void> deleteAuction(int id) async {
    try {
      final db = await database;
      await db.delete(auctionTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting auction: $e');
    }
  }

  // Insert an editorial into the database
  Future<void> insertEditorial(EditorialModel editorial) async {
    try {
      final db = await database;
      await db.insert(editorialTable, editorial.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting editorial: $e');
    }
  }

  // Retrieve an editorial by ID from the database
  Future<EditorialModel?> getEditorial(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query(editorialTable, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        return null;
      }

      return EditorialModel.fromMap(maps.first);
    } catch (e) {
      print('Error retrieving editorial: $e');
      return null;
    }
  }

  // Retrieve all editorials from the database
  Future<List<EditorialModel>> getAllEditorials() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(editorialTable);

      return List.generate(maps.length, (i) {
        return EditorialModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error retrieving all editorials: $e');
      return [];
    }
  }

  // Update an editorial in the database
  Future<void> updateEditorial(EditorialModel editorial) async {
    try {
      final db = await database;
      await db.update(editorialTable, editorial.toMap(),
          where: 'id = ?', whereArgs: [editorial.id]);
    } catch (e) {
      print('Error updating editorial: $e');
    }
  }

  // Delete an editorial by ID from the database
  Future<void> deleteEditorial(int id) async {
    try {
      final db = await database;
      await db.delete(editorialTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting editorial: $e');
    }
  }

  // // Insert a result auction into the database
  // Future<void> insertResultAuction(ResultAuctionModel resultAuction) async {
  //   final db = await database;
  //   await db.insert(resultAuctionTable, resultAuction.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // // Retrieve a result auction by ID from the database
  // Future<ResultAuctionModel?> getResultAuction(int id) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps =
  //       await db.query(resultAuctionTable, where: 'id = ?', whereArgs: [id]);

  //   if (maps.isEmpty) {
  //     return null;
  //   }

  //   return ResultAuctionModel.fromMap(maps.first);
  // }

  // // Retrieve all result auctions from the database
  // Future<List<ResultAuctionModel>> getAllResultAuctions() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(resultAuctionTable);

  //   return List.generate(maps.length, (i) {
  //     return ResultAuctionModel.fromMap(maps[i]);
  //   });
  // }

  // // Update a result auction in the database
  // Future<void> updateResultAuction(ResultAuctionModel resultAuction) async {
  //   final db = await database;
  //   await db.update(resultAuctionTable, resultAuction.toMap(),
  //       where: 'id = ?', whereArgs: [resultAuction.id]);
  // }

  // // Delete a result auction by ID from the database
  // Future<void> deleteResultAuction(int id) async {
  //   final db = await database;
  //   await db.delete(resultAuctionTable, where: 'id = ?', whereArgs: [id]);
  // }

  // // Retrieve an editorial by ID from the database
  // Future<EditorialModel?> getEditorial(int id) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps =
  //       await db.query(editorialTable, where: 'id = ?', whereArgs: [id]);

  //   if (maps.isEmpty) {
  //     return null;
  //   }

  //   return EditorialModel.fromMap(maps.first);
  // }

  // // Retrieve all editorials from the database
  // Future<List<EditorialModel>> getAllEditorials() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(editorialTable);

  //   return List.generate(maps.length, (i) {
  //     return EditorialModel.fromMap(maps[i]);
  //   });
  // }

  // // Update an editorial in the database
  // Future<void> updateEditorial(EditorialModel editorial) async {
  //   final db = await database;
  //   await db.update(editorialTable, editorial.toMap(),
  //       where: 'id = ?', whereArgs: [editorial.id]);
  // }

  // // Delete an editorial by ID from the database
  // Future<void> deleteEditorial(int id) async {
  //   final db = await database;
  //   await db.delete(editorialTable, where: 'id = ?', whereArgs: [id]);
  // }
}
