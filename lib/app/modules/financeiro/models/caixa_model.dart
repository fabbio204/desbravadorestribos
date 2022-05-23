import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';

class CaixaModel {
  String nome;
  String saldo;
  List<LancamentoModel>? lancamentos;
  CaixaModel({
    required this.nome,
    required this.saldo,
    this.lancamentos,
  });

  CaixaModel copyWith({
    String? nome,
    String? saldo,
    List<LancamentoModel>? lancamentos,
  }) {
    return CaixaModel(
      nome: nome ?? this.nome,
      saldo: saldo ?? this.saldo,
      lancamentos: lancamentos ?? this.lancamentos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'saldo': saldo,
      'lancamentos': lancamentos?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CaixaModel.fromMap(Map<String, dynamic> map) {
    return CaixaModel(
      nome: map['nome'] ?? '',
      saldo: map['saldo'] ?? '',
      lancamentos: map['lancamentos'] != null
          ? List<LancamentoModel>.from(
              map['lancamentos']?.map((x) => LancamentoModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaixaModel.fromJson(String source) =>
      CaixaModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CaixaModel(nome: $nome, saldo: $saldo, lancamentos: $lancamentos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CaixaModel &&
        other.nome == nome &&
        other.saldo == saldo &&
        listEquals(other.lancamentos, lancamentos);
  }

  @override
  int get hashCode => nome.hashCode ^ saldo.hashCode ^ lancamentos.hashCode;
}
