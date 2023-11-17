import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Login/login_screen.dart';

class CadastroProfissionalScreen extends StatefulWidget {
  const CadastroProfissionalScreen({super.key});

  @override
  CadastroProfissionalScreenState createState() =>
      CadastroProfissionalScreenState();
}

class CadastroProfissionalScreenState
    extends State<CadastroProfissionalScreen> {
  TextEditingController nomeProfissionalController = TextEditingController();
  TextEditingController emailProfissionalController = TextEditingController();
  TextEditingController senhaProfissionalController = TextEditingController();
  TextEditingController cepProfissionalController = TextEditingController();
  TextEditingController ruaProfissionalController = TextEditingController();
  TextEditingController numeroProfissionalController = TextEditingController();
  TextEditingController cidadeProfissionalController = TextEditingController();
  TextEditingController codigoProfissionalController = TextEditingController();

  Future<void> adicionarProfissional() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailProfissionalController.text,
        password: senhaProfissionalController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        String userID = user.uid;

        await FirebaseFirestore.instance
            .collection('usuarioProfissional')
            .doc(userID)
            .set({
          'nome': nomeProfissionalController.text,
          'email': emailProfissionalController.text,
          'cep': cepProfissionalController.text,
          'cidade': cidadeProfissionalController.text,
          'codigo': codigoProfissionalController.text,
          'numero': numeroProfissionalController.text,
          'rua': ruaProfissionalController.text,
          'senha': senhaProfissionalController.text,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print('Erro ao cadastrar profissional: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro Profissional',
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
                        controller: nomeProfissionalController,
                        decoration: const InputDecoration(labelText: 'Nome:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: emailProfissionalController,
                        decoration: const InputDecoration(labelText: 'Email:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: senhaProfissionalController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Senha:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: cepProfissionalController,
                        decoration: const InputDecoration(
                            labelText: 'CEP do Consultório:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: ruaProfissionalController,
                        decoration: const InputDecoration(
                            labelText: 'Rua do Consultório:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: numeroProfissionalController,
                        decoration: const InputDecoration(
                            labelText: 'Número do Consultório:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: cidadeProfissionalController,
                        decoration: const InputDecoration(
                            labelText: 'Cidade do Consultório:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: codigoProfissionalController,
                        decoration: const InputDecoration(
                            labelText: 'Código Profissional:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: adicionarProfissional,
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
