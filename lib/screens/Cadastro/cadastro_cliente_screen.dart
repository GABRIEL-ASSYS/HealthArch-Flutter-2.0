import 'package:cloud_firestore/cloud_firestore.dart';
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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailClienteController.text,
        password: senhaClienteController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        String userID = user.uid;

        await FirebaseFirestore.instance.collection('usuarioCliente').doc(userID).set({
          'nome': nomeClienteController.text,
          'email': emailClienteController.text,
          'cep': cepClienteController.text,
          'rua': ruaClienteController.text,
          'numero': numeroClienteController.text,
          'cidade': cidadeClienteController.text,
          'senha': senhaClienteController.text,
        });

        navigator.pushReplacement(_createRoute(const LoginScreen()));
      }
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

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
                      fontSize: 25,
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
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: emailClienteController,
                        decoration: const InputDecoration(labelText: 'Email:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: senhaClienteController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Senha:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: cepClienteController,
                        decoration: const InputDecoration(labelText: 'CEP:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: ruaClienteController,
                        decoration: const InputDecoration(labelText: 'Rua'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: numeroClienteController,
                        decoration: const InputDecoration(labelText: 'Número:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: cidadeClienteController,
                        decoration: const InputDecoration(labelText: 'Cidade:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: adicionarCliente,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.white,
                      textStyle: const TextStyle(fontSize: 25),
                    ),
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
