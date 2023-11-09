import 'package:flutter/material.dart';
import 'package:health_arch/screens/adicionar_consultas_screen.dart';

class ConsultasScreen extends StatelessWidget {
  @override
  _ConsultasScreenState createState() => _ConsultasScreenState();
}

class _ConsultasScreenState extends State<ConsultasScreen> {
  List<Map<String, dynamic>> consultas = [
    {
      'id': 1,
      'titulo': 'Consulta de Rotina',
      'descricao': 'Exame de rotina e verificação de saúde.',
      'horaData': '10/09/2023 09:00 AM',
      'nomeCliente': 'Maria Silva',
      'nomeProfissional': 'Dr. João'
    }
  ];

  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController horaDataController = TextEditingController();
  TextEditingController nomeClienteController = TextEditingController();
  TextEditingController nomeProfissionalController = TextEditingController();

  void adicionarConsulta() {
    setState(() {
      consultas.add({
        'id': consultas.length + 1,
        'titulo': tituloController.text,
        'descricao': descricaoController.text,
        'horaData': horaDataController.text,
        'nomeCliente': nomeClienteController.text,
        'nomeProfissional': nomeProfissionalController.text,
      });

      tituloController.clear();
      descricaoController.clear();
      horaDataController.clear();
      nomeClienteController.clear();
      nomeProfissionalController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Consultas',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: consultas.length,
                  itemBuilder: (context, index) {
                    final consulta = consultas[index];
                    return Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text('ID: ${consulta['id']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Título: ${consulta['titulo']}'),
                            Text('Descrição: ${consulta['descricao']}'),
                            Text('Data e Hora: ${consulta['horaData']}'),
                            Text('Nome do Cliente: ${consulta['nomeCliente']}'),
                            Text('Nome do Profissional: ${consulta['nomeProfissional']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  consultas.removeAt(index);
                                });
                              }, 
                              child: const Text('Excluir'),
                            ),
                            const SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () {}, 
                              child: const Text('Editar')
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => AdicionarConsultaScreen()),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}