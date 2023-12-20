import 'package:artsy_prj/screens/accountsetting.dart';
import 'package:artsy_prj/screens/addartist.dart';
import 'package:artsy_prj/screens/admin/gallerylist.dart';
import 'package:artsy_prj/screens/detailartwork.dart';
import 'package:artsy_prj/screens/editprofile.dart';
import 'package:artsy_prj/screens/info.dart';
import 'package:artsy_prj/screens/notifications.dart';
import 'package:artsy_prj/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/screens/splash.dart';
import 'package:artsy_prj/screens/login.dart';
import 'package:artsy_prj/screens/register.dart';
import 'package:artsy_prj/screens/formlogin.dart';
import 'package:artsy_prj/screens/formregister.dart';
import 'package:artsy_prj/screens/userbid.dart';
import 'package:artsy_prj/screens/home.dart';
import 'package:artsy_prj/screens/admin/admindashboard.dart';
import 'package:artsy_prj/screens/admin/userlist.dart';
import 'package:artsy_prj/screens/admin/artistlist.dart';
import 'package:artsy_prj/screens/admin/artworklist.dart';

final routes = {
  '/': (context) => SplashScreenPage(),
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/login_form': (context) => LoginFormPage(),
  '/register_form': (context) => EmailPage(),
  '/home': (context) => HomePage(),
  '/admin_dashboard': (context) => AdminDashboardPage(),
  '/artist-list': (context) => ArtistList(),
  '/user-list': (context) => UserListPage(),
  '/artwork-list': (context) => ArtworkListPage(),
  '/gallery-list': (context) => GalleryListPage(),
  '/user-bid': (context) => UserBidPage(),
  '/notif': (context) => NotifPage(),
  '/info': (context) => InfoPage(),
  '/settings': (context) => Settings(),
  '/account-settings': (context) => AccountSettings(),
  '/add-artist': (context) => AddArtist(),
  '/edit-profile': (context) => EditProfile(),
};
