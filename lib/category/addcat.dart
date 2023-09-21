import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

////
class _AddCategoriesState extends State<AddCategories> {
  TextEditingController catController = TextEditingController();
  CollectionReference cate =
      FirebaseFirestore.instance.collection("categories");

  Future<void> addCat() {
    return cate
        .add({
          'name': catController.text,
        })
        .then((value) => print("Category Added"))
        .catchError((error) => print("Failed to add Category: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: catController,
              decoration: const InputDecoration(
                hintText: "Enter your category",
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addCat,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  elevation: 5, // Elevation (shadow)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Add Category'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
