import 'package:api_practice/api_url.dart';
import 'package:api_practice/insert_form.dart';
import 'package:flutter/material.dart';

class DisplayDetail extends StatefulWidget {
  const DisplayDetail({super.key});

  @override
  State<DisplayDetail> createState() => _DisplayDetailState();
}

class _DisplayDetailState extends State<DisplayDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User detail"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return InsertForm(null);
                  },
                )).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: ApiUrl().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.lightGreenAccent,
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(child: Text(snapshot.data![index]["name"])),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return InsertForm(snapshot.data![index]);
                              },
                            )).then((value) {
                              if (value == true) {
                                setState(() {});
                              }
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade400,
                          )),
                      IconButton(
                          onPressed: () async {
                            bool deleteConfirmation = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Delete Confirmation"),
                                  content: Text(
                                      "Are you sure you want to delete user?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text("Delete"))
                                  ],
                                );
                              },
                            );
                            if (deleteConfirmation != null &&
                                deleteConfirmation) {
                              await ApiUrl()
                                  .deleteUser(snapshot.data![index]["id"])
                                  .then((value) {
                                setState(() {});
                              });
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
