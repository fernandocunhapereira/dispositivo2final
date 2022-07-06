import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:un2projeto/controller/usuariocontroller.dart';

import '../models/foto_usuario.dart';
import '../models/usuario.dart';
import 'image_input.dart';

class UsuarioForm extends StatelessWidget {
  UsuarioForm({Key? key}) : super(key: key);
  final _usuarioControllerNome = TextEditingController();
  final _usuarioControllerEmail = TextEditingController();
  File? _pickedImage;

  void _loadFormData(Usuario usuario) {
    if (usuario.id != 0) {
      _usuarioControllerNome.text = usuario.nome;
      _usuarioControllerEmail.text = usuario.email;
    }
  }

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    final Usuario usuario =
        ModalRoute.of(context)!.settings.arguments as Usuario;
    FotoUsuario fotoUsuario = new FotoUsuario();
    final title = usuario.id == 0 ? 'Cadastrar Usuário' : 'Alterar Usuário';

    _loadFormData(usuario);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color.fromARGB(255, 7, 70, 243), Color.fromARGB(255, 141, 247, 247), Color.fromARGB(255, 184, 132, 248)]),
          ),
        ),
        title: Text(title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                usuario.nome = _usuarioControllerNome.text;
                usuario.email = _usuarioControllerEmail.text;
                fotoUsuario.foto = _pickedImage!;
                fotoUsuario.id = usuario.id;
                if (usuario.id == 0) {
                  Provider.of<UsuarioController>(context, listen: false)
                      .addUsuario(usuario);
                } else {
                  Provider.of<UsuarioController>(context, listen: false)
                      .updateUsuario(usuario);
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(children: <Widget>[
            Padding(
              //padding: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(bottom: 8.0, left: 15, right: 15, top: 20),
              child: TextField(
                controller: _usuarioControllerNome,
                decoration: const InputDecoration(
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.account_box,
                    ),
                  ),
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(bottom: 8.0, left: 15, right: 15, top: 8),
              child: TextField(
                controller: _usuarioControllerEmail,
                decoration: const InputDecoration(
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.email,
                    ),
                  ),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 15, right: 15, top: 8),
              child: Column(
                children: [
                    SizedBox(height: 10),
                    ImageInput(this._selectImage),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}
