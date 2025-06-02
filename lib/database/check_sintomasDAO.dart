import 'package:aula/database/openDataBaseDB.dart';
import 'package:aula/model/Paciente.dart';
import 'package:aula/service/definir_caso_suspeito.dart';
import 'package:sqflite/sqflite.dart';
import '../model/Check_sintomas.dart';

class CheckSintomasDAO {

  static const String _nomeTabela = 'checksintomas';
  static const String _col_id = 'id_cs';
  static const String _col_idpaciente = 'idpaciente';
  static const String _col_temp = 'temp';
  static const String _col_qtdDias = 'qtddiassintomas';
  static const String _col_isNarizEntupido = 'narizentupido';
  static const String _col_isDorGarganta = 'dorgarganta';
  static const String _col_isRouquidao = 'rouquidao';
  static const String _col_isCatarro = 'catarro';
  static const String _col_isTosse = 'tosse';
  static const String _col_dataAvaliacao = 'dataavaliacao';
  static const String _col_isCasoSuspeito = 'casosuspeito';

  static const String sqlTabela = 'CREATE TABLE $_nomeTabela ('
      '$_col_id INTEGER PRIMARY KEY, '
      '$_col_idpaciente INTEGER, '
      '$_col_temp INTEGER, '
      '$_col_qtdDias INTEGER, '
      '$_col_isNarizEntupido INTEGER, '
      '$_col_isDorGarganta INTEGER, '
      '$_col_isRouquidao INTEGER, '
      '$_col_isCatarro INTEGER, '
      '$_col_isTosse INTEGER, '
      '$_col_dataAvaliacao TEXT, '
      '$_col_isCasoSuspeito INTEGER, '
      ' FOREIGN KEY ($_col_idpaciente) REFERENCES paciente(id))';

  //static final List<CheckSintomasModel> _checkSintomasPaciente = [];

  static void adicionar(CheckSintomasModel csm) async {

    csm.isCasoSuspeito = DefinirCasoSuspeito().casoSuspeito(csm);

    final Database db = await getDatabase();
    db.insert(_nomeTabela, csm.toMap());

    //_checkSintomasPaciente.add(csm);
  }

  static const String _nomeTabelaPaciente = 'paciente';
  static const String _col_idP = 'id';
  static const String _col_nome = 'nome';
  static const String _col_email = 'email';
  static const String _col_idade = 'idade';
  static const String _col_cartao = 'cartao';
  static const String _col_senha = 'senha';
  static const String _col_foto = 'foto';

  Future <List<CheckSintomasModel>> getPacienteCheckSintomas(Paciente p) async {

    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
    await db.rawQuery('SELECT * FROM $_nomeTabela cs, $_nomeTabelaPaciente p'
        ' WHERE cs.idpaciente = p.id AND p.id = '+p.id.toString());


    return List.generate(maps.length, (i) {

      Paciente paciente = Paciente(
        maps[i][_col_idP],
        maps[i][_col_nome],
        maps[i][_col_email],
        maps[i][_col_cartao],
        maps[i][_col_idade],
        maps[i][_col_senha],
        maps[i][_col_foto],
      );

      return CheckSintomasModel(
        maps[i][_col_id],
        paciente,
        maps[i][_col_temp],
        maps[i][_col_qtdDias],
        maps[i][_col_isNarizEntupido] == 1 ? true : false,
        maps[i][_col_isDorGarganta] == 1 ? true : false,
        maps[i][_col_isRouquidao] == 1 ? true : false,
        maps[i][_col_isCatarro] == 1 ? true : false,
        maps[i][_col_isTosse] == 1 ? true : false,
        DateTime.parse(maps[i][_col_dataAvaliacao]),
        maps[i][_col_isCasoSuspeito] == 1 ? true : false,
      );
    });
  }
}
