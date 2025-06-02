import 'dart:io';

import 'package:aula/database/paciente_dao.dart';
import 'package:aula/model/Paciente.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PacienteScrean extends StatefulWidget {
  int? index;
  Paciente? paciente;

  PacienteScrean({this.paciente}) {
    if (paciente == null) {
      index = -1;
    } else {
      index = paciente!.id;
      this.paciente = paciente;
    }
  }

  @override
  State<PacienteScrean> createState() => _PacienteScreanState();
}

class _PacienteScreanState extends State<PacienteScrean> {
  final TextEditingController _nomeController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _cartaoController = TextEditingController();

  final TextEditingController _idadeController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  late Paciente _paciente;
  String _fotoPerfil = ''; // garantir que sempre exista um valor

  @override
  void initState() {
    super.initState();

    int index = widget.index ?? -1;

    if (index >= 0) {
      debugPrint('EDITAR INDEX = $index');
      Paciente pacienteExistente = widget.paciente!;

      _paciente = Paciente(
        index,
        pacienteExistente.nome,
        pacienteExistente.email,
        pacienteExistente.cartao,
        pacienteExistente.idade,
        pacienteExistente.senha,
        pacienteExistente.foto,
      );

      _nomeController.text = _paciente.nome;
      _emailController.text = _paciente.email;
      _cartaoController.text = _paciente.cartao;
      _idadeController.text = _paciente.idade.toString();
      _senhaController.text = _paciente.senha;
      _fotoPerfil = _paciente.foto;
    } else {
      // Novo paciente com dados padrão
      _paciente = Paciente(0, '', '', '', 0, '', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('ADD PACIENTE')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _fotoAvatar(context),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'nome obrigatório';
                  }
                  return null;
                },
                controller: this._nomeController,
                decoration: InputDecoration(labelText: "Nome"),
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'e-mail obrigatório';
                  }
                  return null;
                },
                controller: this._emailController,
                decoration: InputDecoration(labelText: "E-mail"),
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'cartão obrigatório';
                  }
                  return null;
                },
                controller: this._cartaoController,
                decoration: InputDecoration(labelText: "Cartão SUS"),
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Idade obrigatória';
                  }
                  return null;
                },
                controller: this._idadeController,
                decoration: InputDecoration(labelText: "Idade"),
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Senha obrigatória';
                  }
                  return null;
                },
                controller: this._senhaController,
                decoration: InputDecoration(labelText: "Senha"),
                style: TextStyle(fontSize: 20),
                obscureText: true,
              ),
              Container(
                //color: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(18),
                    ),
                    elevation: WidgetStateProperty.all(8),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.lightBlue,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      int index = widget.index ?? -1;
                      Paciente p = new Paciente(
                        index,
                        this._nomeController.text,
                        this._emailController.text,
                        this._cartaoController.text,
                        int.tryParse(this._idadeController.text) ?? 0,
                        this._senhaController.text,
                        this._fotoPerfil,
                      );

                      if (index >= 0) {
                        PacienteDAO().atualizar(p);
                        Navigator.of(context).pop();
                      } else {
                        PacienteDAO().adicionar(p);
                        Navigator.of(context).pop();
                      }
                    } else {
                      debugPrint('Formulário inválido');
                    }
                  },
                  child: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fotoAvatar(BuildContext context) {
    return InkWell(
      onTap: () {
        alertTirarFoto(context);
        debugPrint('Tirar foto.........');
      },
      child: CircleAvatar(
        radius: 65,
        backgroundImage:
            _fotoPerfil.isNotEmpty && File(_fotoPerfil).existsSync()
                ? FileImage(File(_fotoPerfil))
                : AssetImage('imagens/camera.png') as ImageProvider,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
      ),
    );
  }

  alertTirarFoto(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Tirar foto?', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text(
        'Escolha entre camêra ou galeria para uma foto do seu perfil',
      ),
      elevation: 5.0,
      actions: <Widget>[
        TextButton(
          child: Text('Camera'),
          onPressed: () {
            debugPrint('Usuário escolheu a camera');
            _obterImage(ImageSource.camera);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Galeria'),
          onPressed: () {
            debugPrint('Usuário escolheu a galeria');
            _obterImage(ImageSource.gallery);
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _obterImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image == null) {
        debugPrint('Nenhuma imagem selecionada.');
        return;
      }

      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cortar imagem',
            toolbarColor: Colors.white,
            statusBarColor: Colors.lightBlue,
            backgroundColor: Colors.white,
            activeControlsWidgetColor: Colors.blue,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Cortar imagem',
            cancelButtonTitle: 'Cancelar',
            doneButtonTitle: 'Concluir',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _fotoPerfil = croppedFile.path;
        });
        debugPrint('Imagem cortada salva em: $_fotoPerfil');
      } else {
        debugPrint('Corte de imagem cancelado.');
      }
    } catch (e, stackTrace) {
      debugPrint('Erro ao obter ou cortar imagem: $e');
      debugPrint('StackTrace: $stackTrace');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao processar a imagem: $e')));
    }
  }
}
