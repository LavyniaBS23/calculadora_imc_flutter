class ImcSQLiteModel {
  int _id = 0;
  int _pessoaId = 0;
  double _imc = 0;

  ImcSQLiteModel(this._id, this._pessoaId, this._imc);

  int get id => _id;

  int get pessoaId => _pessoaId;

  double get imc => _imc;

  set pessoaId(pessoaId) {
    _pessoaId = pessoaId;
  }

  set imc(imc) {
    _imc = imc;
  }

}