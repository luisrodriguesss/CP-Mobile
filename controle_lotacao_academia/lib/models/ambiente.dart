class Ambiente {
  final String nome;
  final int capacidadeMaxima;
  int _quantidadePessoas;

  Ambiente.academia({
    required this.nome,
    required this.capacidadeMaxima,
    int quantidadeInicial = 0,
  }) : _quantidadePessoas = quantidadeInicial;

  int get quantidadePessoas => _quantidadePessoas;

  set quantidadePessoas(int valor) {
    if (valor >= 0 && valor <= capacidadeMaxima) {
      _quantidadePessoas = valor;
    }
  }

  bool get estaLotado => _quantidadePessoas == capacidadeMaxima;

  bool get quaseLotado {
    return _quantidadePessoas >= capacidadeMaxima * 0.8 &&
        _quantidadePessoas < capacidadeMaxima;
  }

  String get situacao {
    if (estaLotado) {
      return 'Academia lotada';
    }

    if (quaseLotado) {
      return 'Atenção: academia quase cheia';
    }

    return 'Pode entrar';
  }

  void entrou() {
    if (_quantidadePessoas < capacidadeMaxima) {
      _quantidadePessoas++;
    }
  }

  void saiu() {
    if (_quantidadePessoas > 0) {
      _quantidadePessoas--;
    }
  }
}
