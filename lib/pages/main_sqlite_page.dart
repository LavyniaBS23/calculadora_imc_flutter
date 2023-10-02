import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/pages/calcular_imc_page.dart';
import 'package:calculadora_imc/pages/calcular_imc_sqlite_page.dart';
import 'package:calculadora_imc/pages/listagem.dart';
import 'package:calculadora_imc/pages/listagem_imc_sqlite_page.dart';
import 'package:calculadora_imc/repositories/imc_repository.dart';
import 'package:calculadora_imc/repositories/sqlite/imc_sqlite_repository.dart';
import 'package:calculadora_imc/shared/widgets/botao.dart';
import 'package:calculadora_imc/shared/widgets/dialogo.dart';
import 'package:flutter/material.dart';

class MainSQLitePage extends StatefulWidget {
  const MainSQLitePage({Key? key}) : super(key: key);

  @override
  State<MainSQLitePage> createState() => _MainSQLiteState();
}

class _MainSQLiteState extends State<MainSQLitePage> {
  final ImcSQLiteRepository imcRepository = ImcSQLiteRepository();
 // var listaImcs = [];
  bool dialogo = false;

  @override
  void initState() {
    super.initState();
    //getLista();
  }

  /*void adicionaIMC(Imc novoIMC) async {
    await imcRepository.adicionar(novoIMC);
    getLista();
  }*/

  /*void getLista() async {
    listaImcs = await imcRepository.obterDados();
  }*/

  /*void removeIMC(idImc) async {
    await imcRepository.remove(idImc);
    listaImcs = await imcRepository.listar();
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset('lib/images/escala-de-peso.png'),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 20),
                Botao(texto: "Novo Calculo", onPressed: () {
                  
                    showDialog(
                      context: context, 
                      builder: (BuildContext bc){
                        return const Dialogo();
                      });
                  
                }),
                const SizedBox(height: 10),
                Botao(texto: "Lista", onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListagemImcSQLitePage(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
 
}
