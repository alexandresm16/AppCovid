import 'dart:io';
import 'dart:math';

import 'package:aula/database/paciente_dao.dart';
import 'package:aula/model/Paciente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'paciente_add.dart';

class PacienteList extends StatefulWidget {
  @override
  State<PacienteList> createState() => _PacienteListState();
}

class _PacienteListState extends State<PacienteList> {
  @override
  Widget build(BuildContext context) {
    List<Paciente> _pacientes = PacienteDAO.listarPacientes;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('Pacientes')),
      body: Column(
        children: <Widget>[
          Container(
            //color: Colors.green,
            child: TextField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: "Pesquisar",
                hintText: "Pesquisar",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Container(
              //color: Colors.red,
              child: ListView.builder(
                itemCount: _pacientes.length,
                itemBuilder: (context, index) {
                  final Paciente p = _pacientes[index];
                  return ItemPaciente(p);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PacienteScrean()
          )).then((value){

            setState(() {
              debugPrint('retornou do add pacientes');
            });

          });

          setState(() {
            debugPrint('Adicionar paciente.........');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemPaciente extends StatelessWidget {
  final Paciente _paciente;

  ItemPaciente(this._paciente);

  Widget _avatarAntigo(){
    return CircleAvatar(
      backgroundImage: AssetImage('imagens/avatar.png'),
    );
  }

  Widget _avatarFotoPerfil(){

    final random = Random();

// Gera uma cor aleatória clara a partir da paleta de cores principais do Material
    Color cor = Colors.primaries[random.nextInt(Colors.primaries.length)][
    random.nextInt(9) * 100
    ]!;

    var iniciaNome = this._paciente.nome[0].toUpperCase();
    if(this._paciente.foto.length> 0){
      iniciaNome = '';
    }

    return CircleAvatar(
      backgroundColor: cor,
      foregroundColor: Colors.white,
      backgroundImage: FileImage(File(this._paciente.foto)),
      radius: 22.0,
      child: Text(iniciaNome,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: _avatarFotoPerfil(),
          title: Text(this._paciente.nome, style: TextStyle(fontSize: 22)),
          subtitle: Text(this._paciente.email, style: TextStyle(fontSize: 16)),
          trailing: _menu(),
        ),
        Divider(
          color: Colors.green,
          indent: 70.0,
          endIndent: 20,
          thickness: 1.0,
          height: 1,
        ),
      ],
    );
  }

  Widget _menu() {
    return PopupMenuButton(
      onSelected: (ItensMenuListPaciente selecionado) {
        debugPrint('selecionado .... $selecionado');
      },

      itemBuilder:
          (BuildContext context) => <PopupMenuItem<ItensMenuListPaciente>>[
            const PopupMenuItem(
              value: ItensMenuListPaciente.editar,
              child: Text('Editar'),
            ),
            const PopupMenuItem(
              value: ItensMenuListPaciente.resultados,
              child: Text('resultados'),
            ),
            const PopupMenuItem(
              value: ItensMenuListPaciente.novo_checklist,
              child: Text('novo_checklist'),
            ),
          ],
    );
  }
}

enum ItensMenuListPaciente { editar, resultados, novo_checklist }
