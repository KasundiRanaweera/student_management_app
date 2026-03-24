class Student {
  String Name;
  String StudentId;
  String Email;
  String Degree;
  int Age;

  Student({
    required this.Name,
    required this.StudentId,
    required this.Email,
    required this.Degree,
    required this.Age,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'StudentId': StudentId,
      'Email': Email,
      'Degree': Degree,
      'Age': Age,
    };
  }
}
