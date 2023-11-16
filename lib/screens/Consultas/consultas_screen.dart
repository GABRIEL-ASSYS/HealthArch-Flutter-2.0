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
      // ignore: avoid_print
      print('Erro ao carregar consultas: $error');
    }
  }

  Future<void> excluirConsulta(String consultaId) async {
    try {
      await FirebaseFirestore.instance
          .collection('consultas')
          .doc(consultaId)
          .delete();

      await loadConsultas();
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao excluir consulta: $error');
    }
  }

  Future<void> editarConsulta(String consultaId) async {
    try {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              EditarConsultaScreen(consultaId: consultaId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var opacityAnimation = animation.drive(tween);

            return FadeTransition(
              opacity: opacityAnimation,
              child: child,
            );
          },
        ),
      );
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao editar consulta: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text(
          'HealthArch',
          style: TextStyle(color: Colors.white),
        ),
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
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AdicionarConsultaScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var opacityAnimation = animation.drive(tween);

                        return FadeTransition(
                          opacity: opacityAnimation,
                          child: child,
                        );
                      },
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
