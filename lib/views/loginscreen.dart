import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/views/mainscreen.dart';
import 'package:mytutor/views/registerscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late double screen_height, screen_width, ctrlwidth;
  bool rememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screen_height = MediaQuery.of(context).size.height;
    screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('MYTutor'),
        ),
        body: SingleChildScrollView(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: screen_height / 2.5,
                          width: screen_width,
                          child: Image.asset('assets/images/mytutor.png')),
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          keyboardType: TextInputType.emailAddress,
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(value: rememberMe, onChanged: _onRememberMe),
                          const Text("Remember Me")
                        ],
                      ),
                      SizedBox(
                        width: screen_width,
                        height: 50,
                        child: ElevatedButton(
                          child: const Text("Login"),
                          onPressed: _loginUser,
                        ),
                      ),
                      GestureDetector(
                          child: const Text("Sign Up Here",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const RegisterScreen()))
                              }),

                    ]),
              ),
            ])));
  }

  void _onRememberMe(bool? value) {
    setState(() {
      rememberMe = value!;
    });
  }

  void _loginUser() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      http.post(
          Uri.parse("http://10.31.214.120/mytutor/mobile/php/login_user.php"),
          body: {"email": email, "password": password}).then((response) {
        if (response.body == "success") {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const MainScreen()));
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
}
