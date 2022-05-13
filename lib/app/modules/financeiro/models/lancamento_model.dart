import 'dart:convert';

class LancamentoModel {
  String data;
  String descricao;
  String? entrada;
  String? saida;
  String? envolvido;
  LancamentoModel({
    required this.data,
    required this.descricao,
    this.entrada,
    this.saida,
    this.envolvido,
  });

  LancamentoModel copyWith({
    String? data,
    String? descricao,
    String? entrada,
    String? saida,
    String? envolvido,
  }) {
    return LancamentoModel(
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
      entrada: entrada ?? this.entrada,
      saida: saida ?? this.saida,
      envolvido: envolvido ?? this.envolvido,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'data': data});
    result.addAll({'descricao': descricao});
    result.addAll({'entrada': entrada});
    result.addAll({'saida': saida});
    result.addAll({'envolvido': envolvido});

    return result;
  }

  factory LancamentoModel.fromMap(Map<String, dynamic> map) {
    return LancamentoModel(
      data: map['data'] ?? '',
      descricao: map['descricao'] ?? '',
      entrada: map['entrada'] ?? '',
      saida: map['saida'] ?? '',
      envolvido: map['envolvido'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LancamentoModel.fromJson(String source) =>
      LancamentoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LancamentoModal(data: $data, descricao: $descricao, entrada: $entrada, saida: $saida, envolvido: $envolvido)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LancamentoModel &&
        other.data == data &&
        other.descricao == descricao &&
        other.entrada == entrada &&
        other.saida == saida &&
        other.envolvido == envolvido;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        descricao.hashCode ^
        entrada.hashCode ^
        saida.hashCode ^
        envolvido.hashCode;
  }
}
