import 'dart:io';
import 'dart:math';

import 'package:aula/database/paciente_dao.dart';
import 'package:aula/model/Check_sintomas.dart';
import 'package:aula/model/Paciente.dart';
import 'package:aula/screens/android/checklist/checklist_sintomas_resultados.dart';
import 'package:flutter/material.dart';

class ChecklistSintomas extends StatelessWidget {

  late final Paciente _paciente;

  final _formKey = GlobalKey<FormState>();

  ChecklistSintomas({required Paciente paciente}){
    this._paciente = paciente;

    _isTosse = false;
    _isDorGarganta = false;
    _isCatarro = false;
    _isNarizEntupido = false;
    _isRouquidao = false;

    debugPrint(_paciente.id.toString());
  }

    TextEditingController tempController = new TextEditingController();
    TextEditingController diasSintomasController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sintomas: '+this._paciente.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                _pacienteAvatar(),
                CheckSintomas(),
                _temp_diaSisntomasTFF(),
                _registrarBtn(context),
              ],
            ),
          ),
        ),
      )
    );
  }


  Widget _temp_diaSisntomasTFF(){
    return Column(
      children: [
        SizedBox(
          height: 25.0,
        ),
        TextFormField(
          validator: (value){
            if(value!.isEmpty){
              return 'Temperatura obrigadtória';
            }
            return null;
          },
          controller: tempController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Temperatura",
            hintText: "Digite a temperatura"
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          validator: (value){
            if(value!.isEmpty){
              return 'Informar os dias com os sintomas';
            }
            return null;
          },
          controller: diasSintomasController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Dias com sintomas",
            hintText: "Digite os dias"
          ),
          keyboardType: TextInputType.number,
        )
      ],
    );
  }

  Widget _registrarBtn(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () {
            if(this._formKey.currentState!.validate()){
              debugPrint("REGISTRAR");
              debugPrint("Paciente: "+this._paciente.nome);
              debugPrint("Tosse: "+_isTosse.toString());
              debugPrint("Catarro: "+_isCatarro.toString());
              debugPrint("Rouquidão: "+_isRouquidao.toString());
              debugPrint("Dor de garganta: "+_isDorGarganta.toString());
              debugPrint("Nariz entupido: "+_isNarizEntupido.toString());

              debugPrint("Tempo: ${tempController.text}");
              debugPrint("Paciente: ${diasSintomasController.text}");

              CheckSintomasModel csm = CheckSintomasModel(
                0,
                this._paciente,
                int.parse(this.tempController.text),
                int.parse(this.diasSintomasController.text),
                _isNarizEntupido,
                _isDorGarganta,
                _isRouquidao,
                _isCatarro,
                _isTosse,
                DateTime.now(),
                true,
              );

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChecklistSintomasResultados(csm)
              ));

              
            }else {
              debugPrint("FORMULÁRIO INVALIDO");
            }
          },
          style: ButtonStyle(elevation: WidgetStateProperty.all(8)),
          child: Text(
            'REGISTRAR',
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _pacienteAvatar(){
    return
    Column(
      children: [
        ListTile(
          leading: _avatarFotoPerfil(),
          title: Text(this._paciente.nome.toUpperCase(),
            style: TextStyle(
                color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold
            ),),
          subtitle: Text(this._paciente.email, style: TextStyle(
              fontSize: 15
          ),),
        ),
        Divider(
          color: Colors.green,
          endIndent: 20,
          indent: 70,
          thickness: 1.0,
          height: 0.0,
        )
      ],
    );
  }

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
}


class CheckSintomas extends StatefulWidget {


  @override
  State<CheckSintomas> createState() => _CheckSintomasState();
}

  bool _isTosse = false;
  bool _isDorGarganta = false;
  bool _isCatarro = false;
  bool _isNarizEntupido = false;
  bool _isRouquidao = false;

class _CheckSintomasState extends State<CheckSintomas> {
  bool valor = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _itemCheck(label: 'Tosse', valor: _isTosse, onChanged: (){
          setState(() {
            _isTosse = !_isTosse;
          });
        }),
        _itemCheck(label: 'Catarro', valor: _isCatarro, onChanged: (){
          setState(() {
            _isCatarro = !_isCatarro;
          });
        }),
        _itemCheck(label: 'Rouquidão', valor: _isRouquidao, onChanged: (){
          setState(() {
            _isRouquidao = !_isRouquidao;
          });
        }),
        _itemCheck(label: 'Dor de Garganta', valor: _isDorGarganta, onChanged: (){
          setState(() {
            _isDorGarganta = !_isDorGarganta;
          });
        }),
        _itemCheck(label: 'Nariz entupido', valor: _isNarizEntupido, onChanged: (){
          setState(() {
            _isNarizEntupido = !_isNarizEntupido;
          });
        }),
      ],
    );
  }

  Widget _itemCheck({required String label,required bool valor,required Function onChanged}){
    return InkWell(
      onTap: (){
        onChanged();
      },
      child: Row(
        children: [
          Checkbox(
            value: valor,
            onChanged: (bool? novoValor) {
              onChanged();
            },
            checkColor: Colors.green,
            activeColor: Colors.white,
          ),
          Text(label, style: TextStyle(fontSize: 28.0),)
        ],
      ),
    );
  }
}


