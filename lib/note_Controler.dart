import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:note_pad_app/note_model.dart';

class NoteControler extends GetxController {
  final Box box = Hive.box('notes');

  void addNote(NoteModel note) {
    box.add(note);

    update();
  }

  void deleteNote(int index) {
    box.deleteAt(index);
    update();
  }

  void updateNote(int index, NoteModel note) {
    box.putAt(index, note);
    update();
  }
}
