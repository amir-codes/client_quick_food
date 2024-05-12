import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GetOrders extends StatelessWidget {
  const GetOrders({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Orders').snapshots(), 
      builder: (context, snapshot) {
        final loadedOrders = snapshot.data!.docs;
        return ListView.builder(
                itemCount: loadedOrders.length,
                itemBuilder: (context, index) {
                  final _currentOrder = loadedOrders[index].data();
                  if(_currentOrder['userId']!=userId){
                    return const SizedBox();
                  }
                  else{
                    return GestureDetector(
                    onTap: () {
                               
                    },
                    child: Container(
                      height: 130,
                      padding: const EdgeInsets.all(10),
                      margin:
                          const EdgeInsets.only(left: 10, bottom: 20, right: 7),
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
                                    _currentOrder['imageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _currentOrder['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.red,
                                      size: 13,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      '20 min',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.yellow,
                                      size: 16,
                                    ),
                                    Text(
                                      '4.9',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _currentOrder['price'],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                ////
                                ///
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      ////////////////////////////
                                      child: IconButton(
                                        onPressed: (){}, 
                                        icon: const Icon(
                                          Icons.add,
                                          size: 18,
                                          color: Colors.white,
                                        ),)
                                    ),
                                    ///////////////////////////
                                    ///
                                    Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 10),
                                      child: const Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    ////////////////////

                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: IconButton(
                                        onPressed: (){}, 
                                        icon: const Icon(
                                          Icons.text_decrease,
                                          size: 18,
                                          color: Colors.white,
                                        ),)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  }
                });
      },);
  }
}