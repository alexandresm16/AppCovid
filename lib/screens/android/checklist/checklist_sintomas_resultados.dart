import 'package:aula/database/check_sintomasDAO.dart';
import 'package:aula/screens/android/paciente/paciente_list.dart';
import 'package:flutter/material.dart';

import '../../../model/Check_sintomas.dart';
import '../../../service/definir_caso_suspeito.dart';

class ChecklistSintomasResultados extends StatelessWidget {
  final CheckSintomasModel _checkSintomasModel;
  late final String _msg;

  ChecklistSintomasResultados(this._checkSintomasModel, {Key? key}) : super(key: key) {
    _msg = DefinirCasoSuspeito().casoSuspeitoCovidOrientacao(_checkSintomasModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultado')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _msg,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _registrarBtn(context),
          ],
        ),
      ),
    );
  }

  Widget _registrarBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          icon: Icon(Icons.check_circle_outline, color: Colors.white),
          label: Text('Registrar', style: TextStyle(color: Colors.white)),
          onPressed: () {
            debugPrint("BOTÃO Registrar.............");
            CheckSintomasDAO.adicionar(_checkSintomasModel);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PacienteList()),
            );
          },
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[600],
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          icon: Icon(Icons.cancel_outlined, color: Colors.white),
          label: Text('Descartar', style: TextStyle(color: Colors.white)),
          onPressed: () {
            debugPrint("BOTÃO Descartar.............");
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
