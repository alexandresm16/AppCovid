import 'package:sqflite/sqflite.dart';

import '../model/Paciente.dart';
import 'openDataBaseDB.dart';

class PacienteDAO {
  //static final List<Paciente> _pacientes = <Paciente>[];

  static const String _nomeTabela = 'paciente';
  static const String _col_id = 'id';
  static const String _col_nome = 'nome';
  static const String _col_email = 'email';
  static const String _col_idade = 'idade';
  static const String _col_cartao = 'cartao';
  static const String _col_senha = 'senha';
  static const String _col_foto = 'foto';

  static const String sqlTabelaPaciente = 'CREATE TABLE $_nomeTabela ('
      '$_col_id INTEGER PRIMARY KEY, '
      '$_col_nome TEXT, '
      '$_col_email TEXT, '
      '$_col_cartao TEXT, '
      '$_col_idade INTEGER, '
      '$_col_senha TEXT, '
      '$_col_foto TEXT )';


  adicionar(Paciente p) async {
    // _pacientes.add(p);

    final Database db = await getDatabase();
    await db.insert(_nomeTabela, p.toMap());

  }

  static Paciente getPaciente(int index){
    return getPaciente(index);
  }

  atualizar(Paciente p) async {

    final Database db = await getDatabase();
    db.update(_nomeTabela, p.toMap(), where: 'id=?', whereArgs: [p.id]);

  }

  //  static get listarPacientes {
    //return _pacientes;
  // }

  Future<List<Paciente>>  getPacientes() async {

    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);

    return List.generate(maps.length, (i){
      return Paciente(
        maps[i][_col_id],
        maps[i][_col_nome],
        maps[i][_col_email],
        maps[i][_col_cartao],
        maps[i][_col_idade],
        maps[i][_col_senha],
        maps[i][_col_foto],
      );
    });

  }


}
