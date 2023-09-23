import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('categories')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(query.docs);
    isLoading = false;
    setState(() {});
  }

  // error please try again later
  /*getData() async {
    FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (int i = 0; i < querySnapshot.size; i++) {
        data.add(querySnapshot.docs[i]['name']);
      }
      print('ssssssssss||${querySnapshot.docs[2]['name']}');
    });
  }*/

  Future<void> _refreshList() async {
    // Simulate fetching new data here (replace with your own data-fetching logic)
    setState(() {
      data.clear();
      getData();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn g = GoogleSignIn();
              g.disconnect();

              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshList,
              child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                  ),
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("assets/images/folder.png",
                              height: 60, width: 60),
                          Text(
                            data[i]["name"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addcat");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
