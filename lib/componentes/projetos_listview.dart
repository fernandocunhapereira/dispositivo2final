import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controller/projetocontroller.dart';
import '../utils/app_routes.dart';

class ProjetosListView extends StatefulWidget {
  const ProjetosListView({Key? key}) : super(key: key);

  @override
  State<ProjetosListView> createState() => _ProjetosListViewState();
}

class _ProjetosListViewState extends State<ProjetosListView> {
  @override
  void initState() {
    super.initState();
    final _controller = Provider.of<ProjetoController>(context, listen: false);
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<ProjetoController>(context);
    //final _controller = context.watch<UsuarioController>();

    // switch (_controller.state.value) {
    //   case ProjetoState.error:
    //     return const Center(child: Text('Erro não carregou'));
    //   case ProjetoState.loading:
    //     return const Center(child: Text('loading não carregou'));
    //   case ProjetoState.start:
    //     return const Center(child: Text('start não carregou'));
    //   default:
    // }
    return ListView.separated(
      itemCount: _controller.projetos.length,
      itemBuilder: (context, index) {
        final projeto = _controller.projetos[index]; //_projetoLista[index];
        return ListTile(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.PROJETO_DETALHE,
                arguments: projeto);
          },
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromARGB(255, 238, 229, 248), width: 1),
              borderRadius: BorderRadius.circular(5)),
          tileColor: const Color.fromARGB(255, 238, 229, 248),
          trailing: SizedBox(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.PROJETO_CADASTRO,
                          arguments: projeto);
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.orange,
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.deleteProjeto(projeto);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              )),
          title: Text(
            projeto.titulo,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                projeto.descricao,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: projeto.prazo.day >= DateTime.now().day
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primary),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  DateFormat('dd/MMM/yyyy').format(projeto.prazo),
                  style: TextStyle(
                      color: projeto.prazo.day >= DateTime.now().day
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 10,
        );
      },
    );
  }
}
