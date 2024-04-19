import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NotesTile extends StatelessWidget {
  final Note note;
  final void Function() deleteNode;
  const NotesTile({super.key, required this.note, required this.deleteNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      padding: const EdgeInsets.only(left: 12, right: 0, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
              title: Text(note.title),
              trailing: IconButton(onPressed: (){
               deleteNode();
              }, icon: Icon(Icons.delete)),
            ),
    );
  }
}