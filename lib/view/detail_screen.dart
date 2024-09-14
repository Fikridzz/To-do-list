// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:todo_list/conttroller/to_do_controller.dart';
// import 'package:todo_list/data/to_do_data.dart';
// import 'package:todo_list/utils/router.dart';

// class DetailScreen extends HookConsumerWidget {
//   final int id;
//   const DetailScreen(this.id, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final taskList = ref.watch(taskListProvider);
//     final data =
//         ref.watch(toDoListProvider).firstWhere((element) => element.id == id);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: const Color(0xFFEE5683),
//         onPressed: () {
//           _addTask(context, ref);
//         },
//         label: const Text('Add Task', style: TextStyle(color: Colors.white)),
//         icon: const Icon(Icons.add, color: Colors.white, size: 25),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           _headerWidget(data),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         data.title,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Container(
//                         height: 20,
//                         width: 20,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF1aff00),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'To Do List',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: taskList.length,
//                     itemBuilder: (context, index) {
//                       ToDoItem item = taskList[index];
//                       return Row(
//                         children: [
//                           Checkbox(
//                             activeColor: const Color(0xFFee5683),
//                             value: item.isDone,
//                             onChanged: (value) {
//                               ref
//                                   .read(taskListProvider.notifier)
//                                   .toggleTask(item);
//                             },
//                           ),
//                           Text(
//                             item.title,
//                             style: TextStyle(
//                               fontSize: 16,
//                               decoration: item.isDone
//                                   ? TextDecoration.lineThrough
//                                   : TextDecoration.none,
//                               color: item.isDone ? Colors.grey : Colors.black,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _headerWidget(ToDoData data) {
//     return Stack(
//       children: [
//         Image.asset('assets/background.png'),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 60),
//               Text(
//                 'Due date',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[300],
//                 ),
//               ),
//               Text(
//                 DateFormat('dd MMM yyyy').format(data.date),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _addTask(BuildContext context, WidgetRef ref) {
//     final titleCtr = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text('Add Task'),
//           content: TextField(
//             controller: titleCtr,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//               labelText: 'Task',
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 context.pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 ref.read(taskListProvider.notifier).addTask(titleCtr.text);
//                 context.pop();
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
