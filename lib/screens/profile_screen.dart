import 'package:client_quick_food/components/second_button.dart';
import 'package:client_quick_food/screens/change_password.dart';
import 'package:client_quick_food/screens/edit_profile.dart';
import 'package:client_quick_food/screens/home_page.dart';
import 'package:client_quick_food/screens/messages_screen.dart';
import 'package:client_quick_food/screens/orders_screen.dart';
import 'package:client_quick_food/screens/sign_up_client.dart';
import 'package:client_quick_food/widget/get_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Profil extends StatefulWidget {
  const Profil({super.key, required this.index, required this.userId});
  final int index;
  final String userId;

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String name = '';
  String profilePicture = '';
  @override
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await getName();
  }

  Future<void> getName() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: widget.userId)
        .get();
    var user = querySnapshot.docs.first.data() as Map<String, dynamic>;

    setState(() {
      name = user['username'];
      profilePicture = user['imageUrl'];
    });
  }

  Widget build(BuildContext context) {
    int _currentIndex = widget.index;

    MyButton edit = MyButton(
      text: 'Edit Profile',
      icon: const Icon(Icons.mode_edit),
      myFunction: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => EditProfilePage(
            profilePicture: profilePicture,
            userId: widget.userId,
          ),
        ));
      },
    );
    MyButton about = MyButton(
      text: 'About Us',
      icon: const Icon(Icons.pending_outlined),
      myFunction: () {},
    );
    MyButton psswd = MyButton(
      text: 'Change password',
      icon: const Icon(Icons.lock_outlined),
      myFunction: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ChangePassword(userId: widget.userId),
        ));
      },
    );
    MyButton logOut = MyButton(
      text: 'Log out',
      icon: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      myFunction: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text('Are you sure you want to disconnect?'),
              actions: <Widget>[
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(500.0, 5)),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.redAccent),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignUpClient(),
                          ));
                        },
                        child: const Center(
                            child: Text(
                          'Log out',
                          style: TextStyle(color: Colors.black),
                        )),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(500.0, 5)),
                          backgroundColor: MaterialStatePropertyAll(
                              Colors.grey.withOpacity(0.3)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    CircleAvatar _buildCircleAvatar() {
      if (profilePicture == '') {
        return const CircleAvatar(
          radius: 50,
        );
      } else {
        return CircleAvatar(
          backgroundImage: NetworkImage(profilePicture),
          radius: 50,
        );
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Pour ajouter une image de fond,
          image: DecorationImage(
            //pour definir une image de fond pour une widegt
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover, //pour remplir tout le fond
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: _buildCircleAvatar(),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            edit.build(context),
            const SizedBox(
              height: 0.5,
            ),
            about.build(context),
            const SizedBox(
              height: 0.5,
            ),
            psswd.build(context),
            const SizedBox(
              height: 28,
            ),
            logOut.build(context),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          _currentIndex = i;
          if (_currentIndex == 0) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(index: 0)));
          }
          if (_currentIndex == 1) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MessgesScreen(index: _currentIndex)));
          }
          if (_currentIndex == 3) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrdersScreen(index: 3)));
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.chat),
            title: const Text("Chat"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text("Cart"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
