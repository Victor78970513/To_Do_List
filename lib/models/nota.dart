import 'package:cloud_firestore/cloud_firestore.dart';

class Nota {
  final String titulo;
  final String contenido;
  final int colorAlpha;
  final int colorRed;
  final int colorGreen;
  final int colorBlue;
  final String date;

  Nota({
    required this.titulo,
    required this.contenido,
    required this.colorAlpha,
    required this.colorRed,
    required this.colorGreen,
    required this.colorBlue,
    required this.date,
  });

  factory Nota.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final json = documentSnapshot.data() as Map<String, dynamic>;
    return Nota(
      titulo: json['titulo'],
      contenido: json['contenido'],
      colorAlpha: json['colorAlpha'],
      colorRed: json['colorRed'],
      colorGreen: json['colorGreen'],
      colorBlue: json['colorBlue'],
      date: json['fecha'],
    );
  }

  Map<String, dynamic> aJson() {
    return {
      'titulo': titulo,
      'contenido': contenido,
      'colorAlpha': colorAlpha,
      'colorRed': colorRed,
      'colorGreen': colorGreen,
      'colorBlue': colorBlue,
      'fecha': date,
    };
  }
}
