import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import this
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'package:flutter_app/Screens/class/createclass.dart';
import 'package:flutter_app/Screens/class/joinclass.dart';
import 'package:flutter_app/Screens/home.dart';
import 'firebase_options.dart';


// Declare the db variable
late FirebaseFirestore db;

// You will need to create this widget.


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // db = FirebaseFirestore.instance;
  FirebaseUIAuth.configureProviders([
    GoogleProvider(
      clientId: '1:497339425538:android:6c8ed99f417c093b6b181b',
    ),
  ]);
  db = FirebaseFirestore.instance;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show a loading indicator while checking the state.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // If the snapshot has data (a user), they are authenticated.
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          // Otherwise, show the sign-in screen.
          return const SignInScreen();
        },
      ),
    
    routes: 
    
    {
      '/home': (context) => const HomeScreen(),
      '/create': (context) => const CreateClass(),
      '/join': (context) => const Joinclass(),
    },);
  }
}