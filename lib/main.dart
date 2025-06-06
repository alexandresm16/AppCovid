import 'dart:io';

import 'package:aula/database/paciente_dao.dart';
import 'package:aula/screens/android/appcovid.dart';
import 'package:flutter/material.dart';

import 'model/Paciente.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _gerarPacientes(){
    Paciente p = Paciente(
      1,
      'Alexandre',
      'Alexandre@gmail.com',
      'cartao123',
      26,
      'senha',
      ''
    );

    Paciente p1 = Paciente(
      2,
      'João',
      'Joao@gmail.com',
      'cartao321',
      22,
      'senha',
      ''
    );

    Paciente p2 = Paciente(
      3,
      'Pedro',
      'Pedro@gmail.com',
      'cartao132',
      28,
      'senha',
      ''
    );

    Paciente p3 = Paciente(
      1,
      'Gabriel',
      'Gabriel@gmail.com',
      'cartao312',
      25,
      'senha',
      ''
    );

    //  PacienteDAO().adicionar(p);

  }


  PacienteDAO().getPacientes().then((value) {
    for(Paciente p in value){
      debugPrint('Paciente nome: '+p.nome + p.id.toString());
    }
  });

  if(Platform.isAndroid){
    debugPrint('app no android');
    _gerarPacientes();
    runApp(Appcovid());
  }
  if(Platform.isIOS){
    debugPrint('app no IOS');
  }

}
