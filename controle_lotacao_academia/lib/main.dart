import 'package:flutter/material.dart';
import 'models/ambiente.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Capacity',
      theme: ThemeData(useMaterial3: true),
      home: const TelaLotacao(),
    );
  }
}

class TelaLotacao extends StatefulWidget {
  const TelaLotacao({super.key});

  @override
  State<TelaLotacao> createState() => _TelaLotacaoState();
}

class _TelaLotacaoState extends State<TelaLotacao> {
  final Ambiente academia = Ambiente.academia(
    nome: 'Academia FIAP',
    capacidadeMaxima: 50,
  );

  void entrar() {
    setState(() {
      academia.entrou();
    });
  }

  void sair() {
    setState(() {
      academia.saiu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Gym Capacity'),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              academia.nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Pessoas na academia',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              '${academia.quantidadePessoas}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Capacidade máxima: ${academia.capacidadeMaxima}',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 30),

            Text(
              academia.situacao,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: sair,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('SAIU'),
                ),

                const SizedBox(width: 20),

                TextButton(
                  onPressed: entrar,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('ENTROU'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
