// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:client_quick_food/screens/food_presentation.dart';
import 'package:client_quick_food/widget/get_fav_food_for_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetFood extends StatelessWidget {
  const GetFood({super.key, required this.isFavourite, required this.userId});
  final bool isFavourite;
  final String userId;

  @override
  Widget build(BuildContext context) {
    GetFavFoodForClient myFav = GetFavFoodForClient(userId);
    myFav.getData();
    print('streaaaaaam builder rers ${myFav.foodIds}');
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('foods').snapshots(), 
      builder: (context, snapshot) {
        final loadedFoods = snapshot.data!.docs;
        if(!isFavourite){
          return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: loadedFoods.length,
                  itemBuilder: (context, index) {

                    final _currentFood = loadedFoods[index].data();
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                           MaterialPageRoute(builder: (context) => FoodInterface(
                            restaurantId: _currentFood['restaurantId'],
                            foodId: _currentFood['foodId'],
                            imageUrl: _currentFood['ImageUrl'], 
                            name: _currentFood['foodName'], 
                            description: _currentFood['description'], 
                            deliveryTime: _currentFood['DeliveryTime'], 
                            rate: '4.7', 
                            price: _currentFood['price'], 
                            isFavorite: false),));
                      },
                      child: Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 5),
                                      child: SizedBox(
                                        height: 200,
                                        width: 270,
                                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 260,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(_currentFood['ImageUrl'],
                            scale: 2,
                            fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(_currentFood['foodName'],
                            style: GoogleFonts.signikaNegative(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19,
                                              ),),
                            const Spacer(),
                            const Icon(Icons.access_time , size: 21, color: Color.fromARGB(255, 109, 109, 109),),
                            const SizedBox(width: 4,),
                            Text(_currentFood['DeliveryTime'],
                            style: GoogleFonts.signikaNegative(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                            color: const Color.fromARGB(255, 109, 109, 109)
                                              ),
                            ),
                            const SizedBox(width: 10,)
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
            itemCount: loadedFoods.length,
            itemBuilder: (context, index) {
              final _currentFood = loadedFoods[index].data();
              if(!myFav.foodIds.contains(_currentFood['foodId'])){
                return const SizedBox();
              }
              else{
                return GestureDetector(
                  onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Container(
                  height: 130,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10, bottom: 20, right: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(
                            0, 4), //decalage de ombre par rapport container
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                _currentFood['ImageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _currentFood['foodName'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(
                                        Icons.favorite_border_outlined),
                                color: Colors.redAccent,
                                iconSize: 25,
                                onPressed: () {
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        '5.0',
                                        style:  TextStyle(fontSize: 15),
                                      ),
                                       Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _currentFood['DeliveryTime'],
                                    style: const TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                              Text(
                                '${_currentFood['price']} DA',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          )
                        ],
                      )),
                    ],
                  ))
                );
              }
            
            },);
        }
      },);
  }
}