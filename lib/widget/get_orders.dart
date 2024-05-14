import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetOrders extends StatefulWidget {
  const GetOrders({super.key, required this.userId});
  final String userId;

  @override
  State<GetOrders> createState() => _GetOrdersState();
}

class _GetOrdersState extends State<GetOrders> {
  List<Map<String, dynamic>> ordersList = [];
  List<Map<String, dynamic>> foodsList = [];
  List<Map<String, dynamic>> newFoodsList = [];
  @override
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await getData();
  }

  Future<void> getData() async {
    QuerySnapshot ordersSnapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('clientID', isEqualTo: widget.userId)
        .get();

    setState(() {
      for (var doc in ordersSnapshot.docs) {
        ordersList.add(doc.data() as Map<String, dynamic>);
        //print(ordersList);
      }
    });

    QuerySnapshot foodsSnapshot =
        await FirebaseFirestore.instance.collection('foods').get();

    setState(() {
      for (var doc in foodsSnapshot.docs) {
        foodsList.add(doc.data() as Map<String, dynamic>);
      }
    });

    setState(() {
      for (var order in ordersList) {
        for (var food in foodsList) {
          if (food['foodId'] == order['foodID']) {
            newFoodsList.add(food);
          }
        }
      }
    });
    print('yaaaaw foood list final hiya $foodsList');
  }

  @override
  Widget build(BuildContext context) {
    if (ordersList.isEmpty) {
      return const Center(
        child: Text("you don't have orders"),
      );
    } else {
      return ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
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
                    offset:
                        Offset(0, 4), //decalage de ombre par rapport container
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
                        image: NetworkImage(newFoodsList[index]['ImageUrl']),
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
                          newFoodsList[index]['foodName'],
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
                          newFoodsList[index]['price'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                          ),
                        ),
                        Text('Qte : ${ordersList[index]['Qte'].toString()}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
