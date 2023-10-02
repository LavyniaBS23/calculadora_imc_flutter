import 'package:calculadora_imc/models/imc_sqlite_model.dart';
import 'package:calculadora_imc/models/pessoa_sqlite_model.dart';
import 'package:calculadora_imc/pages/main_sqlite_page.dart';
import 'package:calculadora_imc/repositories/sqlite/imc_sqlite_repository.dart';
import 'package:calculadora_imc/repositories/sqlite/pessoa_sqlite_repository.dart';
import 'package:calculadora_imc/service/imc_service.dart';
import 'package:calculadora_imc/shared/widgets/botao.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_imc/service/validators.dart';
import 'package:calculadora_imc/utils/utils_double.dart' as util_double;
import 'package:shared_preferences/shared_preferences.dart';

class CalcularImcSQLitePage extends StatefulWidget {
  final bool paraMim;
  final int pessoaId;

  const CalcularImcSQLitePage({
    Key? key,
    required this.paraMim,
    required this.pessoaId,
  }) : super(key: key);

  @override
  State<CalcularImcSQLitePage> createState() => _CalcularImcPageState();
}

class _CalcularImcPageState extends State<CalcularImcSQLitePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Validators validator = Validators();
  PessoaSQLiteRepository pessoaRepository = PessoaSQLiteRepository();
  final ImcService imcService = ImcService();
  final ImcSQLiteRepository imcSQLiteRepository = ImcSQLiteRepository();
  late PessoaSQLiteModel pessoa;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  double valorImc = 0;
  int idUsuario = 0;

  late SharedPreferences prefs;

  var resultado;

  @override
  void initState() {
    super.initState();
    pessoa = PessoaSQLiteModel(0, "", 0, 0);
    getDados();
  }

  void getDados() async {
    prefs = await SharedPreferences.getInstance();
    bool contem = prefs.containsKey('id_usuario');

    if (widget.paraMim == true && contem == true) {
      idUsuario = prefs.getInt('id_usuario')!;
    }
    if (widget.pessoaId > 0) {
      idUsuario = widget.pessoaId;
    }
    if (idUsuario != 0) {
      resultado = await pessoaRepository.getPessoa(idUsuario);
    }
    if (resultado != null) {
      pessoa = PessoaSQLiteModel(
          resultado['id'],
          resultado['nome'],
          double.parse(resultado['peso'].toString()),
          double.parse(resultado['altura'].toString()));
    }
    nomeController.text = pessoa.getNome();
    alturaController.text = pessoa.altura > 0 ? pessoa.altura.toString() : "";
    pesoController.text = pessoa.peso > 0 ? pessoa.peso.toString() : "";
    setState(() {});
  }

  Future<void> calculaImcEAddImcEPessoa() async {
    if (_formKey.currentState!.validate()) {
      final String nome = nomeController.text;
      final double? peso = util_double.parseDouble(pesoController.text);
      final double? altura = util_double.parseDouble(alturaController.text);

      if (peso != null && altura != null) {
        var idPessoa = 0;
        valorImc = imcService.calculaImc(peso, altura);
        pessoa.peso = peso;
        pessoa.altura = altura;
        pessoa.nome = nome;
        if (pessoa.id == 0) {
          idPessoa = await pessoaRepository.salvar(pessoa);
        }else{
          await pessoaRepository.atualizar(pessoa);
        }
        await imcSQLiteRepository.salvar(ImcSQLiteModel(0, idPessoa, valorImc));

        prefs.setInt('id_usuario', idPessoa);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calcular IMC"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: valorImc > 0 ? _buildResultado() : _buildFormulario(),
      ),
    );
  }

  Widget _buildResultado() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            '${pessoa.getNome()} seu IMC é: ${util_double.duasCasasDecimais(valorImc)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text('Classificação: ${imcService.classificacaoImc(valorImc)}'),
          const SizedBox(height: 50),
          Botao(
              texto: 'Voltar',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainSQLitePage(),
                  ),
                );
                setState(() {});
              }),
        ],
      ),
    );
  }

  Widget _buildFormulario() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Text(
            'Calculo de IMC',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Por favor, preencha as informações abaixo:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          _buildInput(
              'Nome', nomeController, 'nome_input_key', validator.validateNome),
          _buildInput(
            'Peso (kg)',
            pesoController,
            'peso_input_key',
            validator.validatePeso,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          _buildInput(
            'Altura (m)',
            alturaController,
            'altura_input_key',
            validator.validateAltura,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            height: 40,
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    calculaImcEAddImcEPessoa();
                  });
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Botao(
              texto: 'Cancelar',
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInput(
    String hintText,
    TextEditingController controller,
    String chave,
    String? Function(String?)? validator, {
    TextInputType? keyboardType,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 100),
      height: 50,
      alignment: Alignment.center,
      child: TextFormField(
        key: Key(chave),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.only(top: 25, bottom: 10),
        ),
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildBotaoVoltar() {
    return Botao(
        texto: 'Voltar',
        onPressed: () {
          pessoa = PessoaSQLiteModel.vazio();
          nomeController.text = "";
          pesoController.text = "";
          alturaController.text = "";
          valorImc = 0;
          setState(() {});
        });
  }
}
