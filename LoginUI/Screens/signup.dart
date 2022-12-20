import 'package:flutter/material.dart';
import 'package:sq_flite/LoginUI/Screens/login.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:sq_flite/LoginUI/db/SQLHelpers.dart';

class SignUpForm extends StatelessWidget {

  //SignUpForm({super.key});
  //! Form Key Generation
  var _formKey1 = GlobalKey<FormState>();

  //! TextFeilds Controllers
  final TextEditingController conname = TextEditingController();
  final TextEditingController conemail = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController cpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> addNewUser(String name, String email, String password) async{
      var id = await SQLHelper.addNewUser(name, email, password);

      if (id != null) {
        //Goto login Form
      } else {
        //Go to signUp
      }
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey1,
          child: Column(
            children:  [
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Text(
                  "SignUp",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //! Username or email TextFeild
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  controller: conname,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Name is required';
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,

                ),
              ),

              //! password TextFeild
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  controller: pass,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                  ),
                  //? Validator for password
                  validator: (pass1) {
                    if (pass1!.isEmpty || pass1.length < 6) {
                      return 'Password must should greater thean 6';
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),

              //! Conform pwd TextFeild
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  controller: pass,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Conform Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                  ),
                  //? Validator for password
                  validator: (pass1) {
                    if (pass1!.isEmpty || pass1.length < 6) {
                      return 'Password must should greater thean 6';
                    } else if (pass.text != cpass.text){
                      return 'Password not matched';
                    } else {
                      return null;
                    }
                  },
                  //textInputAction: TextInputAction.next,
                ),
              ),

              //! Elevated btn
              ElevatedButton(
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
                  final valid1 = _formKey1.currentState!.validate();
                  if (valid1) {
                    addNewUser(conname.text, conemail.text, pass.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              action: SnackBarAction(label: 'UNDO', onPressed: (){}),
                              content: const Text('Invalid username / password')),
                    );
                  }
                },
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Text('Already have an account?'),
                   TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Loginform()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              
              

            ],
          ),
        ),
      ),
    );
  }
}