import 'package:aula/screens/android/login_screen.dart';
import 'package:aula/screens/android/paciente/paciente_list.dart';
import 'package:flutter/material.dart';

class Dashbord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('DASHBOARD'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _msgSuperiroTXT(),
            _imgCentral(),
            Container(
              //color: Colors.green,
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _ItemElemento(
                    'PACIENTES',
                    Icons.accessibility_new,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PacienteList()
                      ));
                    },
                  ),
                  _ItemElemento(
                    'RESULTADOS',
                    Icons.check_circle_outline,
                    onClick: () {
                      debugPrint('Resultados........');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _imgCentral() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Image.asset('imagens/Checklist-2.jpg'),
  );
}

Widget _msgSuperiroTXT() {
  return Container(
    color: Colors.green,
    alignment: Alignment.topRight,
    padding: const EdgeInsets.all(8.0),
    child: Text(
      'Checklist para o COVID-19',
      style: TextStyle(
        color: Colors.amber.withOpacity(0.9),
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

class _ItemElemento extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final VoidCallback onClick;

  _ItemElemento(this.titulo, this.icone, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.blue[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8.0,
        child: InkWell(
          onTap: this.onClick,
          child: Container(
            //color: Colors.green,
            width: 150,
            height: 80,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(this.icone, color: Colors.white),
                Text(
                  this.titulo,
                  style: TextStyle(color: Colors.amber, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
