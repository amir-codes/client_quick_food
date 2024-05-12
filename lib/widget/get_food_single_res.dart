import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GetFoodSingleRes extends StatelessWidget {
  const GetFoodSingleRes({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('foods').snapshots(), 
      builder: (context, snapshot) {
        final loadedFoods = snapshot.data!.docs;
        return ListView.builder(
          itemCount: loadedFoods.length,
          itemBuilder: (context, index) {
            final _currentFood = loadedFoods[index].data();
            if(_currentFood['restaurantId']!=restaurantId){
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
      },);
  }
}