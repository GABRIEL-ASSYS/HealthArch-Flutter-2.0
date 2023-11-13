import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_arch/screens/Consultas/adicionar_consultas_screen.dart';

class ConsultasScreen extends StatefulWidget {
  const ConsultasScreen({Key? key}) : super(key: key);

  @override
  ConsultasScreenState createState() => ConsultasScreenState();
}

class ConsultasScreenState extends State<ConsultasScreen> {
  late List<Map<String, dynamic>> consultas;

  @override
  void initState() {
    super.initState();
    loadConsultas();
  }

  Future<void> loadConsultas() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('consultas').get();

      consultas = querySnapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data;
      }).toList();

      setState(() {});
    } catch (error) {
      print('Erro ao carregar consultas: $error');
    }
  }

  Future<void> excluirConsulta(String consultaId) async {
    try {
      // Implemente a lógica para excluir a consulta no Firestore.
      await FirebaseFirestore.instance
          .collection('consulta')
          .doc(consultaId)
          .delete();

      // Atualiza a lista de consultas após a exclusão.
      await loadConsultas();
    } catch (error) {
      print('Erro ao excluir consulta: $error');
    }
  }

  // Implemente a lógica para editar a consulta no Firestore.
  Future<void> editarConsulta(String consultaId) async {
    // Isso pode envolver a navegação para uma nova tela de edição ou a exibição de um modal de edição.
    // Lembre-se de passar a consultaId para a tela de edição, para que ela saiba qual consulta está sendo editada.
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
              const Text(
                'Consultas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
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
                          Text(
                              'Nome do Profissional: ${consulta['nomeProfissional']}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              excluirConsulta(consulta['id']);
                            },
                            child: const Text('Excluir'),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              editarConsulta(consulta['id']);
                            },
                            child: const Text('Editar'),
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
                    MaterialPageRoute(
                      builder: (context) => AdicionarConsultaScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
