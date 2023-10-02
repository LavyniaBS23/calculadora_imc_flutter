import 'package:calculadora_imc/pages/calcular_imc_sqlite_page.dart';
import 'package:calculadora_imc/repositories/sqlite/pessoa_sqlite_repository.dart';
import 'package:flutter/material.dart';

class ListagemPessoaSQLitePage extends StatefulWidget {
  const ListagemPessoaSQLitePage({Key? key}) : super(key: key);

  @override
  State<ListagemPessoaSQLitePage> createState() =>
      _ListagemPessoaSQLitePageState();
}

class _ListagemPessoaSQLitePageState extends State<ListagemPessoaSQLitePage> {
  var lista = [];
  PessoaSQLiteRepository pessoaRepository = PessoaSQLiteRepository();
  @override
  void initState() {
    super.initState();
    getLista();
  }

  void removerImc(int idImc) {
    pessoaRepository.remover(idImc);
    getLista();
  }

  void getLista() async {
    lista = await pessoaRepository.obterDados();
    setState(() {});
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
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalcularImcSQLitePage(
                      paraMim: false,
                      pessoaId: 0,
                    ),
                  ));
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
                    var pessoa = lista[index];

                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        removerImc(pessoa.id);
                      },
                      key: Key(pessoa.id.toString()),
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalcularImcSQLitePage(
                                  paraMim: false,
                                  pessoaId: pessoa.id,
                                ),
                              ));
                        },
                        child: ListTile(
                          title: Text(pessoa.nome),
                        ),
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
