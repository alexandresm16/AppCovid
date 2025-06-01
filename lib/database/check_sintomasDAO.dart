import 'package:aula/model/Paciente.dart';
import 'package:aula/service/definir_caso_suspeito.dart';
import '../model/Check_sintomas.dart';

class CheckSintomasDAO {
  static final List<CheckSintomasModel> _checkSintomasPaciente = [];

  static void adicionar(CheckSintomasModel csm) {

    csm.isCasoSuspeito = DefinirCasoSuspeito().casoSuspeito(csm);

    _checkSintomasPaciente.add(csm);
  }

  static List<CheckSintomasModel> getPacienteCheckSintomas(Paciente p) {
    List<CheckSintomasModel> lista = [];

    for (CheckSintomasModel csm in _checkSintomasPaciente) {
      if (p.id == csm.paciente.id) {
        lista.add(csm);
      }
    }

    return lista;
  }
}
