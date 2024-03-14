import 'package:api_practice/api_url.dart';
import 'package:api_practice/model/student_model.dart';
import 'package:flutter/material.dart';

class InsertForm extends StatefulWidget {
  Map<String, dynamic>? map;
  InsertForm(Map<String, dynamic>? map) {
    this.map = map;
  }

  @override
  State<InsertForm> createState() => _InsertFormState();
}

class _InsertFormState extends State<InsertForm> {
  final _key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  void initState() {
    super.initState();
    if(widget.map!=null) {
      nameController.text = widget.map!["name"];
      ageController.text = widget.map!["age"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert User"),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter name: "),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter name",
                  hintText: "abc",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Enter age"),
              SizedBox(height: 15,),
              TextFormField(
                controller: ageController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter age";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter age",
                  hintText: "19",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: () async {
                if(_key.currentState!.validate()) {
                  if(widget.map==null) {
                    await insertRecord().then((value){
                      Navigator.of(context).pop(true);
                    });
                  } else {
                    await updateRecord().then((value){
                      Navigator.of(context).pop(true);
                    });
                  }
                }
              }, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
  Future<void> insertRecord() async {
    StudentModel stu = StudentModel();
    stu.name = nameController.text;
    stu.age = ageController.text;
    Map<String, dynamic> map = stu.mapConverter();
    await ApiUrl().insertUser(map);
  }

  Future<void> updateRecord() async {
    StudentModel stu = StudentModel();
    stu.name = nameController.text;
    stu.age = ageController.text;
    Map<String, dynamic> map = stu.mapConverter();
    await ApiUrl().updateUser(map, widget.map!["id"]);
  }
}
