import 'package:flutter/material.dart';
import 'package:sq_flite/LoginUI/Screens/admin.dart';
import 'package:sq_flite/LoginUI/Screens/home.dart';
import 'package:sq_flite/LoginUI/Screens/login_signup.dart';
import 'package:sq_flite/LoginUI/Screens/signup.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:sq_flite/LoginUI/db/SQLHelpers.dart';

class Loginform extends StatefulWidget {
  const Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {

  //! Form Key Generation
  var _formKey = GlobalKey<FormState>();

  

  //! Controller For the TextField

  final TextEditingController conemail = TextEditingController();
  final TextEditingController conpass = TextEditingController();

  //! Login CheckUp

  Future<void> logincheck(String email, String password) async {
    if (email == "admin@gmail.com" && password == "12345678") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminHome()));
    } else {
      var data = await SQLHelper.CheckLogin(email, password);
      if (data.isNotEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(data: data)));
        print("Login Success");
      } else if (data.isEmpty) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginSignup()));
        print("Login Failed");
      }
    }
  } 

  @override
  Widget build(BuildContext context) {
    bool hidepass = true; //! For password
    return Scaffold(
      appBar: AppBar(
        title: const Text("L O G I N  P A G E"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children:  [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "LoginPage",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: conemail,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.drive_file_rename_outline),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
                //! Text validation
                validator: (text) {
                  if (text!.isEmpty || !text.contains('@') || !text.contains('.')) {
                    return "Enter a valid Email!!!!";
                  }
                },
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: conpass,
                obscureText: hidepass,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (hidepass) {
                          hidepass = false;
                        } else {
                          hidepass = true;
                        }
                      });
                    },
                    icon: Icon(hidepass ? Icons.visibility : Icons.visibility_off ),
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),

                //! Password Validator
                validator: (pass) {
                  if (pass!.isEmpty || pass.length < 6) {
                    return "Password length should be greater than 6";
                  }
                },
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                 style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent.shade700),
                  minimumSize: MaterialStateProperty.all(const Size(350, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    ),
                  )
                ),
                onPressed: () {
                  final valid = _formKey.currentState!.validate();

                  if (valid) {
                    logincheck(conemail.text, conpass.text);
                  } else { 
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              action: SnackBarAction(label: 'UNDO', onPressed: (){}),
                              content: const Text('Invalid username / password')),
                    );
                  }
                },
                child: const Text('LOGIN'),
              ),
              /*child: MaterialButton(
                
                color: Colors.blueAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                onPressed: () {
                  final valid = _formKey.currentState!.validate();

                  if (valid) {
                    logincheck(conemail.text, conpass.text);
                  } else { 

                  }
                },
                child: const Text('LOGIN'),
              ), */
              
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpForm()));
              },
              child: const Text('Not a User? Register Here!'),
            ),
          ],
        ),
      ),
    );
  }
}