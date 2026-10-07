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
        motion: const ScrollMotion(),
        extentRatio: 0.55,
        children: [
          CustomSlidableAction(
            onPressed: (_) {
              confirmarSaida(context);
            },
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout),
                SizedBox(height: 4),
                Text('SAÍDA'),
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (_) {
              confirmarExclusao(context);
            },
            backgroundColor: const Color(0xFFC62828),
            foregroundColor: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete),
                SizedBox(height: 4),
                Text('EXCLUIR'),
              ],
            ),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF171717),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2A2A2A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person, color: Color(0xFFE53935)),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    pessoa.nome,
                    style: const TextStyle(
                      fontSize: 17,
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
                    color: pessoa.estaNoAmbiente
                        ? const Color(0xFF1B5E20)
                        : const Color(0xFF424242),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    pessoa.estaNoAmbiente ? 'No ambiente' : 'Saiu',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                const Icon(
                  Icons.badge_outlined,
                  size: 18,
                  color: Color(0xFF9E9E9E),
                ),
                const SizedBox(width: 6),
                Text(
                  'ID: ${pessoa.identificacao}',
                  style: const TextStyle(color: Color(0xFFBDBDBD)),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.login, size: 18, color: Color(0xFF9E9E9E)),
                const SizedBox(width: 6),
                Text(
                  'Entrada: ${formatoData.format(pessoa.dataEntrada)}',
                  style: const TextStyle(color: Color(0xFFBDBDBD)),
                ),
              ],
            ),

            if (pessoa.dataSaida != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.logout, size: 18, color: Color(0xFF9E9E9E)),
                  const SizedBox(width: 6),
                  Text(
                    'Saída: ${formatoData.format(pessoa.dataSaida!)}',
                    style: const TextStyle(color: Color(0xFFBDBDBD)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
