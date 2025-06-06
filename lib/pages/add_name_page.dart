import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController empleadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Sucursal'),
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Ingrese el nuevo nombre'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: correoController,
              decoration: const InputDecoration(hintText: 'Ingrese el nuevo correo'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: direccionController,
              decoration: const InputDecoration(hintText: 'Ingrese la nueva dirección'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: horarioController,
              decoration: const InputDecoration(hintText: 'Ingrese el nuevo horario'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: telefonoController,
              decoration: const InputDecoration(hintText: 'Ingrese el nuevo teléfono'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: empleadoController,
              decoration: const InputDecoration(hintText: 'Ingrese el nuevo encargado'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 132, 180, 243),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                await addSucursal(
                  nameController.text,
                  correoController.text,
                  direccionController.text,
                  horarioController.text,
                  telefonoController.text,
                  empleadoController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
