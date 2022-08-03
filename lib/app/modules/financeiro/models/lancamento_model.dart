import 'dart:convert';

class LancamentoModel {
  int? id;
  String data;
  String descricao;
  String? entrada;
  String? saida;
  String? subCaixa;
  String? envolvido;

  LancamentoModel({
    this.id,
    required this.data,
    required this.descricao,
    this.entrada,
    this.saida,
    this.subCaixa,
    this.envolvido,
  });

  DateTime get dataEvento {
    List<String> pedacos = data.split('/');
    return DateTime(
        int.parse(pedacos[2]), int.parse(pedacos[1]), int.parse(pedacos[0]));
  }

  LancamentoModel copyWith({
    int? id,
    String? data,
    String? descricao,
    String? entrada,
    String? saida,
    String? subCaixa,
    String? envolvido,
  }) {
    return LancamentoModel(
      id: id ?? this.id,
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
      entrada: entrada ?? this.entrada,
      saida: saida ?? this.saida,
      subCaixa: subCaixa ?? this.subCaixa,
      envolvido: envolvido ?? this.envolvido,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'descricao': descricao,
      'entrada': entrada,
      'saida': saida,
      'subCaixa': subCaixa,
      'envolvido': envolvido,
    };
  }

  factory LancamentoModel.fromMap(Map<String, dynamic> map) {
    return LancamentoModel(
      id: map['id'],
      data: map['data'] ?? '',
      descricao: map['descricao'] ?? '',
      entrada: map['entrada'],
      saida: map['saida'],
      subCaixa: map['subCaixa'],
      envolvido: map['envolvido'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LancamentoModel.fromJson(String source) =>
      LancamentoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LancamentoModel(id: $id, data: $data, descricao: $descricao, entrada: $entrada, saida: $saida, subCaixa: $subCaixa, envolvido: $envolvido)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LancamentoModel &&
        other.id == id &&
        other.data == data &&
        other.descricao == descricao &&
        other.entrada == entrada &&
        other.saida == saida &&
        other.subCaixa == subCaixa &&
        other.envolvido == envolvido;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        data.hashCode ^
        descricao.hashCode ^
        entrada.hashCode ^
        saida.hashCode ^
        subCaixa.hashCode ^
        envolvido.hashCode;
  }
}
