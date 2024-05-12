import 'package:cloud_firestore/cloud_firestore.dart';

class GetName{
  String name='vvvv';
  final String userId;
  GetName(this.userId);

  getData()async{
       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users')
                                    .where('userId',isEqualTo: userId).get();

       name = querySnapshot.docs.first.toString();
       print('naaaaaaaaame howa $name');
  }
}