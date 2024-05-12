// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:client_quick_food/screens/home_page.dart';
import 'package:client_quick_food/screens/messages_screen.dart';
import 'package:client_quick_food/screens/orders_screen.dart';
import 'package:client_quick_food/screens/profile_screen.dart';
import 'package:client_quick_food/screens/search_interface01.dart';
import 'package:client_quick_food/widget/food_list.dart';
import 'package:client_quick_food/widget/restaurant_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SearchInterface extends StatefulWidget {
  const SearchInterface({super.key, required this.index, required this.currentUser});
  final int index;
  final String currentUser;

  @override
  State<SearchInterface> createState() => _SearchInterfaceState();
}

class _SearchInterfaceState extends State<SearchInterface> {
  late Widget activescreen;
  List<String> foodListe = [];
  List<String> restaurantListe = [];
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    activescreen = SearchInterface01(
      switchScreen: switchScreen,
    );
    super.initState();
  }

  switchScreen(String documentName, String value) {
    setState(() async {
      getFoodData(value);
      activescreen = Column(
        children: [
          SizedBox(
              height: 150, child: RestaurantList(restaurantIds: restaurantListe)),
          Expanded(
            child: FoodList(
              foodIds: foodListe,
            ),
          ),
        ],
      );
    });
  }

  void getFoodData(String value) async {
    restaurantListe.clear();
    foodListe.clear();

    value = value.toLowerCase();
    QuerySnapshot foodQuerySnapshot = await FirebaseFirestore.instance
        .collection('foods')
        .where('foodName', isGreaterThanOrEqualTo: value)
        .where('foodName',
            isLessThan: value + String.fromCharCode('z'.codeUnitAt(0) + 1))
        .get();
    QuerySnapshot restaurantQuerySnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .where('name', isGreaterThanOrEqualTo: value)
        .where('name',
            isLessThan: value + String.fromCharCode('z'.codeUnitAt(0) + 1))
        .get();

    for (var doc in foodQuerySnapshot.docs) {
      setState(() {
        foodListe.add(doc['foodId']);
      });
    }

    for (var doc in restaurantQuerySnapshot.docs) {
      setState(() {
        restaurantListe.add(doc['userId']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = widget.index;
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 25),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: _controller,
          onEditingComplete: () {
            FirebaseFirestore.instance
                .collection('historique')
                .add({'historique': _controller.text, 'date': Timestamp.now()});
          },
          onChanged: (value) {
            value.isEmpty
                ? activescreen = SearchInterface01(
                    switchScreen: switchScreen,
                  )
                : setState(() async {
                    getFoodData(value);
                    activescreen = Column(
                      children: [
                        SizedBox(
                            height: 150,
                            child:
                                RestaurantList(restaurantIds: restaurantListe)),
                        Expanded(
                          child: FoodList(foodIds: foodListe),
                        ),
                      ],
                    );
                  });
          },
          decoration: const InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
            ),
            hintText: ' Search',
            prefixIcon: Icon(Icons.search),
            focusedBorder: UnderlineInputBorder(),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Expanded(
        child: activescreen,
      )
    ]),
      bottomNavigationBar: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (i) {
                 _currentIndex = i;
                 if(_currentIndex==0){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(index: 0))
                  );
                }
                if(_currentIndex==1){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MessgesScreen(index: 1,))
                  );
                }
                if(_currentIndex == 3){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrdersScreen(index: 3))
                  );
                }
                if(_currentIndex == 4){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profil(index: 4,userId: widget.currentUser,))
                  );
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
