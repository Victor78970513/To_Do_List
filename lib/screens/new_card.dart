import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/color_model.dart';

import 'package:to_do_list/models/nota.dart';

class NewCardScreen extends StatelessWidget {
  final TextEditingController _contenidoController = TextEditingController();
  final TextEditingController _tituloController = TextEditingController();
  List<Color> coloresAElegir = Colors.primaries;
  Color? colorSeleccionado;

  @override
  Widget build(BuildContext context) {
    final colorModel = Provider.of<ColorModel>(context);
    DateTime now = DateTime.now();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pop(context);
            final titulo = _tituloController.text;
            final contenido = _contenidoController.text;
            final colorAlpha = colorModel.color?.alpha ?? 0;
            final colorRed = colorModel.color?.red ?? 0;
            final colorGreen = colorModel.color?.green ?? 0;
            final colorBlue = colorModel.color?.blue ?? 0;
            final date = now.toString();

            final nuevaNota = Nota(
                titulo: titulo,
                contenido: contenido,
                colorAlpha: colorAlpha,
                colorRed: colorRed,
                colorGreen: colorGreen,
                colorBlue: colorBlue,
                date: date);
            await FirebaseFirestore.instance.collection('notas').add(
                  nuevaNota.aJson(),
                );
          },
          child: const Icon(Icons.save),
        ),
        backgroundColor: colorModel.color?.withOpacity(0.6),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: colorModel.color != null ? Colors.white : Colors.black,
          ),
          title: Text(
            'Nueva Nota',
            style: TextStyle(
              color: colorModel.color != null ? Colors.white : Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: DropdownButton<Color>(
                  isExpanded: true,
                  items: coloresAElegir.map((color) {
                    return DropdownMenuItem(
                      value: color,
                      child: Container(
                        height: 20,
                        width: double.infinity,
                        color: color,
                      ),
                    );
                  }).toList(),
                  value: colorModel.color,
                  hint: const Text('Selecciona un Color'),
                  onChanged: (newColorSelected) {
                    colorModel.color = newColorSelected;
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  hintText: 'Titulo de la nota',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contenidoController,
                decoration: const InputDecoration(
                  hintText: 'Contenido de la nota',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ));
  }
}
