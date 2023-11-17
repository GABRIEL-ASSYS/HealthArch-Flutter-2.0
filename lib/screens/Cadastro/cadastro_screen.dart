import 'package:flutter/material.dart';
import 'cadastro_cliente_screen.dart';
import 'cadastro_profissional_screen.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  CadastroScreenState createState() => CadastroScreenState();
}

class CadastroScreenState extends State<CadastroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CadastroClienteScreen()),
                );
              }, 
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue, 
                onPrimary: Colors.white, 
                textStyle: const TextStyle(fontSize: 25), 
              ),
              child: const Text('Cadastro Cliente'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CadastroProfissionalScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue, 
                onPrimary: Colors.white, 
                textStyle: const TextStyle(fontSize: 25), 
              ),
              child: const Text('Cadastro Profissional'),
            ),
          ],
        ),
      ),
    );
  }
}
