import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/pages/calcular_imc_page.dart';
import 'package:calculadora_imc/repositories/imc_repository.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_imc/utils/utils_double.dart' as util_double;

class ListagemPage extends StatefulWidget {
  final Function(int) imcToRemove;
  final Function(Imc) onIMCCalculated;

  final List<Imc> listaImcs;
  final ImcRepository imcRepository;
  const ListagemPage(
      {Key? key,
      required this.listaImcs,
      required this.imcToRemove,
      required this.onIMCCalculated,
      required this.imcRepository})
      : super(key: key);

  @override
  State<ListagemPage> createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  var lista = [];
  @override
  void initState() {
    super.initState();
    atualizaLista();
  }

  void removerImc(int idImc) {
    widget.imcToRemove(idImc);
  }

  void atualizaLista() async{
    lista = await widget.imcRepository.listar();
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
              var veioDaMain = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalcularImcPage(
                      onIMCCalculated: (Imc imc) {
                        widget.onIMCCalculated(imc);
                      },
                      veioDaMain: false,
                    ),
                    settings: RouteSettings(arguments: widget.listaImcs),
                  ));
                  if(!veioDaMain){
                    atualizaLista();
                  }
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
                        removerImc(imc.id);
                      },
                      key: Key(imc.id.toString()),
                      child: ListTile(
                        title: Text(imc.nome),
                        trailing: Text(util_double.duasCasasDecimais(imc.imc).toString()),
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
