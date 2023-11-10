import 'package:flutter/material.dart';

class CadastroProfissionalScreen extends StatefulWidget {
  const CadastroProfissionalScreen({super.key});
  
  @override
  CadastroProfissionalScreenState createState() => CadastroProfissionalScreenState();
}

class CadastroProfissionalScreenState extends State<CadastroProfissionalScreen> {
  TextEditingController nomeProfissionalController = TextEditingController();
  TextEditingController emailProfissionalController = TextEditingController();
  TextEditingController senhaProfissionalController = TextEditingController();
  TextEditingController cepProfissionalController = TextEditingController();
  TextEditingController ruaProfissionalController = TextEditingController();
  TextEditingController numeroProfissionalController = TextEditingController();
  TextEditingController cidadeProfissionalController = TextEditingController();
  TextEditingController codigoProfissionalClienteController = TextEditingController();

  void adicionarCliente {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Profissional'),
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
                        controller: nomeProfissionalController,
                        decoration: const InputDecoration(labelText: 'Nome:'),
                      ),
                      TextFormField(
                        controller: emailProfissionalController,
                        decoration: const InputDecoration(labelText: 'Email:'),
                      ),
                      TextFormField(
                        controller: senhaProfissionalController,
                        decoration: const InputDecoration(labelText: 'Senha:'),
                      ),
                      TextFormField(
                        controller: cepProfissionalController,
                        decoration: const InputDecoration(labelText: 'CEP do Consultório:'),
                      ),
                      TextFormField(
                        controller: ruaProfissionalController,
                        decoration: const InputDecoration(labelText: 'Rua do Consultório:'),
                      ),
                      TextFormField(
                        controller: numeroProfissionalController,
                        decoration: const InputDecoration(labelText: 'Número do Consultório:'),
                      ),
                      TextFormField(
                        controller: cidadeProfissionalController,
                        decoration: const InputDecoration(labelText: 'Cidade do Consultório:'),
                      ),
                      TextFormField(
                        controller: codigoProfissionalClienteController,
                        decoration: const InputDecoration(labelText: 'Código Profissional:'),
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