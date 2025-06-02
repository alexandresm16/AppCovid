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
    //List<Paciente> _pacientes = PacienteDAO.listarPacientes;

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
              child: _futureBuilderPaciente(),
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

  Widget _futureBuilderPaciente() {
    return FutureBuilder<List<Paciente>>(
      initialData: const <Paciente>[],
      future: PacienteDAO().getPacientes(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(child: Text('Sem conexão.'));
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Carregando...'),
                ],
              ),
            );
          case ConnectionState.active:
            return const Center(child: Text('Conexão ativa...'));
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar os dados.'));
            }

            final List<Paciente> pacientes = snapshot.data ?? [];

            if (pacientes.isEmpty) {
              return const Center(child: Text('Nenhum paciente encontrado.'));
            }

            return ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                final Paciente p = pacientes[index];
                return ItemPaciente(
                  p,
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PacienteScrean(paciente: p,),
                      ),
                    ).then((value) {
                      setState(() {
                        debugPrint('...........Voltou do editar');
                      });
                    });
                  },
                );
              },
            );
        }
      },
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
              builder: (context) => ChecklistSintomas(paciente: this._paciente)
          ));
        } else {

          CheckSintomasDAO().getPacienteCheckSintomas(this._paciente).then((sintomas) {

            if(sintomas.length > 0){

              for(CheckSintomasModel csm in sintomas){
                print(csm);
              }

            } else {
              print('Nenhum registro encontrado');
            }


          });
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
