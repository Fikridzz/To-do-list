class ToDoData {
  final int? id;
  final String title;
  final String date;
  final bool isDone;

  ToDoData({
    this.id,
    required this.title,
    required this.date,
    required this.isDone,
  });

  factory ToDoData.fromMap(Map<String, dynamic> map) {
    return ToDoData(
      id: map['id'] as int?,
      title: map['title'] as String,
      date: map['date'] as String,
      isDone: map['isDone'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'isDone': isDone ? 1 : 0,
    };
  }

  ToDoData copyWith({
    int? id,
    String? title,
    String? date,
    bool? isDone,
  }) {
    return ToDoData(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
    );
  }
}

// class ToDoItem {
//   final String title;
//   final bool isDone;

//   ToDoItem({
//     required this.title,
//     required this.isDone,
//   });
// }
