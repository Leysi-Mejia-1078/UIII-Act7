import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController empleadoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // No se puede acceder a ModalRoute.of(context) aquí porque el context aún no está completamente inicializado
    // Por eso hacemos esta asignación dentro de didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // Solo asignar si los controladores están vacíos para evitar reasignar múltiples veces
    if (nameController.text.isEmpty) {
      nameController.text = arguments['nombre'] ?? '';
      correoController.text = arguments['correo'] ?? '';
      direccionController.text = arguments['direccion'] ?? '';
      horarioController.text = arguments['horario'] ?? '';
      telefonoController.text = (arguments['telefono'] ?? '').toString();
      empleadoController.text = (arguments['id_empleado'] ?? '').toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar sucursal'),
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Ingrese la modificación'),
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
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 132, 180, 243),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final int telefono = int.tryParse(telefonoController.text) ?? 0;
                final int empleado = int.tryParse(empleadoController.text) ?? 0;
                final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

                await updateSucursal(
                  arguments['uid'],
                  nameController.text,
                  correoController.text,
                  direccionController.text,
                  horarioController.text,
                  telefono,
                  empleado,
                );
                Navigator.pop(context);
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
