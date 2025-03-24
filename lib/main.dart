import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'complete.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Form',
      home: Scaffold(
        appBar: AppBar(title: const Text('Signup Form')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  SignupFormState createState() => SignupFormState();
}
// Create a corresponding State class.
// This class holds data related to the form
class SignupFormState extends State<SignupForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'First name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:BorderSide(width: 2.0, color: Colors.lightBlueAccent) 
                ), // Adds a box around the input field
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            validator: (value) => (value == null || value.isEmpty) ? 'Please enter your first name' : null,
          ),
          const SizedBox(height: 30,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Last name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:BorderSide(width: 2.0, color: Colors.lightBlueAccent) ), // Adds a box around the input field
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            validator: (value) => (value == null || value.isEmpty) ? 'Please enter your last name' : null,
          ),
          const SizedBox(height: 30,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:BorderSide(width: 16.0, color: Colors.lightBlueAccent) 
                ), // Adds a box around the input field
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 30,),
          TextFormField(
            controller: _dobController,
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:BorderSide(width: 16.0, color: Colors.lightBlueAccent) 
                ), // Adds a box around the input field
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  _dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
            },
            validator: (value) => (value == null || value.isEmpty) ? 'Please select your date of birth' : null,
          ),
          const SizedBox(height: 30,),
          TextFormField( 
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:BorderSide(width: 16.0, color: Colors.lightBlueAccent) 
                ), // Adds a box around the input field
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    // Simulate data processing and navigate to the next page
                   Future.delayed(const Duration(seconds: 2), () {
                // Navigate to the SignUpCompletePage
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpCompletePage()),
            );
          });
                  }
                },
                child: const Text('Submit',
                style: TextStyle(color: Colors.blueAccent),),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}
