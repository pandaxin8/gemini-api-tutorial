import 'package:cloud_firestore/cloud_firestore.dart'; 

// A very basic write for testing
Future<void> addDataToFirestore(String collectionName, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance.collection(collectionName).add(data);
} 