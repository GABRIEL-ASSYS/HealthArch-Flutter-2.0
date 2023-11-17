import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'consultas_screen.dart';

class AdicionarConsultaScreen extends StatefulWidget {
  const AdicionarConsultaScreen({Key? key}) : super(key: key);

  @override
  AdicionarConsultasScreenState createState() => AdicionarConsultasScreenState();
}

class AdicionarConsultasScreenState extends State<AdicionarConsultaScreen> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController horaDataController = TextEditingController();
  TextEditingController nomeClienteController = TextEditingController();
  TextEditingController nomeProfissionalController = TextEditingController();

  Future<void> adicionarConsulta() async {
    try {
      DateTime? dataSelecionada = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (dataSelecionada != null) {
        TimeOfDay? horaSelecionada = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (horaSelecionada != null) {
          DateTime dataHoraSelecionada = DateTime(
            dataSelecionada.year,
            dataSelecionada.month,
            dataSelecionada.day,
            horaSelecionada.hour,
            horaSelecionada.minute,
          );

          horaDataController.text = DateFormat('yyyy-MM-dd HH:mm').format(dataHoraSelecionada);
        }
      }
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao selecionar data e hora: $error');
    }
  }

  Future<void> enviarConsulta() async {
    try {
      DateTime dataHora = DateTime.parse(horaDataController.text);
      Timestamp timestamp = Timestamp.fromDate(dataHora);

      DocumentReference consultaRef = await FirebaseFirestore.instance.collection('consultas').add({
        'titulo': tituloController.text,
        'descricao': descricaoController.text,
        'horaData': timestamp,
        'nomeCliente': nomeClienteController.text,
        'nomeProfissional': nomeProfissionalController.text,
      });

      String consultaId = consultaRef.id;

      await consultaRef.update({'id': consultaId});

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ConsultasScreen(),
        ),
      );
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao adicionar consulta: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text(
          'Adicionar Consulta',
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
                    'Adicionar Consulta:',
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
                        controller: tituloController,
                        decoration: const InputDecoration(labelText: 'Título:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: descricaoController,
                        decoration: const InputDecoration(labelText: 'Descrição:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: horaDataController,
                        decoration: const InputDecoration(labelText: 'Data e Hora:'),
                        style: const TextStyle(fontSize: 20),
                        onTap: adicionarConsulta,
                      ),
                      TextFormField(
                        controller: nomeClienteController,
                        decoration: const InputDecoration(labelText: 'Nome do Cliente:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        controller: nomeProfissionalController,
                        decoration: const InputDecoration(labelText: 'Nome do Profissional:'),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: enviarConsulta,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue, 
                      onPrimary: Colors.white, 
                      textStyle: const TextStyle(fontSize: 25), 
                    ),
                    child: const Text('Cadastrar'),
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
