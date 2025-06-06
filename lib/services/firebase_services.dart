import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getSucursal() async {
  List sucursal = [];
  QuerySnapshot querySucursal = await db.collection("sucursal").get();
  for (var doc in querySucursal.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final suc = {
      'nombre': data['nombre'],
      'uid': doc.id,
      'correo': data['correo'],
      'direccion': data['direccion'],
      'horario': data['horario'],
      'id_empleado': data['id_empleado'],
      'telefono': data['telefono'],
    };
    sucursal.add(suc);
  }

  return sucursal;
}

// Guardar un nombre en base de datos
Future<void> addSucursal(
  String nombre, 
  String correo, 
  String direccion, 
  String horario, 
  String telefono, 
  String id_empleado,
) async {
  await FirebaseFirestore.instance.collection('sucursal').doc().set({
    'nombre': nombre,
    'correo': correo,
    'direccion': direccion,
    'horario': horario,
    'telefono': int.tryParse(telefono) ?? 0,
    'id_empleado': int.tryParse(id_empleado) ?? 0,
  });
}

// Actualizar un nombre en base de datos
Future<void> updateSucursal(
  String uid,
  String newName,
  String newCorreo,
  String newDireccion,
  String newHorario,
  int newTelefono,
  int newEmpleado
) async {
  await db.collection("sucursal").doc(uid).update({
    "nombre": newName,
    "correo": newCorreo,
    "direccion": newDireccion,
    "horario": newHorario,
    "telefono": newTelefono,
    "id_empleado": newEmpleado
  });
}


// Borrer un nombre en base de datos
Future<void> deleteSucursal(String uid) async {
  await db.collection("sucursal").doc(uid).delete();
}
