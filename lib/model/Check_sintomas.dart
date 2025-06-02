import 'package:aula/model/Paciente.dart';

class CheckSintomasModel {
  int _id;
  Paciente _paciente;
  int _temp;
  int _qtdDiasSintomas;
  bool _isTosse;
  bool _isDorGarganta;
  bool _isCatarro;
  bool _isNarizEntupido;
  bool _isRouquidao;
  DateTime _dataAvaliacao;
  bool _isCasoSuspeito;

  CheckSintomasModel(
    this._id,
    this._paciente,
    this._temp,
    this._qtdDiasSintomas,
    this._isNarizEntupido,
    this._isDorGarganta,
    this._isRouquidao,
    this._isCatarro,
    this._isTosse,
    this._dataAvaliacao,
    this._isCasoSuspeito,
  );

  Map<String, dynamic> toMap(){
    return{
      'idpaciente' : _paciente.id,
      'temp' : _temp,
      'qtddiassintomas' : _qtdDiasSintomas,
      'narizentupido' : _isNarizEntupido == true ? 1 : 0,
      'dorgarganta' :  _isDorGarganta == true ? 1 : 0,
      'rouquidao' : _isRouquidao == true ? 1 : 0,
      'catarro' : _isCatarro == true ? 1 : 0,
      'tosse' : _isTosse == true ? 1 : 0,
      'dataavaliacao' : _dataAvaliacao.toIso8601String(),
      'casosuspeito' : _isCasoSuspeito  == true ? 1 : 0,
    };
  }


  bool get isCasoSuspeito => _isCasoSuspeito;

  set isCasoSuspeito(bool value) {
    _isCasoSuspeito = value;
  }

  DateTime get dataAvaliacao => _dataAvaliacao;

  bool get isRouquidao => _isRouquidao;

  bool get isNarizEntupido => _isNarizEntupido;

  bool get isCatarro => _isCatarro;

  bool get isDorGarganta => _isDorGarganta;

  bool get isTosse => _isTosse;

  int get qtdDiasSintomas => _qtdDiasSintomas;

  int get temp => _temp;

  Paciente get paciente => _paciente;

  int get id => _id;

  set id(int value) {
    _id = value;
  }


  @override
  String toString() {
    // TODO: implement toString
    return 'CHECKLIST SINTOMAS $_id: Paciente: '+paciente.id.toString()+' $_paciente.id, nome: '+paciente.nome
        +', temp: $_temp, '+', dias sintomas: $_qtdDiasSintomas'
        +', iscatarro: $_isCatarro'+', Tosse: $_isTosse'+', Roquidao: $_isRouquidao'
        +', Garganta: $_isDorGarganta'+', Nariz: $_isNarizEntupido'
        +', SUSPEITO?: $_isCasoSuspeito'
        +', Data: '+dataAvaliacao.day.toString()+'/'+dataAvaliacao.month.toString()
        +'/'+dataAvaliacao.year.toString();
  }
}
