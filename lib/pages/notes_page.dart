import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:notes/components/drawer.dart";
import "package:notes/components/note_tile.dart";
import "package:notes/models/note_database.dart";
import "package:provider/provider.dart";

import "../models/note.dart";

class NotesPage extends StatefulWidget{
  const NotesPage({super.key});

  @override
  State<NotesPage> createState()=> _NotesPageState();
}

class _NotesPageState extends State<NotesPage>{

  //text controller to access what user typed in
  final textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // on app start-up
    readNotes();
  }

  //create a note
  void createNote(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,

      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: "Add a new note."),
      ),
      actions: [
        //create button
        MaterialButton(
            onPressed: (){
              // add to db
              context.read<NoteDataBase>().addNote(textController.text);
              // clear the controller
              textController.clear();
              // pop the dialog
              Navigator.pop(context);
            },
            child: const Text("Create"),
        )
      ],
    ),);
  }
  //read notes
  void readNotes(){
    context.read<NoteDataBase>().fetchNotes();
  }

  //update notes
  void updateNote(Note note){
    // pre-fill the current note text
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: const Text("Update Note"),
          backgroundColor: Theme.of(context).colorScheme.background,
          content: TextField(controller: textController),
          actions: [
            //update button
            MaterialButton(
              onPressed: (){
                // update to db
                context.read<NoteDataBase>().updateNote(note.id, textController.text);
                // clear the controller
                textController.clear();
                // pop the dialog
                Navigator.pop(context);
              },
              child: const Text("Update"),
            )
          ],
        )
    );

  }

  //delete notes
  void deleteNote(int id){
    context.read<NoteDataBase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context){
    // note database
    final noteDatabase =context.watch<NoteDataBase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child:  Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary,),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
                "Notes",
                style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary
            )
            ),
          ),

          //LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index){
                //get individual note
                final note = currentNotes[index];
                //list tile UI
                // return ListTile(
                //   title: Text(note.text),
                //   trailing: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       //edit button
                //       IconButton(onPressed: ()=>updateNote(note), icon: const Icon(Icons.edit)),
                //       // delete button
                //       IconButton(onPressed: ()=>deleteNote(note.id), icon: const Icon(Icons.delete))
                //     ],
                //   ),
                // );
                return NoteTile(text: note.text, onEditPressed: ()=> updateNote(note), onDeletePressed: ()=>deleteNote(note.id),);
              }
            ),
          )
        ],
      )
    );
  }
}