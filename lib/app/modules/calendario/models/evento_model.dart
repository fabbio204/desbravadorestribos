import 'dart:convert';

class EventoModel {
  DateTime dia;
  String titulo;
  EventoModel({
    required this.dia,
    required this.titulo,
  });

  EventoModel copyWith({
    DateTime? dia,
    String? titulo,
  }) {
    return EventoModel(
      dia: dia ?? this.dia,
      titulo: titulo ?? this.titulo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dia': dia.millisecondsSinceEpoch,
      'titulo': titulo,
    };
  }

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    return EventoModel(
      dia: DateTime.fromMillisecondsSinceEpoch(map['dia']),
      titulo: map['titulo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventoModel.fromJson(String source) =>
      EventoModel.fromMap(json.decode(source));

  @override
  String toString() => 'EventoModel(dia: $dia, titulo: $titulo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventoModel && other.dia == dia && other.titulo == titulo;
  }

  @override
  int get hashCode => dia.hashCode ^ titulo.hashCode;
}
