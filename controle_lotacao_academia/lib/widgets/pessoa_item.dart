import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/pessoa.dart';

class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onSaida;
  final VoidCallback onExcluir;

  const PessoaItem({
    super.key,
    required this.pessoa,
    required this.onSaida,
    required this.onExcluir,
  });

  Future<void> confirmarSaida(BuildContext context) async {
    if (!pessoa.estaNoAmbiente) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Essa pessoa já saiu do ambiente.')),
      );

      return;
    }

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registrar saída?'),
          content: Text(
            'Deseja realmente registrar a saída de ${pessoa.nome}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCELAR'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('CONFIRMAR'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      onSaida();
    }
  }

  Future<void> confirmarExclusao(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir registro?'),
          content: Text(
            'Deseja realmente excluir o registro de ${pessoa.nome}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCELAR'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('EXCLUIR'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      onExcluir();
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatoData = DateFormat('dd/MM/yyyy HH:mm');

    return Slidable(
      key: ValueKey(
        '${pessoa.identificacao}-${pessoa.dataEntrada.millisecondsSinceEpoch}',
      ),

      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.55,
        children: [
          SlidableAction(
            onPressed: (_) {
              confirmarSaida(context);
            },
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            icon: Icons.logout,
            label: 'SAÍDA',
          ),

          SlidableAction(
            onPressed: (_) {
              confirmarExclusao(context);
            },
            backgroundColor: const Color(0xFFC62828),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'EXCLUIR',
          ),
        ],
      ),

      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, size: 28),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      pessoa.nome,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Icon(
                    pessoa.estaNoAmbiente
                        ? Icons.check_circle
                        : Icons.exit_to_app,
                    color: pessoa.estaNoAmbiente ? Colors.green : Colors.grey,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text('ID: ${pessoa.identificacao}'),

              const SizedBox(height: 4),

              Text('Entrada: ${formatoData.format(pessoa.dataEntrada)}'),

              if (pessoa.dataSaida != null) ...[
                const SizedBox(height: 4),
                Text('Saída: ${formatoData.format(pessoa.dataSaida!)}'),
              ],

              const SizedBox(height: 8),

              Text(
                pessoa.estaNoAmbiente
                    ? 'Situação: No ambiente'
                    : 'Situação: Saiu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: pessoa.estaNoAmbiente ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
