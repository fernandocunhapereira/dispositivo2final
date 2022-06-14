import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:un2projeto/controller/usuariocontroller.dart';

import '../models/usuario.dart';

class UsuarioForm extends StatelessWidget {
  UsuarioForm({Key? key}) : super(key: key);
  final _usuarioControllerNome = TextEditingController();
  final _usuarioControllerEmail = TextEditingController();

  void _loadFormData(Usuario usuario) {
    if (usuario.id != 0) {
      _usuarioControllerNome.text = usuario.nome;
      _usuarioControllerEmail.text = usuario.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Usuario usuario =
        ModalRoute.of(context)!.settings.arguments as Usuario;
    final title = usuario.id == 0 ? 'Cadastrar Usuário' : 'Alterar Usuário';

    _loadFormData(usuario);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                usuario.nome = _usuarioControllerNome.text;
                usuario.email = _usuarioControllerEmail.text;
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
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 4,
            margin: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 238, 229, 248),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _usuarioControllerNome,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _usuarioControllerEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
