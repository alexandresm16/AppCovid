import '../model/Paciente.dart';

class PacienteDAO {
  static final List<Paciente> _pacientes = <Paciente>[];

  static adicionar(Paciente p){
    _pacientes.add(p);
  }

  static Paciente getPaciente(int index){
    return _pacientes.elementAt(index);
  }

  static void atualizar(Paciente p){
    _pacientes.replaceRange(p.id, p.id+1, [p]);
  }

  static get listarPacientes {
    return _pacientes;
  }
}
