// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:client_quick_food/components/my_button.dart';
import 'package:client_quick_food/components/my_text_button.dart';
import 'package:client_quick_food/components/my_text_field.dart';
import 'package:client_quick_food/screens/home_page.dart';
import 'package:client_quick_food/screens/sign_up_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LogInClient extends StatelessWidget {
  const LogInClient({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    TextEditingController emailTextEditingController = TextEditingController();
    TextEditingController passwordTextEditingController = TextEditingController();
    var _enteredEmail='';
    var _enteredPassword='';
    final _firebase = FirebaseAuth.instance;
    

    
    void submit()async{
      final valid = _formkey.currentState!.validate();
      if(!valid){
        return;
      }
      try{
      final UserCredential userCredential = await _firebase.signInWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyHomePage(index: 0),)
        );
      }on FirebaseAuthException catch(e){
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentification failed'))
          );

          
      
     }
     _formkey.currentState!.save();
    }


    void signInWithGoogle()async{
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user?.displayName);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
          'userId' : userCredential.user?.uid,
          'username' : userCredential.user?.displayName,
          'email' : userCredential.user?.email 
        });

  }


    return Scaffold(
  resizeToAvoidBottomInset: true,
  body: Column(
    children: [
      Expanded(
        flex: 3,
        child: Stack(
          children: [
            Image.asset(
              'image/pizza.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Other widgets to overlay on the image if needed
          ],
        ),
      ),
      Expanded(
        flex: 7,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,right: 15,left: 10),
                    child: MyTextField(
                      isEmail: true,
                                  isPassword: false,
                                  isNumber: false,
                                hint: "Email",
                                myIcon: const Icon(Icons.email_outlined),
                                controller: emailTextEditingController,
                                myValidator: (p0) {
                                  if(p0 == null || p0.trim().isEmpty || !p0.contains('@')){
                                  return 'Please enter a valid address';
                        }
                        return null;
                                },
                                myOnsaved: (p0) => _enteredEmail=p0!,
                        ),
                  ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,right: 15,left: 10),
                        child: MyTextField(
                                    isEmail: false,
                                    isPassword: true,
                                    isNumber: false,
                                    hint: "Password",
                                    myIcon: const Icon(Icons.lock_outline),
                                    controller: passwordTextEditingController,
                                    myValidator: (p0) {
                                      if(p0 == null || p0.trim().length<6) {
                                    return 'Password must be ay least 6 characters long';
                        }
                        return null;
                                    },
                                    myOnsaved: (p0) => _enteredPassword=p0!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120,vertical: 30),
                        child: MyButton(
                                      mybuttonLabel: "Log in",
                                      myColor: Colors.redAccent,
                                      myOnpressedFct: submit,
                                      ),
                      ),
                      Center(
                        child: Text('or continue with',
                        style: GoogleFonts.signikaNegative(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //google
                                       GestureDetector(
                                        onTap: signInWithGoogle,
                                         child: const CircleAvatar(
                                          backgroundImage: AssetImage('image/google.jpg'),
                                          radius: 25,
                                          ),
                                       ),
                                       const SizedBox(width: 7,),
                                      //facebook
                                        GestureDetector(
                                          child: const CircleAvatar(
                                          backgroundImage: AssetImage('image/facebook.png'),
                                          radius: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 7,),
                                      //microsoft
                                        GestureDetector(
                                          child: const CircleAvatar(
                                          backgroundImage: AssetImage('image/microsoft.png'),
                                          radius: 23,
                                          ),
                                        ),
                                        
                                    ],
                        ),
                      ),
              
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: MyTextButton(
                          mybuttonLabel: "Don't have an account?", myOnpressedFct: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUpClient(),)
                            );
                          },
                            ),
                      ),
                  ]),
                      ),
          ),
        ),)],
      )
    );
  }
}


/*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Stack(children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'image/google.jpg', // Path to your image asset
                    fit: BoxFit.cover, // Cover the entire background
                  ),
                ),
              ]),
            ),
            MyTextField(
              hint: "Email",
              myIcon: const Icon(Icons.email_outlined),
              controller: emailTextEditingController,
              myValidator: (p0) {
                if(p0 == null || p0.trim().isEmpty || !p0.contains('@')){
                return 'Please enter a valid address';
            }
            return null;
              },
              myOnsaved: (p0) => _enteredEmail=p0!,
            ),
            MyTextField(
              hint: "Password",
              myIcon: const Icon(Icons.lock_outline),
              controller: passwordTextEditingController,
              myValidator: (p0) {
                if(p0 == null || p0.trim().length<6) {
              return 'Password must be ay least 6 characters long';
            }
            return null;
              },
              myOnsaved: (p0) => _enteredPassword=p0!,
            ),
            MyButton(
              mybuttonLabel: "Log in",
              myOnpressedFct: submit,
              ),
            Text('or continue with',
            style: GoogleFonts.signikaNegative(
              fontWeight: FontWeight.w400,
              fontSize: 17
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //google
                 GestureDetector(
                  onTap: signInWithGoogle,
                   child: const CircleAvatar(
                    backgroundImage: AssetImage('image/google.jpg'),
                    radius: 25,
                    ),
                 ),
                 const SizedBox(width: 7,),
                //facebook
                  GestureDetector(
                    child: const CircleAvatar(
                    backgroundImage: AssetImage('image/facebook.png'),
                    radius: 20,
                    ),
                  ),
                  const SizedBox(width: 7,),
                //microsoft
                  GestureDetector(
                    child: const CircleAvatar(
                    backgroundImage: AssetImage('image/microsoft.png'),
                    radius: 23,
                    ),
                  ),
                  
              ],
            ),
                
            Row(
              children: [
                const Text(
                  "Don't have an account?    ",
                  style: TextStyle(color: Colors.red),
                ),
                MyTextButton(
                  mybuttonLabel: "Sign Up", myOnpressedFct: () {
                    
                  },
                    )
              ],
            )
          ],
        ),*/