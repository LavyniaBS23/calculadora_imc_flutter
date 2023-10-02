import 'package:calculadora_imc/pages/calcular_imc_sqlite_page.dart';
import 'package:calculadora_imc/pages/listagem_pessoa_sqlite_page.dart';
import 'package:calculadora_imc/shared/widgets/botao.dart';
import 'package:flutter/material.dart';

class Dialogo extends StatelessWidget {
  const Dialogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Calculo de Imc"),
      content: const Text('Para quem você deseja calcular o imc?'),
      actions: [
        Botao(
            texto: "Para mim",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalcularImcSQLitePage(
                    paraMim: true,
                    pessoaId: 0,
                  ),
                ),
              );
            }),
        const SizedBox(height: 10),
        Botao(
            texto: "Outra pessoa",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListagemPessoaSQLitePage(),
                ),
              );
            }),
      ],
    );
  }
}
