import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EditarConsultaScreen extends StatefulWidget {
  final String consultaId;

  const EditarConsultaScreen({Key? key, required this.consultaId}) : super(key: key);

  @override
  _EditarConsultaScreenState createState() => _EditarConsultaScreenState();
}

class _EditarConsultaScreenState extends State<EditarConsultaScreen> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController horaDataController = TextEditingController();
  TextEditingController nomeClienteController = TextEditingController();
  TextEditingController nomeProfissionalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadConsultaExistente();
  }

  Future<void> loadConsultaExistente() async {
    try {
      DocumentSnapshot consultaSnapshot = await FirebaseFirestore.instance
          .collection('consulta')
          .doc(widget.consultaId)
          .get();

      Map<String, dynamic> consultaData = consultaSnapshot.data() as Map<String, dynamic>;

      tituloController.text = consultaData['titulo'];
      descricaoController.text = consultaData['descricao'];
      horaDataController.text = DateFormat('yyyy-MM-dd HH:mm').format(
        (consultaData['horaData'] as Timestamp).toDate(),
      );
      nomeClienteController.text = consultaData['nomeCliente'];
      nomeProfissionalController.text = consultaData['nomeProfissional'];
    } catch (error) {
      print('Erro ao carregar consulta existente: $error');
    }
  }

  Future<void> editarConsultaExistente() async {
    try {
      DateTime dataHora = DateTime.parse(horaDataController.text);
      Timestamp timestamp = Timestamp.fromDate(dataHora);

      await FirebaseFirestore.instance
          .collection('consulta')
          .doc(widget.consultaId)
          .update({
        'titulo': tituloController.text,
        'descricao': descricaoController.text,
        'horaData': timestamp,
        'nomeCliente': nomeClienteController.text,
        'nomeProfissional': nomeProfissionalController.text,
      });

      print('Consulta editada com sucesso!');
    } catch (error) {
      print('Erro ao editar consulta: $error');
    }
  }

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
      print('Erro ao selecionar data e hora: $error');
    }
  }

  Future<void> enviarConsulta() async {
    try {
      DateTime dataHora = DateTime.parse(horaDataController.text);
      Timestamp timestamp = Timestamp.fromDate(dataHora);

      await FirebaseFirestore.instance.collection('consulta').add({
        'titulo': tituloController.text,
        'descricao': descricaoController.text,
        'horaData': timestamp,
        'nomeCliente': nomeClienteController.text,
        'nomeProfissional': nomeProfissionalController.text,
      });

      print('Consulta adicionada com sucesso!');
    } catch (error) {
      print('Erro ao adicionar consulta: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Consulta'),
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
                    'Editar Consulta:',
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
                      ),
                      TextFormField(
                        controller: descricaoController,
                        decoration: const InputDecoration(labelText: 'Descrição:'),
                      ),
                      TextFormField(
                        controller: horaDataController,
                        decoration: const InputDecoration(labelText: 'Data e Hora:'),
                        onTap: adicionarConsulta,
                      ),
                      TextFormField(
                        controller: nomeClienteController,
                        decoration: const InputDecoration(labelText: 'Nome do Cliente:'),
                      ),
                      TextFormField(
                        controller: nomeProfissionalController,
                        decoration: const InputDecoration(labelText: 'Nome do Profissional:'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: editarConsultaExistente,
                    child: const Text('Salvar Edições'),
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
