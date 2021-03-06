import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:un2projeto/controller/usuariocontroller.dart';
import 'package:un2projeto/utils/app_routes.dart';

import '../models/usuario.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({Key? key}) : super(key: key);

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<UsuarioController>(context);
    //final _controller = context.watch<UsuarioController>();

    //_controller.start();

    return ListView.separated(
      padding: EdgeInsets.all(15),
      itemCount: _controller.usuarios.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: 
                /*Text('${_controller.usuarios[index].id}'),*/
                ClipRRect(
                                //child: Image.asset('profile-generic.png'),
                  child: Icon (
                    Icons.account_circle, 
                    size: 30,
                  ),
                ),
              ),
              title: Text(_controller.usuarios[index].nome),
              subtitle: Text(_controller.usuarios[index].email),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Color.fromARGB(255, 39, 122, 185), width: 1),
                  borderRadius: BorderRadius.circular(5)),
              tileColor: Color.fromARGB(255, 255, 255, 255),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          updateCliente(_controller.usuarios[index]);
                        },
                        icon: const Icon(Icons.edit),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      IconButton(
                        onPressed: () {
                          _controller
                              .deleteUsuario(_controller.usuarios[index]);
                        },
                        icon: const Icon(Icons.delete),
                        color: Color.fromARGB(255, 183, 31, 20),
                      ),
                    ],
                  )),
              // onTap: () {
              //   setState(() {
              //     _usuario = globals.listaUsuariosGlobal[index];
              //   });
              // },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 10,
        );
      },
    );
  }

  void updateCliente(Usuario usuario) {
    Navigator.of(context).pushNamed(AppRoutes.USUARIO_FORM, arguments: usuario);
  }
}
