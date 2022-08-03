import 'dart:convert';

class EventoModel {
  DateTime dia;
  String titulo;
  String? id;
  String? descricao;

  EventoModel({
    this.id,
    required this.dia,
    required this.titulo,
    this.descricao,
  });

  EventoModel copyWith({
    String? id,
    DateTime? dia,
    String? titulo,
    String? descricao,
  }) {
    return EventoModel(
      id: id ?? this.id,
      dia: dia ?? this.dia,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dia': dia.millisecondsSinceEpoch,
      'titulo': titulo,
      'descricao': descricao,
    };
  }

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    return EventoModel(
      id: map['id'],
      dia: DateTime.fromMillisecondsSinceEpoch(map['dia']),
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventoModel.fromJson(String source) =>
      EventoModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'EventoModel(id: $id, dia: $dia, titulo: $titulo, descricao: $descricao)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventoModel &&
        other.dia == dia &&
        other.titulo == titulo &&
        other.id == id &&
        other.descricao == descricao;
  }

  @override
  int get hashCode =>
      dia.hashCode ^ titulo.hashCode ^ id.hashCode ^ descricao.hashCode;
}
