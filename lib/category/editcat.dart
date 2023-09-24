import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCategories extends StatefulWidget {
  const EditCategories({super.key, required this.id, required this.title});

  final String id;
  final String title;

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController catController = TextEditingController();
  CollectionReference cate =
      FirebaseFirestore.instance.collection("categories");

  editCategory() async {
    try {
      await cate.doc(widget.id).update({
        "name": catController.text,
      });
      print('updateeeeeeeeeeeeeeees');
      Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    catController.text = widget.title;
    super.initState();
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
                  onPressed: editCategory,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    elevation: 5, // Elevation (shadow)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Edit Category'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
