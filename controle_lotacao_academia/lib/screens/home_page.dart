import 'package:flutter/material.dart';

import '../models/pessoa.dart';
import '../widgets/pessoa_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController identificacaoController = TextEditingController();

  final List<Pessoa> pessoas = [];

  final int capacidadeMaxima = 50;

  int get pessoasNoAmbiente {
    return pessoas.where((pessoa) => pessoa.estaNoAmbiente).length;
  }

  void cadastrarPessoa() {
    final nome = nomeController.text.trim();
    final identificacao = identificacaoController.text.trim();

    if (nome.isEmpty || identificacao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios.')),
      );
      return;
    }

    if (pessoasNoAmbiente >= capacidadeMaxima) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não é possível realizar a entrada. Ambiente lotado!'),
        ),
      );
      return;
    }

    final identificacaoDuplicada = pessoas.any(
      (pessoa) =>
          pessoa.identificacao == identificacao && pessoa.estaNoAmbiente,
    );

    if (identificacaoDuplicada) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Já existe uma pessoa com essa identificação no ambiente.',
          ),
        ),
      );
      return;
    }

    final novaPessoa = Pessoa(
      nome: nome,
      identificacao: identificacao,
      dataEntrada: DateTime.now(),
    );

    setState(() {
      pessoas.add(novaPessoa);
    });

    nomeController.clear();
    identificacaoController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pessoa cadastrada com sucesso!')),
    );
  }

  void registrarSaida(Pessoa pessoa) {
    if (!pessoa.estaNoAmbiente) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Essa pessoa já saiu do ambiente.')),
      );
      return;
    }

    setState(() {
      pessoa.dataSaida = DateTime.now();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saída registrada com sucesso!')),
    );
  }

  void excluirPessoa(Pessoa pessoa) {
    setState(() {
      pessoas.remove(pessoa);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro excluído com sucesso!')),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    identificacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gym Capacity 2.0'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.fitness_center, size: 40),
                    const SizedBox(height: 8),
                    const Text(
                      'Pessoas na academia',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$pessoasNoAmbiente / $capacidadeMaxima',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: identificacaoController,
                decoration: const InputDecoration(
                  labelText: 'Matrícula / ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: cadastrarPessoa,
                  icon: const Icon(Icons.login),
                  label: const Text('Registrar entrada'),
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pessoas cadastradas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: pessoas.isEmpty
                    ? const Center(child: Text('Nenhuma pessoa cadastrada.'))
                    : ListView.builder(
                        itemCount: pessoas.length,
                        itemBuilder: (context, index) {
                          final pessoa = pessoas[index];

                          return PessoaItem(
                            pessoa: pessoa,
                            onSaida: () {
                              registrarSaida(pessoa);
                            },
                            onExcluir: () {
                              excluirPessoa(pessoa);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
