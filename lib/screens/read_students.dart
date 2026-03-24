import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import '../models/student.dart';
import 'update_student.dart';

class ReadStudents extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Read",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getStudents(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var students = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 30),
            itemCount: students.length,

            itemBuilder: (context, index) {
              var doc = students[index];
              var data = doc.data() as Map<String, dynamic>;

              // Convert Firestore data to Student object
              Student student = Student(
                Name: data['Name'],
                StudentId: data['StudentId'],
                Email: data['Email'],
                Degree: data['Degree'],
                Age: data['Age'],
              );

              return Card(
                color: Colors.blue,
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),

                child: ListTile(
                  title: Text(
                    student.Name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 5),

                      Text(
                        "ID: ${student.StudentId}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        student.Email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        student.Degree,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        "Age: ${student.Age}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              UpdateStudent(docId: doc.id, student: student),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
