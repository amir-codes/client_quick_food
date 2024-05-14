import 'package:client_quick_food/screens/home_page.dart';
import 'package:client_quick_food/widget/users_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MessgesScreen extends StatelessWidget {
  const MessgesScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    int _currentIndex = index;
    return Scaffold(
      body: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 50),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Search Message',
                      fillColor: Colors.green,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.filter_list)),
                ),
              ),
            ),
            const Expanded(
                child: SingleChildScrollView(
              child: UsersLists(),
            ))
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          _currentIndex = i;
          if (_currentIndex == 0) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyHomePage(index: _currentIndex),
            ));
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.chat),
            title: const Text("Chat"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text("Cart"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
