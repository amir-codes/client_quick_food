import 'package:client_quick_food/screens/favourite_foods.dart';
import 'package:client_quick_food/screens/messages_screen.dart';
import 'package:client_quick_food/screens/orders_screen.dart';
import 'package:client_quick_food/screens/profile_screen.dart';
import 'package:client_quick_food/screens/search_interface.dart';
import 'package:client_quick_food/screens/sign_up_client.dart';
import 'package:client_quick_food/widget/get_foods.dart';
import 'package:client_quick_food/widget/get_restaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.index});
  final int index;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  
  int _currentIndex=0;
  final List<String> categories = [
    'https://cdn-icons-png.flaticon.com/512/1784/1784096.png',
    'https://cdn-icons-png.flaticon.com/512/1192/1192049.png',
    'https://cdn-icons-png.flaticon.com/512/3132/3132693.png',
    'https://cdn-icons-png.flaticon.com/512/2224/2224325.png',
    'https://cdn-icons-png.flaticon.com/512/1839/1839039.png',
    'https://cdn-icons-png.flaticon.com/512/4062/4062916.png',
    'https://cdn-icons-png.flaticon.com/512/877/877922.png',
    
  ];
  
  final List<String> _recomendedPictures = [
    'https://p-my.ipricegroup.com/trends-article/top-malaysia-food-to-unleash-your-taste-buds.jpg',
    'https://images.squarespace-cdn.com/content/v1/5a5dbe4632601eb31977f947/1633327221357-NWREEQY82IAW2PFJXUM0/AirAsia_Food_EverydaySale_PR_4Oct-31Oct2021-1200x628_EN.jpg',
    'https://malaysiafreebies.com/wp-content/uploads/2022/05/Free-Delivery-RM5-off-Zoning-Campaign_1200x628-669x350.jpg'
  ]; 
  //final TextStyle _googleFonts = GoogleFonts.ac
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    return  SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_outlined,
                      color: Colors.redAccent,
                      ),
                      Text('Tlemcen , Abou Techfine',
                      style: GoogleFonts.yanoneKaffeesatz(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const FavFoods(),)
                          );
                        }, 
                        icon: const Icon(Icons.favorite , color: Colors.redAccent,)),
                      IconButton(
                            onPressed: (){
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const SignUpClient(),)
                              );
                            }, 
                            icon: const Icon(Icons.exit_to_app),
                            color: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 15),
                child: Text('Hi, Amir',
                style: GoogleFonts.signikaNegative(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 15),
                child: Text("Let's find food near you!",
                style: GoogleFonts.signikaNegative(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recomendedPictures.length,
                  itemBuilder: (context, index) {
                    return Padding(
                  padding: const EdgeInsets.only(left: 15,right: 7,top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(_recomendedPictures[index]),
                  ),
                  );
                  },),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 15,top: 6),
                child: Text("Categories",
                style: GoogleFonts.signikaNegative(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 8),
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 60, 
                        height: 60, 
                        decoration: const BoxDecoration(
                                      shape: BoxShape.circle, 
                                      color: Color.fromARGB(255, 184, 183, 183), 
                                    ),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.network(categories[index],
                            scale: 16,
                            ),
                          ),
                        )            
                        ),
                  );
                    },),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 15,top: 6),
                child: Text("Recomended restaurant",
                style: GoogleFonts.signikaNegative(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                ),
              ),
              SizedBox(
                height: 215,
                child: GetRestaurant(isFavourite: false,userId: currentUser,),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 15,),
                child: Text("Discount! 🔥",
                style: GoogleFonts.signikaNegative(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                ),
              ),
              SizedBox(
                height: 220,
                child: GetFood(isFavourite: false,userId: currentUser,)
              ),
            ],
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (i) {
                 _currentIndex = i;
                if(_currentIndex==1){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MessgesScreen(index: _currentIndex))
                  );
                }
                if(_currentIndex==2){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchInterface(index: 2,currentUser: currentUser,))
                  );
                }
                if(_currentIndex == 3){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrdersScreen(index: 3))
                  );
                }
                if(_currentIndex == 4){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profil(index: 4,userId: currentUser,))
                  );
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
      ),
    );
  }
}