import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_arch/screens/Consultas/adicionar_consultas_screen.dart';
import 'package:health_arch/screens/Consultas/editar_consultas_screen.dart';
import 'package:intl/intl.dart';

class ConsultasScreen extends StatefulWidget {
  const ConsultasScreen({Key? key}) : super(key: key);

  @override
  ConsultasScreenState createState() => ConsultasScreenState();
}

class ConsultasScreenState extends State<ConsultasScreen> {
  late Future<List<Map<String, dynamic>>> consultasFuture;

  @override
  void initState() {
    super.initState();
    consultasFuture = loadConsultas();
  }

  Future<List<Map<String, dynamic>>> loadConsultas() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('consultas').get();

      List<Map<String, dynamic>> consultas = querySnapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data;
      }).toList();

      consultas.sort((a, b) => a['horaData'].compareTo(b['horaData']));

      return consultas;
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao carregar consultas: $error');
      rethrow;
    }
  }

  Future<void> excluirConsulta(String consultaId) async {
    try {
      await FirebaseFirestore.instance
          .collection('consultas')
          .doc(consultaId)
          .delete();
          
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao excluir consulta: $error');
    }
  }

  Future<void> editarConsulta(String consultaId) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditarConsultaScreen(consultaId: consultaId),
        ),
      );
    } catch (error) {
      // ignore: avoid_print
      print('Erro ao editar consulta: $error');
    }
  }

  Future<void> refreshConsultas() async {
    setState(() {
      consultasFuture = loadConsultas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consultas',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              refreshConsultas();
            }, 
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: consultasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> consultas = snapshot.data as List<Map<String, dynamic>>;

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Consultas',
                      style: TextStyle(
                        fontSize: 25,
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
                            title: Text(
                              'ID: ${consulta['id']}',
                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Título: ${consulta['titulo']}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Descrição: ${consulta['descricao']}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Data e Hora: ${DateFormat('dd/MM/yyyy HH:mm').format(consulta['horaData'].toDate())}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Nome do Cliente: ${consulta['nomeCliente']}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Nome do Profissional: ${consulta['nomeProfissional']}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    excluirConsulta(consulta['id']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlue,
                                    onPrimary: Colors.white,
                                    textStyle: const TextStyle(fontSize: 25),
                                  ),
                                  child: const Text('Excluir'),
                                ),
                                const SizedBox(width: 8.0),
                                ElevatedButton(
                                  onPressed: () {
                                    editarConsulta(consulta['id']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlue,
                                    onPrimary: Colors.white,
                                    textStyle: const TextStyle(fontSize: 25),
                                  ),
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
                      child: const Icon(Icons.add, color: Colors.white,),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
