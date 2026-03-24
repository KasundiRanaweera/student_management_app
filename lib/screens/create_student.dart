import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/firestore_service.dart';

class CreateStudent extends StatefulWidget {
  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final emailController = TextEditingController();
  final degreeController = TextEditingController();
  final ageController = TextEditingController();

  FirestoreService firestoreService = FirestoreService();

  void submitStudent() {
    // Validation
    if (nameController.text.isEmpty ||
        idController.text.isEmpty ||
        emailController.text.isEmpty ||
        degreeController.text.isEmpty ||
        ageController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));

      return;
    }

    Student student = Student(
      Name: nameController.text,
      StudentId: idController.text,
      Email: emailController.text,
      Degree: degreeController.text,
      Age: int.tryParse(ageController.text) ?? 0,
    );

    firestoreService.addStudent(student);

    nameController.clear();
    idController.clear();
    emailController.clear();
    degreeController.clear();
    ageController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Student Added Successfully")));
  }

  Widget textField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),

      child: TextField(
        controller: controller,

        keyboardType: hint == "Age" ? TextInputType.number : TextInputType.text,

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

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
          "Create",
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
              onPressed: submitStudent,

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
