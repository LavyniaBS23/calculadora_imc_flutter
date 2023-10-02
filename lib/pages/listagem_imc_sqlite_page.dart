import 'package:calculadora_imc/pages/calcular_imc_sqlite_page.dart';
import 'package:calculadora_imc/repositories/sqlite/imc_sqlite_repository.dart';
import 'package:calculadora_imc/shared/widgets/dialogo.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_imc/utils/utils_double.dart' as util_double;

class ListagemImcSQLitePage extends StatefulWidget {
  const ListagemImcSQLitePage({Key? key}) : super(key: key);

  @override
  State<ListagemImcSQLitePage> createState() => _ListagemImcSQLitePageState();
}

class _ListagemImcSQLitePageState extends State<ListagemImcSQLitePage> {
  var lista = [];
  ImcSQLiteRepository imcRepository = ImcSQLiteRepository();
  @override
  void initState() {
    super.initState();
    getLista();
  }

  void removerImc(int idImc) {
    imcRepository.remover(idImc);
    getLista();
  }

  void getLista() async {
    var imcs = await imcRepository.obterDados();
    setState(() {
      lista = imcs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("IMCS Calculados"),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              showDialog(
                      context: context, 
                      builder: (BuildContext bc){
                        return const Dialogo();
                      });
              getLista();
            }),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var imc = lista[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        removerImc(imc['id']);
                      },
                      key: Key(imc['id'].toString()),
                      child: ListTile(
                        title: Text(imc['nome']),
                        trailing: Text(
                            util_double.duasCasasDecimais(imc['imc']).toString()),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
