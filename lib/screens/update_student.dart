import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/firestore_service.dart';

class UpdateStudent extends StatefulWidget {

  final Student student;
  final String docId;

  const UpdateStudent({
    super.key,
    required this.student,
    required this.docId,
  });

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {

  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController emailController;
  late TextEditingController degreeController;
  late TextEditingController ageController;

  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();

    // Pre-filled values
    nameController = TextEditingController(text: widget.student.Name);
    idController = TextEditingController(text: widget.student.StudentId);
    emailController = TextEditingController(text: widget.student.Email);
    degreeController = TextEditingController(text: widget.student.Degree);
    ageController = TextEditingController(text: widget.student.Age.toString());
  }

  void updateStudent() {

    Student updatedStudent = Student(
      Name: nameController.text,
      StudentId: idController.text,
      Email: emailController.text,
      Degree: degreeController.text,
      Age: int.tryParse(ageController.text) ?? 0,
    );

    firestoreService.updateStudent(widget.docId, updatedStudent);

    Navigator.pop(context);
  }

  Widget textField(String label, TextEditingController controller) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),

      child: TextField(
        controller: controller,

        keyboardType:
            label == "Age" ? TextInputType.number : TextInputType.text,

        decoration: InputDecoration(

          
          labelText: label,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),

            onPressed: () {
              controller.clear();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Update",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 30),

            textField("Name", nameController),
            textField("Student ID", idController),
            textField("Email", emailController),
            textField("Degree", degreeController),
            textField("Age", ageController),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: updateStudent,

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,

                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                ),
              ),

              child: const Text(
                "Update",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}