import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:un2projeto/controller/tarefacontroller.dart';

import '../componentes/tarefa_item.dart';
import '../models/projeto.dart';
import '../utils/app_routes.dart';

class ProjetoDetalhePage extends StatefulWidget {
  const ProjetoDetalhePage({Key? key}) : super(key: key);

  @override
  State<ProjetoDetalhePage> createState() => _ProjetoDetalhePageState();
}

class _ProjetoDetalhePageState extends State<ProjetoDetalhePage> {
  @override
  Widget build(BuildContext context) {
    final projeto = ModalRoute.of(context)!.settings.arguments as Projeto;
    final _controller = Provider.of<TarefaController>(context, listen: false);

    _controller.start(projeto.id);

    //_controller.start(projeto.id);
    //.where((tarefas) {
    //   return tarefas.id == projeto.id;
    // }).toList();

    cadastrarTarefa() {
      Navigator.pushNamed(context, AppRoutes.TAREFA_CADASTRO,
          arguments: projeto);
    }

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
        title: Text(projeto.titulo),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              projeto.descricao,
              //style: Theme.of(context).textTheme.headline6,
              style: TextStyle(backgroundColor: Colors.white,
                fontSize: 18
              ),
            ),
            const Divider(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: Consumer<TarefaController>(
                    builder: (context, value, child) {
                  switch (value.state.value) {
                    case TarefaState.error:
                      return const Center(child: Text('Erro não carregou'));
                    case TarefaState.loading:
                      return const Center(child: Text('loading não carregou'));
                    case TarefaState.start:
                      return const Center(child: Text('start não carregou'));
                    default:
                  }
                  var tarefas = value.tarefas;

                  return ListView.separated(
                    //itemCount: countryPlaces.length,
                    itemCount: tarefas.length,
                    itemBuilder: (ctx, index) {
                      return TarefaItem(tarefas[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 10,
                      );
                    },
                  );
                }),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
                )
              ),
                onPressed: cadastrarTarefa /*cadastrarTarefa*/,
                child: const Text(
                  'Cadastrar Tarefa',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
