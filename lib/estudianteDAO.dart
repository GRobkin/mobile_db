import 'package:bd_flutter/DatabaseHelper.dart';
import 'package:bd_flutter/estudiante.dart';

class estudianteDAO {
  final Databasehelper _databasehelper = Databasehelper();
  //insert
  Future<void> addEstudiante(estudiante e) async{
    final db = await _databasehelper.database;
    await db.insert('estudiante', e.toMap());
  }
  //update
  Future<void> updateEstudiante(estudiante e) async{
    final db = await _databasehelper.database;
    await db.update('estudiante', e.toMap(),where:"id=?",whereArgs: [e.id]);
  }
  //delete
  Future<void> deleteEstudiante(estudiante e) async{
    final db = await _databasehelper.database;
    await db.delete('estudiante',where: "id=?", whereArgs: [e.id]);
  }
  //select
  Future<List<estudiante>> getEstudiante() async{
    final db = await _databasehelper.database;
    final List<Map<String, dynamic>> maps = await db.query('estudiante');
    return List.generate(maps.length, (index){
      return estudiante.fromMap(maps[index]);
    });
  }
}