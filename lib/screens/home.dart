import 'package:artsy_prj/components/home/artsy_editorial_section.dart';
import 'package:artsy_prj/components/home/auction_section.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/screens/info.dart';
import 'package:artsy_prj/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/components/home/new_works_section.dart';
import 'package:artsy_prj/components/home/explore_section.dart';
import 'package:artsy_prj/screens/search.dart';
import 'package:artsy_prj/screens/userbid.dart';

class HomePage extends StatefulWidget {
  final UserModel? user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeTab(user: widget.user!),
      SearchTab(),
      CommentsTab(),
      PriceTagTab(),
      ProfileTab(user: widget.user!),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false, // Hide labels for selected items
        showUnselectedLabels: false, // Hide labels for unselected items
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home', // Add label for Home tab
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home_filled,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search', // Add label for Search tab
            icon: Icon(
              Icons.search,
              color: Colors.black,
              weight: 300,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.black,
              weight: 700,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Comments', // Add label for Comments tab
            icon: Icon(
              Icons.comment_outlined,
              color: Colors.black,
              weight: 300,
            ),
            activeIcon: Icon(
              Icons.comment_outlined,
              color: Colors.black,
              weight: 700,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Price Tag', // Add label for Price Tag tab
            icon: Icon(
              Icons.local_offer,
              color: Colors.black,
              weight: 300,
            ),
            activeIcon: Icon(
              Icons.local_offer,
              color: Colors.black,
              weight: 700,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile', // Add label for Profile tab
            icon: Icon(
              Icons.person_2_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person_2,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final UserModel user;

  const HomeTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your logo asset path
          height: 24, // Adjust the height as needed
        ),
        actions: [
          IconButton(
            icon: Icon(
              weight: 100,
              Icons.notifications_outlined,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notif');
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return [
                NewWorksSection(user: user,),
                ExploreSection(),
                AuctionSection(),
                EditorialSection()
              ][index];
            },
          )),
    );
  }
}

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchPage();
  }
}

class CommentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserBidPage();
  }
}

class PriceTagTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoPage();
  }
}

class ProfileTab extends StatelessWidget {
  final UserModel user;

  const ProfileTab({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfilePage(user: user);
  }
}
