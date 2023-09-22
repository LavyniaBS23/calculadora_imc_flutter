import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/pages/calcular_imc_page.dart';
import 'package:calculadora_imc/pages/listagem.dart';
import 'package:calculadora_imc/repositories/imc_repository.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ImcRepository imcRepository = ImcRepository();
  var listaImcs = <Imc>[];

  @override
  void initState() {
    super.initState();
    getLista();
  }

  void adicionaIMC(Imc novoIMC) async {
    await imcRepository.adicionar(novoIMC);
    getLista();
  }

  void getLista() async {
    listaImcs = await imcRepository.listar();
  }

  void removeIMC(idImc) async {
    await imcRepository.remove(idImc);
    listaImcs = await imcRepository.listar();
  }

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
                _buildButton("Novo Calculo", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalcularImcPage(
                        onIMCCalculated: (Imc novoIMC) {
                          adicionaIMC(novoIMC);
                        },
                        veioDaMain: true,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                _buildButton("Lista", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListagemPage(
                        imcToRemove: (idImc) {
                          removeIMC(idImc);
                        },
                        listaImcs: listaImcs,
                        onIMCCalculated: (novoIMC) {
                          adicionaIMC(novoIMC);
                        },
                        imcRepository: imcRepository,
                      ),
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

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      height: 30,
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
