class Paciente {
  int _id;
  String _nome;
  String _email;
  String _cartao;
  int _idade;
  String _senha;
  String _foto;

  Paciente(
    this._id,
    this._nome,
    this._email,
    this._cartao,
    this._idade,
    this._senha,
    this._foto,
  );

  int get id {
    return this._id;
  }

  set id(int id) {
    this._id = id;
  }

  String get nome {
    return this._nome;
  }

  String get email {
    return this._email;
  }

  String get cartao {
    return this._cartao;
  }

  int get idade {
    return this._idade;
  }

  String get senha {
    return this._senha;
  }

  String get foto {
    return this._foto;
  }
}
