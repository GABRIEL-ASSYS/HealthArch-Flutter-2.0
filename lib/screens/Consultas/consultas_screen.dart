import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_arch/screens/Consultas/adicionar_consultas_screen.dart';
import 'package:health_arch/screens/Consultas/editar_consultas_screen.dart';

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
  // Restante do seu código para excluir e editar consultas...

  Future<void> excluirConsulta(String consultaId) async {
    try {
      await FirebaseFirestore.instance
          .collection(tipoUsuario == 'cliente' ? 'consultas_clientes' : 'consultas_profissionais')
          .doc(consultaId)
          .delete();

      await loadConsultas();
    } catch (error) {
      print('Erro ao excluir consulta: $error');
    }
  }

  Future<void> editarConsulta(String consultaId) async {
    try {
      // Verifique o tipo de usuário antes de permitir a edição
      if (tipoUsuario == 'profissional') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditarConsultaScreen(consultaId: consultaId),
          ),
        );
      } else {
        // Se não for um profissional, exiba um alerta
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Acesso Negado'),
              content: const Text('Apenas profissionais podem editar consultas.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Erro ao editar consulta: $error');
    }
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
                            // Desabilita o botão se o usuário não for um profissional
                            style: tipoUsuario != 'profissional'
                                ? ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              editarConsulta(consulta['id']);
                            },
                            child: const Text('Editar'),
                            // Desabilita o botão se o usuário não for um profissional
                            style: tipoUsuario != 'profissional'
                                ? ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                                  )
                                : null,
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
                  // Verifique o tipo de usuário antes de permitir a adição
                  if (tipoUsuario == 'profissional') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdicionarConsultaScreen(),
                      ),
                    );
                  } else {
                    // Se não for um profissional, exiba um alerta
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Acesso Negado'),
                          content: const Text('Apenas profissionais podem adicionar consultas.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
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
