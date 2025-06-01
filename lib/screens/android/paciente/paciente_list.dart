import 'dart:io';
import 'dart:math';

import 'package:aula/database/check_sintomasDAO.dart';
import 'package:aula/database/paciente_dao.dart';
import 'package:aula/model/Check_sintomas.dart';
import 'package:aula/model/Paciente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../checklist/checklist_sintomas.dart';
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
                  p.id = index;
                  return ItemPaciente(p, onClick: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=> PacienteScrean(index: index))
                    ).then((value){
                      setState(() {
                        debugPrint('voltou do editar....');
                      });
                    });
                  },);
                },),
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
  final Function onClick;

  ItemPaciente(this._paciente, {required this.onClick});

  //Widget _avatarAntigo(){
  //   return CircleAvatar(
  //     backgroundImage: AssetImage('imagens/avatar.png'),
//    );
//  }

  Widget _avatarFotoPerfil() {
    final random = Random();

    // Seleciona uma cor aleatória de forma segura
    final MaterialColor corPrincipal = Colors.primaries[random.nextInt(Colors.primaries.length)];
    final List<int> tonsDisponiveis = [100, 200, 300, 400, 500, 600, 700, 800, 900];
    final int tom = tonsDisponiveis[random.nextInt(tonsDisponiveis.length)];
    final Color cor = corPrincipal[tom] ?? Colors.grey;

    String iniciaNome = '';
    if (_paciente.nome.isNotEmpty) {
      iniciaNome = _paciente.nome[0].toUpperCase();
    }

    bool fotoValida = _paciente.foto.isNotEmpty && File(_paciente.foto).existsSync();

    return CircleAvatar(
      backgroundColor: cor,
      foregroundColor: Colors.white,
      backgroundImage: fotoValida ? FileImage(File(_paciente.foto)) : null,
      radius: 22.0,
      child: fotoValida
          ? null
          : Text(
        iniciaNome,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => this.onClick(),
          leading: _avatarFotoPerfil(),
          title: Text(this._paciente.nome, style: TextStyle(fontSize: 22)),
          subtitle: Text(this._paciente.email, style: TextStyle(fontSize: 16)),
          trailing: _menu(context),
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

  Widget _menu(BuildContext context) {
    return PopupMenuButton(
      onSelected: (ItensMenuListPaciente selecionado) {

        if(selecionado == ItensMenuListPaciente.novo_checklist ){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChecklistSintomas(idpaciente: this._paciente.id)
          ));
        } else {

          if(CheckSintomasDAO.getPacienteCheckSintomas(this._paciente).length > 0){
            for(CheckSintomasModel csm in CheckSintomasDAO.getPacienteCheckSintomas(this._paciente)){

              debugPrint(csm.toString());
            }
          }else{
            debugPrint("Nenhum registro encontrado..........");
          }

        }

        debugPrint('selecionado .... $selecionado');
      },

      itemBuilder:
          (BuildContext context) => <PopupMenuItem<ItensMenuListPaciente>>[
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

enum ItensMenuListPaciente { resultados, novo_checklist }
