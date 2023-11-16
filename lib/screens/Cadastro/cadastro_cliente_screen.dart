import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Login/login_screen.dart';

class CadastroClienteScreen extends StatefulWidget {
  const CadastroClienteScreen({Key? key});

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
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailClienteController.text,
        password: senhaClienteController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('Erro ao cadastrar cliente: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
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
