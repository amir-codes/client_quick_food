import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchInterface01 extends StatefulWidget {
  const SearchInterface01({super.key, required this.switchScreen});
  final Function(String, String) switchScreen;

  final List categories = const [
    'Burger',
    'Pizza',
    'Chawarma',
    'Tacos',
    'Sandwich',
    'Omlette',
    'Souflets',
    'Crispy chicken',
    'Poissons',
    'Boissons',
    'Salades',
    'Plats',
    'Plats tradionnel',
    'Gratins',
    'Soups',
    'Chapati',
    'Pates',
    'Poissons',
    'Oriontal',
    'Mexicain',
    'Asiatique',
    'Sushi',
    'Crépe',
    'Patisserie',
    'Gaufres',
    'Milkshake',
  ];
  @override
  State<SearchInterface01> createState() => _SearchInterface01State();
}

class _SearchInterface01State extends State<SearchInterface01> {
  List historiqueListe = [];

  @override
  void initState() {
    getHistoriqueData();

    super.initState();
  }

  void getHistoriqueData() async {
    QuerySnapshot historiqueQuerySnapshot = await FirebaseFirestore.instance
        .collection('historique')
        .orderBy('date', descending: true)
        .get();
    List liste = [];
    for (var doc in historiqueQuerySnapshot.docs) {
      liste.add(doc['historique']);
    }
    if (liste.length > 6) {
      // Keep only the last 6 historiques
      liste = liste.sublist(0, 6);
      await FirebaseFirestore.instance
          .collection('historique')
          .where('date', whereNotIn: liste)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
    }
    setState(() {
      historiqueListe = List.from(liste);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('   Recent research',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: historiqueListe.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.switchScreen('name', historiqueListe[index]);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              historiqueListe[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ));
                })),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '   Top categories',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      //child ta3h ywli kima button
                      onTap: () {
                        setState(() {
                          widget.switchScreen(
                              'categorie', widget.categories[index]);
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.only(top: 15, left: 20),
                          child: Text(
                            widget.categories[index],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )));
                }))
      ],
    );
  }
}
