import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/provider/to_do_controller.dart';
import 'package:todo_list/data/to_do_data.dart';
import 'package:todo_list/utils/router.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDoList = ref.watch(toDoControllerProvider);
    final searchCtr = useTextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFEE5683),
        onPressed: () {
          ref.read(dateProvider.notifier).state = DateTime.now();
          _addToDo(context);
        },
        label: const Text('Add Task', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
      body: Column(
        children: [
          _headerWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  TextField(
                    controller: searchCtr,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF2F9FF),
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color(0xFF5D94CA)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color(0xFF5D94CA)),
                      ),
                    ),
                    onChanged: (value) {
                      ref
                          .read(toDoControllerProvider.notifier)
                          .searchData(value);
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'List',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  toDoList.when(
                    data: (data) {
                      return data.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  ToDoData item = data[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onLongPress: () => _dialogDeleteItem(
                                            context, ref, item),
                                        child: _itemWidget(item, ref),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text('No data found'),
                            );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text('Error: $error'),
                      );
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return Stack(
      children: [
        Image.asset('assets/background.png'),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 74, 16, 0),
          child: Text(
            'TO DO LIST',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemWidget(ToDoData data, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEE5683)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            activeColor: const Color(0xFFee5683),
            value: data.isDone,
            onChanged: (value) {
              ref.read(toDoControllerProvider.notifier).updateData(data);
            },
          ),
          Expanded(
            child: Text(
              data.title,
              style: TextStyle(
                fontSize: 16,
                decoration: data.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: data.isDone ? Colors.grey : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            data.date,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _addToDo(BuildContext context) {
    final titleCtr = TextEditingController();
    final dateCtr = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Center(
          child: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final date = ref.watch(dateProvider);
                return AlertDialog(
                  title: const Text('Add To Do'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Task',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: titleCtr,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          ).then((value) {
                            if (value != null) {
                              ref.read(dateProvider.notifier).state = value;
                            }
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Due date',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: dateCtr,
                              enabled: false,
                              decoration: InputDecoration(
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                labelText:
                                    DateFormat('dd MMM yyyy').format(date),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                        ref.read(toDoControllerProvider.notifier).addData(
                            titleCtr.text,
                            DateFormat('dd MMM yyyy').format(date));
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _dialogDeleteItem(BuildContext context, WidgetRef ref, ToDoData item) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(toDoControllerProvider.notifier).removeData(item);
                context.pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
