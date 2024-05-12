
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodInterface extends StatefulWidget {
  final String foodId;
  final String restaurantId;
  final String imageUrl;
  final String name;
  final String description;
  final String deliveryTime;
  final String rate;
  final String price;
  bool isFavorite;
  
  FoodInterface({super.key, required this.imageUrl, required this.name, required this.description, required this.deliveryTime, required this.rate, required this.price, required this.isFavorite, required this.foodId, required this.restaurantId});

  @override
  State<FoodInterface> createState() => _FoodInterfaceState();
}

class _FoodInterfaceState extends State<FoodInterface> {
  final TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final currentUser=FirebaseAuth.instance.currentUser!.uid;
   
    void _addFav()async{
        await FirebaseFirestore.instance
        .collection('Favourite foods')
        .add(
          {
            'foodId' : widget.foodId,
            'userId' :  FirebaseAuth.instance.currentUser!.uid,
          }
        );
         
    }
    void _suppFav()async{
      await FirebaseFirestore.instance
      .collection('Favourites foods')
      .doc(widget.name).delete();
    }
    void _saveOrder()async{
      await FirebaseFirestore.instance.collection('Orders')
      .doc(widget.name)
      .set({
          'name' : widget.name,
          'imageUrl' : widget.imageUrl,
          'userId' : currentUser,
          'restaurantId' : widget.restaurantId,
          'price' : widget.price,
      });
    }

    int priceInt = int.parse(widget.price);
    int purchasesNumber = 1;

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(97, 0, 0, 0),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(97, 0, 0, 0),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: widget.isFavorite
                            ? const Icon(Icons.favorite_sharp)
                            : const Icon(Icons.favorite_border_outlined),
                        color: widget.isFavorite
                            ? Colors.redAccent
                            : Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          if (!widget.isFavorite){
                            _addFav();
                          }
                          if(widget.isFavorite){
                            _suppFav();
                          } 
                          setState(() {
                            //amir if widget.foodInformation.['isFavorite'] == true then  remove from fvorite list else add it
                            widget.isFavorite = !widget.isFavorite;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 3,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(
                              1, 3), // Offset, moves the shadow vertically
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "$priceInt DA",
                                style: const TextStyle(color: Colors.white)),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time_sharp,
                                  color: Colors.white,
                                ),
                                Text(widget.deliveryTime,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  widget.rate,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ]),
                    )),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.store_mall_directory_rounded,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Visit the store",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.description,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ////////////////////////////////////////////////////////
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent)),
              child: const Text(
                "-",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              onPressed: () {
                setState(() {
                  purchasesNumber--;
                  print('hadddaaaaaaa purchse - est $purchasesNumber');
                  _controller.text = purchasesNumber.toString();
                });
              },
            ),
            ////////////////////////////////////////////
            SizedBox(
              width: 20,
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  int p = int.parse(value);
                  setState(() {
                    //purchasesNumber = p;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: purchasesNumber.toString(),
                  border: InputBorder.none,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent)),
              child: const Text(
                "+",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              onPressed: () {
                setState(() {
                  purchasesNumber= purchasesNumber +1;
                  print('hadddaaaaaaa purchse + est $purchasesNumber');
                  _controller.text = purchasesNumber.toString();
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "${priceInt * purchasesNumber} DA",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IconButton(
                style: ButtonStyle(
                    iconColor: MaterialStateProperty.all<Color>(Colors.black)),
                onPressed: () {
                  //add the food to the panier
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("added to the panier")));
                },
                icon: const Icon(Icons.shopping_cart_outlined)),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
              ),
              onPressed: () {
                    _saveOrder();
              },
              child: const Text(
                "Order Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
