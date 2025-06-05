import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit name'),
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Ingrese la modificacion'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 132, 180, 243), // Color de fondo
                foregroundColor: Colors.white, // Color del texto
              ),
              onPressed: () async {
                await updatePeople(arguments['uid'], nameController.text).then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
