import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/models/pessoa.dart';
import 'package:calculadora_imc/repositories/pessoa_repository.dart';
import 'package:calculadora_imc/service/imc_service.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_imc/service/validators.dart';
import 'package:calculadora_imc/utils/utils_double.dart' as util_double;

class CalcularImcPage extends StatefulWidget {
  final Function(Imc) onIMCCalculated;
  final bool veioDaMain;

  const CalcularImcPage({
    Key? key,
    required this.onIMCCalculated,
    required this.veioDaMain,
  }) : super(key: key);

  @override
  State<CalcularImcPage> createState() => _CalcularImcPageState();
}

class _CalcularImcPageState extends State<CalcularImcPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController(text: "");
  final TextEditingController pesoController = TextEditingController(text: "");
  final TextEditingController alturaController = TextEditingController(text: "");
  final Validators validator = Validators();
  final PessoaRepository pessoaRepository = PessoaRepository();
  final ImcService imcService = ImcService();
  Pessoa? pessoa;
  double valorImc = 0.00;

  void calculaImcEAddImcEPessoa() async {
    if (_formKey.currentState!.validate()) {
      final String nome = nomeController.text;
      final double? peso = util_double.parseDouble(pesoController.text);
      final double? altura = util_double.parseDouble(alturaController.text);

      if (peso != null && altura != null) {
        pessoa = Pessoa(nome, peso, altura);
        await pessoaRepository.adicionar(pessoa!);
        valorImc = imcService.calculaImc(peso, altura);
        final Imc imc = Imc(pessoa!.id, valorImc, pessoa!.getNome());
        widget.onIMCCalculated(imc);
        setState(() {});
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
        child: pessoa != null
            ? _buildResultado()
            : _buildFormulario(),
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
            '${pessoa!.getNome()} seu IMC é: ${util_double.duasCasasDecimais(valorImc)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text('Classificação: ${imcService.classificacaoImc(valorImc)}'),
          const SizedBox(height: 50),
          _buildBotaoVoltar(),
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
          _buildInput('Nome', nomeController, 'nome_input_key', validator.validateNome),
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
          _buildBotao('Calcular', calculaImcEAddImcEPessoa),
          const SizedBox(height: 10),
          _buildBotao('Cancelar', () {
            Navigator.pop(context, widget.veioDaMain);
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

  Widget _buildBotao(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 100),
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

  Widget _buildBotaoVoltar() {
    return _buildBotao('Voltar', () {
      pessoa = null;
      nomeController.text = "";
      pesoController.text = "";
      alturaController.text = "";
      setState(() {});
    });
  }
}
