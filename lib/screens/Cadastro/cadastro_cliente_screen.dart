import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Login/login_screen.dart';

class CadastroClienteScreen extends StatefulWidget {
  const CadastroClienteScreen({Key? key}) : super(key: key);

  @override
  CadastroClienteScreenState createState() => CadastroClienteScreenState();
}

class CadastroClienteScreenState extends State<CadastroClienteScreen> {
  TextEditingController nomeClienteController = TextEditingController();
  TextEditingController emailClienteController = TextEditingController();
  TextEditingController senhaClienteController = TextEditingController();
  TextEditingController cepClienteController = TextEditingController();
  TextEditingController ruaClienteController = TextEditingController();
  TextEditingController numeroClienteController = TextEditingController();
  TextEditingController cidadeClienteController = TextEditingController();

  Future<void> adicionarCliente() async {
    final navigator = Navigator.of(context);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailClienteController.text,
        password: senhaClienteController.text,
      );

      navigator.pushReplacement(_createRoute(const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print('Erro ao cadastrar cliente: $e');
    }
  }

  Route _createRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text(
          'Cadastro Cliente',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Text(
                    'Cadastro',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nomeClienteController,
                        decoration: const InputDecoration(labelText: 'Nome:'),
                      ),
                      TextFormField(
                        controller: emailClienteController,
                        decoration: const InputDecoration(labelText: 'Email:'),
                      ),
                      TextFormField(
                        controller: senhaClienteController,
                        decoration: const InputDecoration(labelText: 'Senha:'),
                      ),
                      TextFormField(
                        controller: cepClienteController,
                        decoration: const InputDecoration(labelText: 'CEP:'),
                      ),
                      TextFormField(
                        controller: ruaClienteController,
                        decoration: const InputDecoration(labelText: 'Rua'),
                      ),
                      TextFormField(
                        controller: numeroClienteController,
                        decoration: const InputDecoration(labelText: 'Número:'),
                      ),
                      TextFormField(
                        controller: cidadeClienteController,
                        decoration: const InputDecoration(labelText: 'Cidade:'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: adicionarCliente,
                    child: const Text('Cadastrar'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
