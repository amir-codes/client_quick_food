import 'package:client_quick_food/widget/get_food_single_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RestaurantInterface extends StatefulWidget {
  RestaurantInterface({super.key, required this.imageUrl,this.isFavourite, required this.name, required this.restaurantId});
  final String imageUrl;
  bool? isFavourite;
  final String name;
  final String restaurantId;
  
  @override
  State<RestaurantInterface> createState() => _RestaurantInterfaceState();
}

class _RestaurantInterfaceState extends State<RestaurantInterface> {
  
  int selectedIndex = 0;
  @override
  

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    


    void _addFav()async{
        await FirebaseFirestore.instance
        .collection('Favourite restaurants')
        .add({
          'restaurantId' : widget.restaurantId,
          'userId' :  FirebaseAuth.instance.currentUser!.uid,
        });
         
    }


    List<String> Categories=['Burger',
      'Pizza',
      'Chawarma',
      'Tacos',
      'Sandwich',
      'Omlette',
      'Souflets',
      'Crispy chicken',
      'Poissons',
      'Boissons'];
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(97, 0, 0, 0),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search),
                            iconSize: 30,
                            color: Colors.white,
                            hoverColor: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                                97, 0, 0, 0), // Background color
                            borderRadius: BorderRadius.circular(
                                100), // Optional: for rounded corners
                          ),
                          child: IconButton(
                            icon: widget.isFavourite!
                                ? const Icon(Icons.favorite_sharp)
                                : const Icon(Icons.favorite_border_outlined),
                            color: widget.isFavourite!
                                ? Colors.redAccent
                                : Colors.white,
                            iconSize: 30,
                            onPressed: () {
                                 _addFav();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            (widget.name),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 35,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  Categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedIndex == index
                                ? Colors.redAccent
                                : const Color.fromARGB(255, 235, 233, 233),
                            width: 4,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          Categories[index],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ));
              }),
        ),
        Expanded(child: GetFoodSingleRes(restaurantId: widget.restaurantId)),
      ],
    ));
  }
}
