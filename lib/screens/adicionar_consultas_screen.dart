import 'package:flutter/material.dart';

class AdicionarConsultaScreen extends StatefulWidget {
  @override
  _AdicionarConsultasScreenState createState() => _AdicionarConsultasScreenState();
}

class _AdicionarConsultasScreenState extends State<AdicionarConsultaScreen> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController horaDataController = TextEditingController();
  TextEditingController nomeClienteController = TextEditingController();
  TextEditingController nomeProfissionalController = TextEditingController();

  void adicionarConsulta {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Consulta'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: const Text(
                    'Adicionar Consulta:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: tituloController,
                          decoration: const InputDecoration(labelText: 'Título'),
                        ),
                        TextFormField(
                          controller: descricaoController,
                          decoration: const InputDecoration(labelText: 'Descrição'),
                        ),
                        TextFormField(
                          controller: horaDataController,
                          decoration: const InputDecoration(labelText: 'Data e Hora'),
                        ),
                        TextFormField(
                          controller: nomeClienteController,
                          decoration: const InputDecoration(labelText: 'Nome do Cliente'),
                        ),
                        TextFormField(
                          controller: nomeProfissionalController,
                          decoration: const InputDecoration(labelText: 'Nome do Profissional'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: adicionarConsulta, 
                      child: const Text('Cadastrar'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}