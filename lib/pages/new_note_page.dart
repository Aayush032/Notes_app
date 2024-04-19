import 'package:flutter/material.dart';
import 'package:notes_app/components/custom_textfield.dart';

import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  String title = "";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: SizedBox(
          width: 300,
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {
                  //Add to database
                  context.read<NoteDatabase>().addNewNote(titleController.text, descriptionController.text);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Title field
            CustomTextField(
                descriptionController: titleController, hintText: "Title", maxLines: 1,),

            //Description field
            CustomTextField(
                descriptionController: descriptionController, hintText: "Description", maxLines: 15,),
          ],
        ),
      ),
    );
  }
}
