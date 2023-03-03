import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/models/nota.dart';
import 'package:to_do_list/screens/new_card.dart';
import 'package:to_do_list/widgets/card_nota.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 35),
        ),
      ),
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NewCardScreen()));
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notas')
            .orderBy('fecha', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final querySnapshots = snapshot.data!;
            final documentSnapshots = querySnapshots.docs;
            List<Nota> notas = [];
            for (var document in documentSnapshots) {
              final nota = Nota.fromDocumentSnapshot(document);
              notas.add(nota);
            }
            return Center(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(notas.length, (index) {
                  final nota = notas[index];
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: Key(documentSnapshots[index].id),
                    onDismissed: (direction) async {
                      await FirebaseFirestore.instance
                          .collection('notas')
                          .doc(documentSnapshots[index].id)
                          .delete();
                    },
                    child: CardNota(nota: nota),
                  );
                }),
              ),
            ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
