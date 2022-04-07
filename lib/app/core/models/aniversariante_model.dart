import 'dart:convert';

class AniversarianteModel {
  String dia;
  String nome;
  AniversarianteModel({
    required this.dia,
    required this.nome,
  });

  AniversarianteModel copyWith({
    String? dia,
    String? nome,
  }) {
    return AniversarianteModel(
      dia: dia ?? this.dia,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dia': dia,
      'nome': nome,
    };
  }

  factory AniversarianteModel.fromMap(Map<String, dynamic> map) {
    return AniversarianteModel(
      dia: map['dia'] ?? '',
      nome: map['nome'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AniversarianteModel.fromJson(String source) =>
      AniversarianteModel.fromMap(json.decode(source));

  @override
  String toString() => 'AniversarianteModel(dia: $dia, nome: $nome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AniversarianteModel &&
        other.dia == dia &&
        other.nome == nome;
  }

  @override
  int get hashCode => dia.hashCode ^ nome.hashCode;
}
