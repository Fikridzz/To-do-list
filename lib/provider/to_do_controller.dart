import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/data/to_do_data.dart';
import 'package:todo_list/helper/database_helper.dart';

part 'to_do_controller.g.dart';

@Riverpod(keepAlive: false)
class ToDoController extends _$ToDoController {
  @override
  Future<List<ToDoData>> build() async {
    List<Map<String, dynamic>> result = await DBHelper.query();
    final data = result.map((data) => ToDoData.fromMap(data)).toList();
    return data;
  }

  void addData(String value, String date) async {
    state = await AsyncValue.guard(() async {
      final data = ToDoData(title: value, date: date, isDone: false);
      final index = await DBHelper.insert(data);
      return [...state.value ?? [], data.copyWith(id: index)];
    });
  }

  void removeData(ToDoData data) async {
    state = await AsyncValue.guard(() async {
      await DBHelper.delete(data);
      return state.value?.where((element) => element.id != data.id).toList() ??
          [];
    });
  }

  void updateData(ToDoData task) async {
    state = await AsyncValue.guard(() async {
      await DBHelper.update(task.id!);
      return state.value?.map((e) {
            if (e.id == task.id) {
              return task.copyWith(isDone: !task.isDone);
            }
            return e;
          }).toList() ??
          [];
    });
  }

  void searchData(String value) async {
    state = await AsyncValue.guard(() async {
      await DBHelper.search(value);
      List<Map<String, dynamic>> result = await DBHelper.search(value);
      final data = result.map((data) => ToDoData.fromMap(data)).toList();
      return data;
    });
  }
}

final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());
