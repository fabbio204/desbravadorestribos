import 'dart:convert';

class MembroModel {
  String nome;
  String? dataNascimento;
  String? unidade;
  String aniversario;
  String? foto;
  int? idade;
  MembroModel({
    required this.nome,
    this.dataNascimento,
    this.unidade,
    required this.aniversario,
    this.foto,
    this.idade,
  });

  MembroModel copyWith({
    String? nome,
    String? dataNascimento,
    String? unidade,
    String? aniversario,
    String? foto,
    int? idade,
  }) {
    return MembroModel(
      nome: nome ?? this.nome,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      unidade: unidade ?? this.unidade,
      aniversario: aniversario ?? this.aniversario,
      foto: foto ?? this.foto,
      idade: idade ?? this.idade,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'dataNascimento': dataNascimento,
      'unidade': unidade,
      'aniversario': aniversario,
      'foto': foto,
      'idade': idade,
    };
  }

  factory MembroModel.fromMap(Map<String, dynamic> map) {
    return MembroModel(
      nome: map['nome'] ?? '',
      dataNascimento: map['dataNascimento'] ?? '',
      unidade: map['unidade'] ?? '',
      aniversario: map['aniversario'] ?? '',
      foto: map['foto'] ?? '',
      idade: map['idade']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MembroModel.fromJson(String source) =>
      MembroModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MembroModel(nome: $nome, dataNascimento: $dataNascimento, unidade: $unidade, aniversario: $aniversario, foto: $foto, idade: $idade)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MembroModel &&
        other.nome == nome &&
        other.dataNascimento == dataNascimento &&
        other.unidade == unidade &&
        other.aniversario == aniversario &&
        other.foto == foto &&
        other.idade == idade;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        dataNascimento.hashCode ^
        unidade.hashCode ^
        aniversario.hashCode ^
        foto.hashCode ^
        idade.hashCode;
  }
}
