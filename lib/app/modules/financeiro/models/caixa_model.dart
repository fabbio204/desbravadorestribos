import 'dart:convert';

class CaixaModel {
  String nome;
  String saldo;
  CaixaModel({
    required this.nome,
    required this.saldo,
  });

  CaixaModel copyWith({
    String? nome,
    String? saldo,
  }) {
    return CaixaModel(
      nome: nome ?? this.nome,
      saldo: saldo ?? this.saldo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nome': nome});
    result.addAll({'saldo': saldo});

    return result;
  }

  factory CaixaModel.fromMap(Map<String, dynamic> map) {
    return CaixaModel(
      nome: map['nome'] ?? '',
      saldo: map['saldo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CaixaModel.fromJson(String source) =>
      CaixaModel.fromMap(json.decode(source));

  @override
  String toString() => 'CaixaModel(nome: $nome, saldo: $saldo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CaixaModel && other.nome == nome && other.saldo == saldo;
  }

  @override
  int get hashCode => nome.hashCode ^ saldo.hashCode;
}
