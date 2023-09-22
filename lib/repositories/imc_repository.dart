import 'package:calculadora_imc/models/imc.dart';


class ImcRepository {
  final List<Imc> _imcs = [];
  final List<int> _ids = [];

  Future<List<Imc>> adicionar(Imc imc) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _ids.add(imc.id);
    _imcs.add(imc);
    return _imcs;
  }

  Future<void>remove(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.remove(_imcs.where((imc) => imc.id == id).first);
  }

  Future<List<Imc>> listar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    /*final imcsPessoas = <Map<String, dynamic>>[];
    List<Pessoa> pessoas = await PessoaRepository().listar();

    for(final imc in _imcs) {
      final pessoa = pessoas.firstWhere((pessoa) => pessoa.id == imc.pessoaId);
      imcsPessoas.add(
        {
          "imcId": imc.id,
          "pessoaId": pessoa.id,
          "pessoaNome": pessoa.getNome(),
          "pessoaPeso": pessoa.peso,
          "imc": imc.imc,
        },
      );
    }*/
    return _imcs;
  }

  List<int> retornaIds(){
    return _ids;
  }

}
