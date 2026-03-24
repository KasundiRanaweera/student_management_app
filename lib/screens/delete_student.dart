import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class DeleteStudent extends StatefulWidget {
  @override
  State<DeleteStudent> createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {

  final idController = TextEditingController();
  FirestoreService firestoreService = FirestoreService();

  void deleteStudent(){

    firestoreService.deleteByStudentId(idController.text.trim());

    idController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student Deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Delete",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(30),
             
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              TextField(
                controller: idController,

                decoration: InputDecoration(
                  hintText: "Student ID",
                  hintStyle: TextStyle(
                  fontSize: 18,),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: (){
                      idController.clear();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 120,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  onPressed: deleteStudent,

                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}