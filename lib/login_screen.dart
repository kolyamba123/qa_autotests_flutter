import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:qa_automation_integration_test_task/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    const testEmail = 'wiotest@gmail.com';
    const testPassword = 'wiotestpass';
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.pink[200],
                radius: 60.0,
                child: const Text(
                  'WIO',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 48.0),
              TextFormField(
                key: const Key('emailFieldKey'),
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: const EdgeInsets.fromLTRB(
                    20.0,
                    10.0,
                    20.0,
                    10.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is empty';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Email is incorrect';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                key: const Key('passwordFieldKey'),
                autofocus: false,
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding:
                  const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is empty';
                  }
                  if (value.length < 8) {
                    return 'Password is too short';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (emailController.text != testEmail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'The user with email ${emailController.text} was not found.',
                            ),
                          ),
                        );
                      } else if (passwordController.text != testPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Invalid password for user ${emailController.text}',
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              email: emailController.text,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                    primary: Colors.lightBlueAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
