import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key, required this.restaurantIds});
  final List<String> restaurantIds;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('restaurants').snapshots(), 
      builder: (context, snapshot) {
        final loadedRes=snapshot.data!.docs;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: loadedRes.length,
          itemBuilder: (context, index) {
            final _currentRes=loadedRes[index].data();
            if(!restaurantIds.contains(_currentRes['userId'])){
              return const SizedBox();
            }
            else{
               return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image:
                      NetworkImage(_currentRes['imageUrl']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      _currentRes['name'],
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        );
            }
          },
          
          );
      },);
  }
}