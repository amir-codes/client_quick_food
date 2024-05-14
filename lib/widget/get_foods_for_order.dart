import 'package:cloud_firestore/cloud_firestore.dart';

class GetFoodInfo {
  final String foodID;
  GetFoodInfo(this.foodID);
  String imageUrl = '';
  String name = '';
  String price = '';

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foods')
        .where('foodId', isEqualTo: foodID)
        .get();

    for (var doc in querySnapshot.docs) {
      imageUrl = doc['ImageUrl'];
      name = doc['foodName'];
      price = doc['price'];
    }
    print('iiiiiii $imageUrl');
    print('nnnnnnn $name');
    print('ppppppp $price');
  }
}
