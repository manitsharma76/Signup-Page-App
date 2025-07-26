import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  DateTime? dob;
  String? gender;

  Future<void> submitForm() async {
    var response = await http.post(
      Uri.parse("http://10.0.2.2/submit_form.php"),
      body: {
        "name": name.text,
        "email": email.text,
        "phone": phone.text,
        "dob": dob.toString(),
        "gender": gender
      },
    );

    final result = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (val) => val!.contains('@') ? null : 'Enter valid email',
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (val) => val!.isEmpty ? 'Enter phone number' : null,
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text(dob == null ? 'Select Date of Birth' : dob.toString().split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      dob = picked;
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: gender,
                items: ['Male', 'Female', 'Other']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => gender = val),
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (val) => val == null ? 'Select gender' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate() && dob != null) {
                    submitForm();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
