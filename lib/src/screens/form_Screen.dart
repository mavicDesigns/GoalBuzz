import 'package:flutter/material.dart';
import 'package:truck/src/components/widget/form_field.dart';

class FormScreen extends StatelessWidget {

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormField(
                leadingIcon: Icons.person,
                label: 'Name',
                placeholder: 'Enter your name',
                formStatus: FormStatus.neutral,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              CustomFormField(
                trailingIcon: Icons.clear,
                label: 'Email',
                placeholder: 'Enter your email',
                formStatus: FormStatus.neutral,
                validator: validateEmail,
              ),
              SizedBox(height: 16.0),
              CustomFormField(
                label: 'Password',
                placeholder: 'Enter your password',
                formStatus: FormStatus.neutral,
                borderColor: Colors.red,
                validator: validatePassword,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Validate the form
                  final form = Form.of(context);
                  if (form != null && form.validate()) {
                    // Form is valid, proceed with submission
                    print('Form is valid');
                  } else {
                    // Form is invalid
                    print('Form is invalid');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
