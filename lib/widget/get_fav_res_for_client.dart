// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class GetFavResForClient{
  String? userId;
  List<String> restaurantIds = [];
  GetFavResForClient(this.userId);

  void getData()async{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Favourite restaurants')
                                    .where('userId',isEqualTo: userId).get();

      for (var doc in querySnapshot.docs) {
        restaurantIds.add(doc['restaurantId']);
      }
      print('raaaaaaaaanniiiiii 3ayaaaaaaat lel fav food + length is ${restaurantIds.length} ');
      print(restaurantIds);
  }



}