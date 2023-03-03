import 'package:flutter/material.dart';
import 'package:to_do_list/models/nota.dart';

class CardNota extends StatelessWidget {
  const CardNota({
    Key? key,
    required this.nota,
  }) : super(key: key);

  final Nota nota;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
          color: Color.fromARGB(
              nota.colorAlpha, nota.colorRed, nota.colorGreen, nota.colorBlue),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                color: Colors.white,
                spreadRadius: 3,
                blurRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.start,
                nota.titulo,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(nota.date.substring(0, 10)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            nota.contenido,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
