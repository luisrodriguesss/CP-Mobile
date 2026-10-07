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
    final double percentual = pessoasNoAmbiente / capacidadeMaxima;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Gym Capacity 2.0',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFF2B2B2B)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        size: 30,
                        color: Color(0xFFE53935),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Pessoas na academia',
                      style: TextStyle(fontSize: 16, color: Color(0xFFBDBDBD)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$pessoasNoAmbiente / $capacidadeMaxima',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: percentual,
                        minHeight: 8,
                        backgroundColor: const Color(0xFF2C2C2C),
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xFFE53935),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite o nome da pessoa',
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: const Color(0xFF171717),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: identificacaoController,
                decoration: InputDecoration(
                  labelText: 'Matrícula / ID',
                  hintText: 'Digite a identificação',
                  prefixIcon: const Icon(Icons.badge_outlined),
                  filled: true,
                  fillColor: const Color(0xFF171717),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: cadastrarPessoa,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.login),
                  label: const Text(
                    'Registrar entrada',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pessoas cadastradas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1D1D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${pessoas.length} registros',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: pessoas.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 48,
                              color: Color(0xFF666666),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Nenhuma pessoa cadastrada.',
                              style: TextStyle(color: Color(0xFF9E9E9E)),
                            ),
                          ],
                        ),
                      )
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
