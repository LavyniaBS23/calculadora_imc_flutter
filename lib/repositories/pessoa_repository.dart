import 'package:calculadora_imc/models/pessoa.dart';

class PessoaRepository{
  final List<Pessoa> _pessoas = [];
  final List<int> _ids = [];

  Future<List<Pessoa>> adicionar(Pessoa pessoa) async{
    await Future.delayed(const Duration(milliseconds: 100));
    _pessoas.add(pessoa);
    _ids.add(pessoa.id);
    return _pessoas;
  }

  List<int> retornaIds(){
    return _ids;
  }

  Future<List<Pessoa>> listar() async{
    await Future.delayed(const Duration(milliseconds: 100));
    return _pessoas;
  }
}