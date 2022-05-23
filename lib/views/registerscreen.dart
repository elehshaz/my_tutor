import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mainscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => NewRegisterState();
}

class NewRegisterState extends State<RegisterScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  String pictureAsset = 'assets/images/registration.png';

  var _image;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTRATION FORM'),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: SizedBox(
        width: ctrwidth,
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0))),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: emailController,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText: 'Email',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 80),
                      child: Icon(Icons.email)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    child: TextFormField(
                      controller: phoneNumController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: addressController,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      alignLabelWithHint: true,
                      prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: Icon(Icons.home)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    child: TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.security),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: screenWidth,
              height: 50,
              child: ElevatedButton(
                child: const Text("Insert"),
                onPressed: () {
                  _insertDialog();
                },
              ),
            ),
            const SizedBox(height: 10),
          ]),
        ),
      ))),
    );
  }

  void _insertDialog() {
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Add Details",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _insertDetails();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _insertDetails() {
    String name = nameController.text;
    String email = emailController.text;
    String phoneNum = phoneNumController.text;
    String password = passwordController.text;
    String address = addressController.text;

    http.post(
        Uri.parse("http://10.31.214.120/mytutor/mobile/php/dbconnect.php"),
        body: {
          "name": name,
          "email": email,
          "phone number": phoneNum,
          "password": password,
          "address": address,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}
