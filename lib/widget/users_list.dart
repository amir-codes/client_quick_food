
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersLists extends StatelessWidget {
  const UsersLists({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('restaurants').snapshots(), 
      builder: (context, snapshot) {
        final loadedUsers = snapshot.data!.docs;
        final currentUser = FirebaseAuth.instance.currentUser!.uid;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: loadedUsers.length,
          itemBuilder: (context, index) {
            final user = loadedUsers[index].data();
            final thisUser = user['userId'];
            print("this is currectuser $thisUser  and current user is $currentUser");
            if(currentUser == thisUser){
              return const SizedBox(height: 0,width: 0,);
            }
            else{
              return  GestureDetector(
              onTap: () {/*
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      senderId: currentUser, 
                      receiverId: user['userId']),)
                );*/
              },
              child: Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                child:  SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user['imageUrl']),
                        radius: 33,
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          Text(user['name'],
                          style: GoogleFonts.signikaNegative(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                          ),
                          const SizedBox(height: 10,),
                          Text('Tap to see messages...',
                          style: GoogleFonts.signikaNegative(
                            color: const Color.fromARGB(255, 77, 77, 77),
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.photo_camera)
                    ],
                  ),
                ),
              ),
            );
            }
      },);
      },);
  }
}
