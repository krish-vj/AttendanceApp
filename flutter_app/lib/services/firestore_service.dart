// firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // A private static instance of the class
  static final FirestoreService _instance = FirestoreService._internal();

  // A factory constructor to return the same instance
  factory FirestoreService() {
    return _instance;
  }

  // The private constructor
  FirestoreService._internal();

  // The public getter for the Firestore instance
  FirebaseFirestore get db => FirebaseFirestore.instance;
}