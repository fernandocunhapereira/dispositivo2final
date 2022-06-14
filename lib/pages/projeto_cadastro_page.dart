import 'package:flutter/material.dart';

import 'package:date_field/date_field.dart';
import 'package:provider/provider.dart';
import 'package:un2projeto/controller/projetocontroller.dart';

import '../models/projeto.dart';

class ProjetoCadastroPage extends StatefulWidget {
  const ProjetoCadastroPage({Key? key}) : super(key: key);

  @override
  State<ProjetoCadastroPage> createState() => _ProjetoCadastroPageState();
}

class _ProjetoCadastroPageState extends State<ProjetoCadastroPage> {
  final _projetoControllerTitulo = TextEditingController();

  final _projetoControllerDescricao = TextEditingController();

  //final _projetoControllerPrazo = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  void _loadFormData(Projeto projeto) {
    if (projeto.id != 0) {
      _projetoControllerTitulo.text = projeto.titulo;
      _projetoControllerDescricao.text = projeto.descricao;
      _dataSelecionada = projeto.prazo;
    }
  }

  salvarProjeto(Projeto projeto) {
    projeto.titulo = _projetoControllerTitulo.text;
    projeto.descricao = _projetoControllerDescricao.text;
    projeto.prazo = _dataSelecionada;
    if (projeto.id == 0) {
      Provider.of<ProjetoController>(context, listen: false)
          .addProjeto(projeto);
    } else {
      Provider.of<ProjetoController>(context, listen: false)
          .updateProjeto(projeto);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Projeto projeto =
        ModalRoute.of(context)!.settings.arguments as Projeto;
    final title = projeto.id == 0 ? 'Cadastrar Projeto' : 'Alterar Projeto';

    _loadFormData(projeto);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(children: <Widget>[
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
                  controller: _projetoControllerTitulo,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _projetoControllerDescricao,
                  decoration: const InputDecoration(
                    labelText: 'Descricao',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              StatefulBuilder(
                builder: (_context, _setState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeField(
                        mode: DateTimeFieldPickerMode.date,
                        decoration: const InputDecoration(
                            labelText: 'Data de Entrega',
                            border: OutlineInputBorder()),
                        selectedDate: _dataSelecionada,
                        onDateSelected: (DateTime value) {
                          _setState(() {
                            _dataSelecionada = value;
                          });
                        }),
                  );
                },
              ),
            ])),
        // Divider(
        //   height: 20,
        // ),
        // ElevatedButton(
        //     onPressed: _showDatePicker, child: Text('Prazo Entrega')),
        const Divider(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              salvarProjeto(projeto);
            },
            child: const Text('Salvar')),

        /*
        TextField(
          controller: _projetoControllerTitulo,
          decoration: InputDecoration(labelText: 'Título'),
        ),
        TextField(
          controller: _projetoControllerDescricao,
          decoration: InputDecoration(labelText: 'Descricao'),
        ),
        TextButton(onPressed: _showDatePicker, child: Text('Prazo Entrega')),
        ElevatedButton(onPressed: salvarProjeto, child: Text('Salvar'))*/
      ]),
    );
  }
}
