import '../model/Paciente.dart';

class PacienteDAO {
  static final List<Paciente> _pacientes = <Paciente>[];

  static adicionar(Paciente p){
    _pacientes.add(p);
  }

  static get listarPacientes {
    return _pacientes;
  }
}
