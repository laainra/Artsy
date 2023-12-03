import 'package:artsy_prj/components/home/auction_section.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/components/home/new_works_section.dart';
import 'package:artsy_prj/components/home/explore_section.dart';
import 'package:artsy_prj/screens/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    SearchTab(),
    CommentsTab(),
    PriceTagTab(),
    ProfileTab(),
  ];

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
  const HomeTab({Key? key}) : super(key: key);
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
              // Tindakan yang diambil saat ikon notifikasi ditekan
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return [
                NewWorksSection(),
                ExploreSection(),
                AuctionSection()
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
    return Center(
      child: Text('Comments Tab Content'),
    );
  }
}

class PriceTagTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Price Tag Tab Content'),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Tab Content'),
    );
  }
}
