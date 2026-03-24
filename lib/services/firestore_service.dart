import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';

class FirestoreService {
  final CollectionReference students = FirebaseFirestore.instance.collection(
    'students',
  );

  // CREATE
  Future<void> addStudent(Student student) async {
    await students.add({
      "Name": student.Name,
      "StudentId": student.StudentId,
      "Email": student.Email,
      "Degree": student.Degree,
      "Age": student.Age,
    });
  }

  // READ
  Stream<QuerySnapshot> getStudents() {
    return students.snapshots();
  }

  // UPDATE
  Future<void> updateStudent(String docId, Student student) async {
    await students.doc(docId).update(student.toMap());
  }

  // DELETE using StudentId
  Future<void> deleteByStudentId(String studentId) async {
    var querySnapshot = await students
        .where("StudentId", isEqualTo: studentId)
        .get();

    for (var doc in querySnapshot.docs) {
      await students.doc(doc.id).delete();
    }
  }
}
