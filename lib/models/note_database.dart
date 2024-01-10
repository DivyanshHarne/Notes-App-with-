import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier{
  static late Isar isar;

  // I n i t i a l i z e  the database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }
  //list of notes
  final List<Note> currentNotes = [];

  // C R E A T E

  Future<void> addNote(String textFromUser) async{
    // create a new note object
    final newNote = Note()..text = textFromUser;
    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
    // re-read from the database
    fetchNotes();
  }

  // R E A D

Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
 }

  // U P D A T E

Future<void> updateNote(int id,String newText) async {
  final existingNote = await isar.notes.get(id);
  if(existingNote != null){
    existingNote.text = newText;
    await isar.writeTxn(() => isar.notes.put(existingNote));
    await fetchNotes();
  }
}

  //D E L E T E

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}