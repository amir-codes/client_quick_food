// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:client_quick_food/screens/home_page.dart';
import 'package:client_quick_food/screens/messages_screen.dart';
import 'package:client_quick_food/widget/get_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    int _currentIndex = index;
    final height = MediaQuery.of(context).size.height;
    final currentUser =FirebaseAuth.instance.currentUser!.uid;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.only(top: height*0.07),
          child:   Column(
          children: [
            Expanded(
              child: GetOrders(userId: currentUser,))
          ],
                ),
        ),
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
                      builder: (context) => const MessgesScreen(index: 1))
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
      ));
  }
}