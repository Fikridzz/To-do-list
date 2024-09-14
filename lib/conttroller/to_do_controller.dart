import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/data/to_do_data.dart';

class ToDoController extends Notifier<List<ToDoData>> {
  @override
  List<ToDoData> build() {
    return [];
  }

  void addData(String value, DateTime date) {
    final data = ToDoData(title: value, date: date, isDone: false);
    state = [...state, data];
  }

  void removeData(ToDoData data) {
    state = state.where((element) => element != data).toList();
  }

  void toggleTask(ToDoData data) {
    final index = state.indexOf(data);
    state[index] = ToDoData(
      title: data.title,
      date: data.date,
      isDone: !data.isDone,
    );
    state = [...state];
  }

  void searchData(String value) {
    state = state
        .where((element) => element.title.toLowerCase().contains(value))
        .toList();
  }
}

// class TaskController extends Notifier<List<ToDoItem>> {
//   @override
//   List<ToDoItem> build() {
//     return [];
//   }

//   void addTask(String value) {
//     final data = ToDoItem(title: value, isDone: false);
//     state = [...state, data];
//   }

//   void removeTask(ToDoItem data) {
//     state = state.where((element) => element != data).toList();
//   }

//   void toggleTask(ToDoItem data) {
//     final index = state.indexOf(data);
//     state[index] = ToDoItem(title: data.title, isDone: !data.isDone);
//     state = [...state];
//   }
// }

final toDoListProvider =
    NotifierProvider<ToDoController, List<ToDoData>>(ToDoController.new);

final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());
