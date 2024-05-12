// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class GetFavFoodForClient{
  String? userId;
  List<String> foodIds = [];
  GetFavFoodForClient(String this.userId);

  Future<void> getData() async{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Favourite foods')
                                    .where('userId',isEqualTo: userId).get();

      for (var doc in querySnapshot.docs) {
        foodIds.add(doc['foodId']);
      }
      print('raaaaaaaaanniiiiii 3ayaaaaaaat lel fav food + length is ${foodIds.length} ');
      print(foodIds);
  }
}