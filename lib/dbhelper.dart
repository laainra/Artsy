import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/model/artistmodel.dart';
import 'package:artsy_prj/model/artworkmodel.dart';
import 'package:artsy_prj/model/gallerymodel.dart';
import 'package:artsy_prj/model/showmodel.dart';
import 'package:artsy_prj/model/auctionmodel.dart';
import 'package:artsy_prj/model/editorialmodel.dart';
import 'package:artsy_prj/model/likemodel.dart';
import 'package:artsy_prj/model/transactionmodel.dart';

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
  static const String likeTable = 'likes';
  static const String transactionTable = 'transactions';
  static const String createdAtColumn = 'createdAt';

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await initDB();
      // await _seedData(_database!);
      return _database!;
    } catch (e) {
      print('Database initialization error: $e');
      rethrow;
    }
  }

  Future<Database> initDB() async {
    try {
      String path = join(await getDatabasesPath(), 'Artsy-DB');
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
          $createdAtColumn TEXT
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
          status TEXT DEFAULT 'sell',
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
          $createdAtColumn TEXT,
          author TEXT,
          content TEXT,
          image TEXT
        )
      ''');

      await db.execute('''
          CREATE TABLE $transactionTable(
            id INTEGER PRIMARY KEY,
            artworkId INTEGER,
            paymentMethod TEXT,
            name TEXT,
            phoneNumber TEXT,
            email TEXT,
            amount REAL,
            status TEXT,
            address TEXT,
            shippingMethod TEXT,
            description TEXT,
            createdAt TEXT,
            FOREIGN KEY (artworkId) REFERENCES $artworkTable(id) ON DELETE NO ACTION ON UPDATE NO ACTION

          )
        ''');

      await db.execute('''
  CREATE TABLE $likeTable (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    artwork_id INTEGER,
    created_at TEXT,
    FOREIGN KEY (user_id) REFERENCES $userTable(id) ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (artwork_id) REFERENCES $artworkTable(id) ON DELETE CASCADE ON UPDATE NO ACTION
  )
''');
    } catch (e) {
      print('Table creation error: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllArtworksWithDetails() async {
    try {
      final db = await database;

      // Perform a join operation to get artist and gallery names
      final result = await db.rawQuery('''
      SELECT 
        artworks.*, 
        artists.name AS artistName, 
        artists.nationality AS artistNationality, 
        artists.birthYear AS artistBirthYear, 
        artists.photo AS artistPhoto, 
        galleries.name AS galleryName,
        galleries.location AS galleryLocation,
        galleries.photo AS galleryPhoto
      FROM 
        artworks 
        LEFT JOIN artists ON artworks.artistId = artists.id 
        LEFT JOIN galleries ON artworks.galleryId = galleries.id;
    ''');

      return result;
    } catch (e) {
      print('Error retrieving artwork details: $e');
      return [];
    }
  }

Future<List<Map<String, dynamic>>> getAllTransactionsWithDetails() async {
  try {
    final db = await database;

    // Perform a join operation to get artist and gallery names
    final result = await db.rawQuery('''
      SELECT 
        transactions.*, 
        artworks.title AS artworkTitle, 
        artworks.galleryId AS artworkGallery, 
        artworks.artistId AS artworkArtist, 
        artworks.photos AS artworkPhoto
      FROM 
        artworks 
      LEFT JOIN transactions ON transactions.artworkId = artworks.id 
    ''');

    // Handle null values
    final processedResult = result.map((row) {
      return row.map((key, value) {
        // Replace null values with an appropriate default value
        return MapEntry(key, value ?? 'N/A');
      });
    }).toList();

    return processedResult;
  } catch (e) {
    print('Error retrieving artwork details: $e');
    return [];
  }
}

  Future<void> updateTransactionStatus(
      int transactionId, String newStatus) async {
    try {
      final db = await database;
      await db.update(
        'transactions',
        {'status': newStatus},
        where: 'id = ?',
        whereArgs: [transactionId],
      );
    } catch (e) {
      print('Error updating transaction status: $e');
    }
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await database;
    return db.insert(transactionTable, transaction.toMap());
  }

  Future<TransactionModel?> getTransactionById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      transactionTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TransactionModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Add the following method to delete all records from the artworks table
  Future<void> deleteAllArtworks() async {
    final db = await database;
    await db.delete('artworks');
  }

  Future<void> deleteAllArtists() async {
    final db = await database;
    await db.delete('artists');
  }

  Future<void> deleteAllEditorials() async {
    final db = await database;
    await db.delete('editorials');
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(transactionTable);
    return List.generate(maps.length, (i) {
      return TransactionModel.fromMap(maps[i]);
    });
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await database;
    return db.update(
      transactionTable,
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return db.delete(
      transactionTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// Insert a user into the database
  Future<void> insertUser(UserModel user) async {
    try {
      final db = await database;

      // Add createdAt field with the current date and time
      final createdAt = DateTime.now().toIso8601String();
      final userMap = user.toMap()..['createdAt'] = createdAt;

      await db.insert(userTable, userMap,
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

  Future<bool> getLogin(UserModel user) async {
    var dbClient = await database;
    var res = await dbClient.rawQuery(
      "SELECT * FROM users WHERE email = ? and password = ?",
      [user.email, user.password],
    );

    return res.isNotEmpty;
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps =
          await db.rawQuery("SELECT * from users");

      // Convert the list of maps into a list of UserModel objects
      List<UserModel> users = List.generate(maps.length, (i) {
        return UserModel.fromMap(maps[i]);
      });

      return users;
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

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    } else {
      return null;
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

  Future<List<Map<String, dynamic>>> getAllArtists() async {
    try {
      final db = await database;
      return db.query(artistTable);
    } catch (e) {
      print('Error retrieving all artists: $e');
      return [];
    }
  }

  Future<void> updateArtist(ArtistModel artist) async {
    try {
      final db = await database;
      await db.update(artistTable, artist.toMap(),
          where: 'id = ?', whereArgs: [artist.id]);
    } catch (e) {
      print('Error updating artist: $e');
    }
  }

  Future<void> deleteArtist(int id) async {
    try {
      final db = await database;
      await db.delete(artistTable, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting artist: $e');
    }
  }

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

  // Insert a like into the database
  Future<void> insertLike(LikeModel like) async {
    try {
      final db = await database;
      await db.insert(likeTable, like.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting like: $e');
    }
  }

// Retrieve all likes for a specific artwork
  Future<List<LikeModel>> getArtworkLikes(int artworkId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db
          .query(likeTable, where: 'artwork_id = ?', whereArgs: [artworkId]);

      return List.generate(maps.length, (i) {
        return LikeModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error retrieving artwork likes: $e');
      return [];
    }
  }

// Check if a user has liked a specific artwork
  Future<bool> hasUserLikedArtwork(int userId, int artworkId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(likeTable,
          where: 'user_id = ? AND artwork_id = ?',
          whereArgs: [userId, artworkId]);

      return maps.isNotEmpty;
    } catch (e) {
      print('Error checking if user has liked artwork: $e');
      return false;
    }
  }

// Delete a like by user and artwork ID from the database
  Future<void> deleteLike(int userId, int artworkId) async {
    try {
      final db = await database;
      await db.delete(likeTable,
          where: 'user_id = ? AND artwork_id = ?',
          whereArgs: [userId, artworkId]);
    } catch (e) {
      print('Error deleting like: $e');
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
      final createdAt = DateTime.now().toIso8601String();
      final editorialMap = editorial.toMap()..['createdAt'] = createdAt;
      await db.insert(editorialTable, editorialMap,
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
  Future<List<Map<String, dynamic>>> getAllEditorials() async {
    try {
      final db = await database;
      return db.query(editorialTable);
    } catch (e) {
      print('Error retrieving all galleries: $e');
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

  Future<void> _seedData(Database db) async {
    try {
      await _seedUsers(db);
      await _seedArtists(db);
      await _seedGalleries(db);
      await _seedArtworks(db);
    } catch (e) {
      print('Seeding error: $e');
      rethrow;
    }
  }

  Future<void> _seedUsers(Database db) async {
    for (int i = 1; i <= 3; i++) {
      await db.rawInsert('''
      INSERT INTO $userTable (email, password, profileImage, name, location, profession, positions, about, createdAt)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
        'user$i@example.com',
        'password$i',
        'profile_image_url$i',
        'User $i',
        'Location $i',
        'Profession $i',
        'Positions $i',
        'About user $i',
        DateTime.now().toIso8601String(),
      ]);
    }
  }

  Future<void> _seedArtists(Database db) async {
    await db.rawInsert('''
    INSERT INTO $artistTable (name, nationality, birthYear, deathYear, photo)
    VALUES (?, ?, ?, ?, ?)
  ''', ['Vincent van Gogh', 'Dutch', 1853, 1890, 'assets/images/vangogh.jpeg']);

    await db.rawInsert('''
    INSERT INTO $artistTable (name, nationality, birthYear, deathYear, photo)
    VALUES (?, ?, ?, ?, ?)
  ''', [
      'Leonardo da Vinci',
      'Italian',
      1452,
      1519,
      'assets/images/davinci.jpeg'
    ]);

    await db.rawInsert('''
    INSERT INTO $artistTable (name, nationality, birthYear, deathYear, photo)
    VALUES (?, ?, ?, ?, ?)
  ''', ['Claude Monet', 'French', 1840, 1926, 'assets/images/monet.jpeg']);

    await db.rawInsert('''
    INSERT INTO $artistTable (name, nationality, birthYear, deathYear, photo)
    VALUES (?, ?, ?, ?, ?)
  ''', ['Frida Kahlo', 'Mexican', 1907, 1954, 'assets/images/kahlo.jpg']);

    await db.rawInsert('''
    INSERT INTO $artistTable (name, nationality, birthYear, deathYear, photo)
    VALUES (?, ?, ?, ?, ?)
  ''', ['Pablo Picasso', 'Spanish', 1881, 1973, 'assets/images/picasso.jpg']);
  }

  Future<void> _seedGalleries(Database db) async {
    await db.rawInsert('''
    INSERT INTO $galleryTable (name, location, description, photo)
    VALUES (?, ?, ?, ?)
  ''', [
      'Ciputra Artpreneur',
      'Jakarta, Indonesia',
      'A vibrant space showcasing contemporary Indonesian art, fostering dialogue and creativity.',
      'assets/images/ciputra.jpg'
    ]);

    await db.rawInsert('''
    INSERT INTO $galleryTable (name, location, description, photo)
    VALUES (?, ?, ?, ?)
  ''', [
      'National Gallery Singapore',
      'Singapore',
      'Home to the worlds largest public collection of Singaporean and Southeast Asian art, spanning centuries of artistic expression.',
      'assets/images/singapore.jpg'
    ]);

    await db.rawInsert('''
    INSERT INTO $galleryTable (name, location, description, photo)
    VALUES (?, ?, ?, ?)
  ''', [
      'The Met Fifth Avenue',
      'New York City, USA',
      'One of the worlds most iconic art museums, housing a vast collection spanning 5,000 years of world culture.',
      'assets/images/met.jpg'
    ]);
  }

  Future<void> _seedArtworks(Database db) async {
    final artworksData = [
      // Vincent van Gogh
      {
        'title': 'Starry Night',
        'medium': 'Oil on canvas',
        'year': '1889',
        'materials': 'Paint',
        'rarity': 'High',
        'height': 73.7,
        'width': 92.1,
        'depth': 0,
        'price': 5000000,
        'provenance': 'Private Collection',
        'location': 'Museum of Modern Art, New York',
        'notes': 'One of van Gogh\'s most famous works.',
        'photos':
            'https://cdn.britannica.com/78/43678-050-F4DC8D93/Starry-Night-canvas-Vincent-van-Gogh-New-1889.jpg',
        'condition': 'Excellent',
        'frame': 'Wooden frame',
        'status': 'Available',
        'certificate': 'Yes',
        'artistId': 1, // Assume artistId for Vincent van Gogh is 1
        'galleryId': 1, // Assume galleryId for the gallery is 1
      },
      // Leonardo da Vinci
      {
        'title': 'Mona Lisa',
        'medium': 'Oil on poplar panel',
        'year': '1503-1506',
        'materials': 'Paint',
        'rarity': 'High',
        'height': 77,
        'width': 53,
        'depth': 0,
        'price': 10000000,
        'provenance': 'Louvre Museum',
        'location': 'Louvre Museum, Paris',
        'notes': 'One of the most famous portraits in the world.',
        'photos':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/640px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
        'condition': 'Good',
        'frame': 'Wooden frame',
        'status': 'Available',
        'certificate': 'Yes',
        'artistId': 2, // Assume artistId for Leonardo da Vinci is 2
        'galleryId': 1, // Assume galleryId for the gallery is 1
      },
      // Pablo Picasso
      {
        'title': 'Guernica',
        'medium': 'Oil on canvas',
        'year': '1937',
        'materials': 'Paint',
        'rarity': 'High',
        'height': 349,
        'width': 776,
        'depth': 0,
        'price': 15000000,
        'provenance': 'Museo Reina Sofia',
        'location': 'Museo Reina Sofia, Madrid',
        'notes': 'Depicts the horrors of war.',
        'photos':
            'https://upload.wikimedia.org/wikipedia/en/7/74/PicassoGuernica.jpg',
        'condition': 'Excellent',
        'frame': 'Unframed',
        'status': 'Available',
        'certificate': 'Yes',
        'artistId': 5, // Assume artistId for Pablo Picasso is 3
        'galleryId': 1, // Assume galleryId for the gallery is 1
      },
      // Frida Kahlo
      {
        'title': 'The Two Fridas',
        'medium': 'Oil on canvas',
        'year': '1939',
        'materials': 'Paint',
        'rarity': 'High',
        'height': 173.5,
        'width': 173,
        'depth': 0,
        'price': 8000000,
        'provenance': 'Museo de Arte Moderno',
        'location': 'Museo de Arte Moderno, Mexico City',
        'notes': 'Reflects Kahlo\'s emotional pain.',
        'photos':
            'https://www.fridakahlo.org/images/paintings/the-two-fridas.jpg',
        'condition': 'Good',
        'frame': 'Wooden frame',
        'status': 'Available',
        'certificate': 'Yes',
        'artistId': 4, // Assume artistId for Frida Kahlo is 4
        'galleryId': 1, // Assume galleryId for the gallery is 1
      },
      // Claude Monet
      {
        'title': 'Water Lilies and Japanese Bridge',
        'medium': 'Oil on canvas',
        'year': '1899',
        'materials': 'Paint',
        'rarity': 'High',
        'height': 89,
        'width': 93.1,
        'depth': 0,
        'price': 6000000,
        'provenance': 'Musée d\'Orsay',
        'location': 'Musée d\'Orsay, Paris',
        'notes': 'Part of Monet\'s iconic water lilies series.',
        'photos':
            'https://puam-loris.aws.princeton.edu/loris/y1972-15.jp2/full/!1200,630/0/default.jpg',
        'condition': 'Very good',
        'frame': 'Gilded frame',
        'status': 'Available',
        'certificate': 'Yes',
        'artistId': 3, // Assume artistId for Claude Monet is 5
        'galleryId': 1, // Assume galleryId for the gallery is 1
      },
    ];

    final batch = db.batch();

    for (final artworkData in artworksData) {
      batch.rawInsert('''
      INSERT INTO $artworkTable (title, medium, year, materials, rarity, height, width, depth, price, provenance, location, notes, photos, condition, frame, status, certificate, artistId, galleryId)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
        artworkData['title'],
        artworkData['medium'],
        artworkData['year'],
        artworkData['materials'],
        artworkData['rarity'],
        artworkData['height'],
        artworkData['width'],
        artworkData['depth'],
        artworkData['price'],
        artworkData['provenance'],
        artworkData['location'],
        artworkData['notes'],
        artworkData['photos'],
        artworkData['condition'],
        artworkData['frame'],
        artworkData['status'],
        artworkData['certificate'],
        artworkData['artistId'],
        artworkData['galleryId'],
      ]);
    }

    await batch.commit();
  }

  Future<void> _seedEditorials(Database db) async {
    final editorialsData = [
      {
        'title': 'The Impact of Impressionism on Modern Art',
        'createdAt': '2023-01-01',
        'author': 'Art Enthusiast',
        'content':
            'Impressionism, a revolutionary art movement of the 19th century, had a profound impact on modern art. Artists like Claude Monet and Edgar Degas...',
        'image': 'impressionism_impact_image_url',
      },
      {
        'title': 'Frida Kahlo: An Icon of Surrealism and Self-Expression',
        'createdAt': '2023-02-15',
        'author': 'Art Historian',
        'content':
            'Frida Kahlo, a Mexican artist known for her unique style and powerful self-portraits, remains an icon of surrealism and self-expression...',
        'image':
            'https://www.fridakahlo.org/images/paintings/the-two-fridas.jpg',
      },
      {
        'title': 'The Evolution of Cubism: Picasso and Beyond',
        'createdAt': '2023-03-20',
        'author': 'Art Critic',
        'content':
            'Cubism, pioneered by Pablo Picasso and Georges Braque, marked a significant shift in artistic representation. This article explores the evolution of Cubism and its impact on the art world...',
        'image':
            'https://images.masterworksfineart.com/2017/06/pablo-picasso-three-musicians.jpg',
      },
      {
        'title': 'Leonardo da Vinci: Mastering the Art of Innovation',
        'createdAt': '2023-04-10',
        'author': 'Art Scholar',
        'content':
            'Leonardo da Vinci, a true Renaissance man, not only mastered the traditional arts but also made groundbreaking contributions to science and engineering. This editorial delves into the innovative mind of da Vinci...',
        'image':
            'https://cdn.britannica.com/04/95904-050-7EB39FC8/Last-Supper-wall-painting-restoration-Leonardo-da-1999.jpg',
      },
      {
        'title': 'The Beauty of Van Gogh\'s Starry Night',
        'createdAt': '2023-05-25',
        'author': 'Art Lover',
        'content':
            'Starry Night by Vincent van Gogh is considered one of the most beautiful and iconic paintings in art history. Explore the mesmerizing beauty of this masterpiece and its enduring impact...',
        'image':
            'https://cdn.britannica.com/78/43678-050-F4DC8D93/Starry-Night-canvas-Vincent-van-Gogh-New-1889.jpg',
      },
    ];

    final batch = db.batch();

    for (final editorialData in editorialsData) {
      batch.rawInsert('''
      INSERT INTO $editorialTable (title, createdAt, author, content, image)
      VALUES (?, ?, ?, ?, ?)
    ''', [
        editorialData['title'],
        editorialData['createdAt'],
        editorialData['author'],
        editorialData['content'],
        editorialData['image'],
      ]);
    }

    await batch.commit();
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
