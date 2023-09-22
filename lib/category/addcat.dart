import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController catController = TextEditingController();
  CollectionReference cate =
      FirebaseFirestore.instance.collection("categories");

  addCat() {
    return cate
        .add({
          'name': catController.text,
        })
        .then((value) => print("Category Added"))
        .catchError((error) => print("Failed to add Category: $error"));
  }

  addCategory() async {
    CollectionReference cat =
        FirebaseFirestore.instance.collection("categories");
    if (formKey.currentState!.validate()) {
      try {
        cat.add({"name": catController.text});
        print('catttttttttttttttttttttttttt added');
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } catch (e) {
        print('$e');
      }
    }
  }
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "cant be empty";
                  }
                  return null;
                },
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
                  onPressed: addCategory,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    elevation: 5, // Elevation (shadow)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Add Category'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
