import 'package:bd_flutter/EstudianteDAO.dart';
import 'package:bd_flutter/Estudiante.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController controllerNombre = TextEditingController();
  final TextEditingController controllerMatricula = TextEditingController();
  final EstudianteDAO _dao = EstudianteDAO();

  List<Estudiante> _estudiantes = [];

  @override
  void initState() {
    super.initState();
    _cargarEstudiantes();
  }

  Future<void> _cargarEstudiantes() async {
    final lista = await _dao.getEstudiantes();
    setState(() {
      _estudiantes = lista;
    });
  }

  Future<void> _guardar() async {
    final nombre = controllerNombre.text.trim();
    final matricula = controllerMatricula.text.trim();

    if (nombre.isEmpty || matricula.isEmpty) return;

    await _dao.addEstudiante(Estudiante(nombre: nombre, matricula: matricula));
    controllerNombre.clear();
    controllerMatricula.clear();
    await _cargarEstudiantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            SizedBox(height: 15),
            TextField(
              controller: controllerNombre,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(height: 33),
            TextField(
              controller: controllerMatricula,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                labelText: "Matricula",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(height: 33),
            ElevatedButton(
              onPressed: _guardar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Guardar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: _estudiantes.length,
                itemBuilder: (context, index) {
                  final e = _estudiantes[index];
                  return ListTile(
                    title: Text(e.nombre),
                    subtitle: Text(e.matricula),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _dao.deleteEstudiante(e);
                        await _cargarEstudiantes();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}