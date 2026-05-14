import 'package:bd_flutter/DatabaseHelper.dart';
import 'package:bd_flutter/Estudiante.dart';

class EstudianteDAO {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // insert
  Future<void> addEstudiante(Estudiante e) async {
    final db = await _databaseHelper.database;
    await db.insert('estudiante', e.toMap());
  }

  // update
  Future<void> updateEstudiante(Estudiante e) async {
    final db = await _databaseHelper.database;
    await db.update(
      'estudiante',
      e.toMap(),
      where: "id = ?",
      whereArgs: [e.id],
    );
  }

  // delete
  Future<void> deleteEstudiante(Estudiante e) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'estudiante',
      where: "id = ?",
      whereArgs: [e.id],
    );
  }

  // select all
  Future<List<Estudiante>> getEstudiantes() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('estudiante');
    return List.generate(maps.length, (index) {
      return Estudiante.fromMap(maps[index]);
    });
  }
}