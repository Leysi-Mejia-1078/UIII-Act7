import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi CRUD'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),

      body: FutureBuilder(
        future: getSucursal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteSucursal(snapshot.data?[index]['uid']);
                    snapshot.data?.remove(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            '¿Estas seguro de eliminar a ${snapshot.data?[index]['nombre']}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Si, estoy seguro'),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: const Color.fromARGB(255, 21, 97, 238),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: Container(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 132, 180, 243)),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          snapshot.data?[index]['nombre'] ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.email, size: 18, color: Color.fromARGB(255, 21, 97, 238)),
                                const SizedBox(width: 6),
                                Text('Correo: ${snapshot.data?[index]['correo'] ?? ''}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 18, color: Color.fromARGB(255, 21, 97, 238)),
                                const SizedBox(width: 6),
                                Text('Dirección: ${snapshot.data?[index]['direccion'] ?? ''}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 18, color: Color.fromARGB(255, 21, 97, 238)),
                                const SizedBox(width: 6),
                                Text('Horario: ${snapshot.data?[index]['horario'] ?? ''}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 18, color: Color.fromARGB(255, 21, 97, 238)),
                                const SizedBox(width: 6),
                                Text('Teléfono: ${snapshot.data?[index]['telefono']?.toString() ?? ''}'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.person, size: 18, color: Color.fromARGB(255, 21, 97, 238)),
                                const SizedBox(width: 6),
                                Text('Encargado ID: ${snapshot.data?[index]['id_empleado']?.toString() ?? ''}'),
                              ],
                            ),
                          ],
                        ),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: {
                              'nombre': snapshot.data?[index]['nombre'],
                              'correo': snapshot.data?[index]['correo'],
                              'direccion': snapshot.data?[index]['direccion'],
                              'horario': snapshot.data?[index]['horario'],
                              'telefono': snapshot.data?[index]['telefono'],
                              'id_empleado': snapshot.data?[index]['id_empleado'],
                              'uid': snapshot.data?[index]['uid'],
                            },
                          );
                          setState(() {});
                        },
                      ),
                    ),
                  )
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),
    );
  }
}
