// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:client_quick_food/screens/restaurant_interface.dart';
import 'package:client_quick_food/widget/get_fav_res_for_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetRestaurant extends StatelessWidget {
  const GetRestaurant({super.key, required this.isFavourite, required this.userId});
  final bool isFavourite;
  final String userId;

  @override
  Widget build(BuildContext context) {
    GetFavResForClient myFavRes = GetFavResForClient(userId);
    myFavRes.getData();
    print('streaaaaaam builder rers ${myFavRes.restaurantIds}');
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('restaurants').snapshots(),
      builder: (context, snapshot) {
        final loadedRestaurants = snapshot.data!.docs;
        if(!isFavourite){
          return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: loadedRestaurants.length,
          itemBuilder: (context, index) {
            final _currentRestaurant = loadedRestaurants[index].data();
            return Padding(
                padding: const EdgeInsets.only(left: 15,top: 5),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RestaurantInterface(
                        imageUrl: _currentRestaurant['imageUrl'], 
                        name: _currentRestaurant['name'], 
                        restaurantId: _currentRestaurant['userId'],
                        isFavourite: false,
                        ),
                        
                        )
                    );
                  },
                  child: SizedBox(
                    height: 200,
                    width: 270,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 260,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(_currentRestaurant['imageUrl'],
                            scale: 2,
                            fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_currentRestaurant['name'],
                            style: GoogleFonts.signikaNegative(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                            ),
                             Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Row(
                                children: [
                                  const Icon(Icons.star , color: Colors.redAccent,),
                                  Text('4.7',
                                  style: GoogleFonts.signikaNegative(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                              ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time , color:  Color.fromARGB(255, 109, 109, 109)),
                            const SizedBox(width: 6,),
                            Text('15 - 30 min',
                                  style: GoogleFonts.signikaNegative(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                            color: const Color.fromARGB(255, 109, 109, 109)
                                              ),
                                  )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                );
          },);
        }
        else{
          return ListView.builder(
            itemCount: loadedRestaurants.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final _currentRestaurant = loadedRestaurants[index].data();
              if(!myFavRes.restaurantIds.contains(_currentRestaurant['userId'])){
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
                      NetworkImage(_currentRestaurant['imageUrl']),
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
                      _currentRestaurant['name'],
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
            },);
        }
        
      },);
  }
}