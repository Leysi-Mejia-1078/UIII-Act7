import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  QuerySnapshot queryPeople = await db.collection("people").get();
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      'name': data['name'],
      'uid': doc.id,
    };
    people.add(person);
  }

  return people;
}

// Guardar un name en base de datos
Future<void> addPeople(String name) async {
  await db.collection("people").add({"name": name});
}

// Actualizar un name en base de datos
Future<void> updatePeople(String uid, String newName) async {
  await db.collection("people").doc(uid).update({"name": newName});
}

// Borrer un name en base de datos
Future<void> deletePeople(String uid) async {
  await db.collection("people").doc(uid).delete();
}
