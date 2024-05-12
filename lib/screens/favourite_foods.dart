import 'package:client_quick_food/screens/home_page.dart';
import 'package:client_quick_food/widget/get_fav_food_for_client.dart';
import 'package:client_quick_food/widget/get_foods.dart';
import 'package:client_quick_food/widget/get_restaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavFoods extends StatelessWidget {
  const FavFoods({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MyHomePage(index: 0),
                ));
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 150,
              child: GetRestaurant(isFavourite: true, userId: currentUser),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(child: GetFood(isFavourite: true, userId: currentUser))
          ],
        )));
  }
}
