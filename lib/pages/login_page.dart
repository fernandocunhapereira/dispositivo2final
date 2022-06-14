import 'package:flutter/material.dart';
import 'package:un2projeto/utils/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userControllerEmail = TextEditingController();
  final _userControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _userControllerEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _userControllerPassword,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ]),
          const Divider(
            height: 20,
          ),
          LoginButton(
              userControllerEmail: _userControllerEmail,
              userControllerPassword: _userControllerPassword)
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required TextEditingController userControllerEmail,
    required TextEditingController userControllerPassword,
  })  : _userControllerEmail = userControllerEmail,
        _userControllerPassword = userControllerPassword,
        super(key: key);

  final TextEditingController _userControllerEmail;
  final TextEditingController _userControllerPassword;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if ( //_userControllerEmail.text == 'ipojuca@email.com.br' &&
              _userControllerPassword.text == '123') {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  padding: EdgeInsets.all(8.0),
                  content: Text('Usuário ou senha invalido!')),
            );
          }
        },
        child: const Text(
          'Entrar no App',
        ));
  }
}
