import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../theme/validator.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: EmailValidator(errorText: 'Email non valide'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
                validator: passwordValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nom d'utilisateur",
                ),
                validator: usernameValidator,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text("S'inscrire")),
            ],
          ),
        ),
      ),
    );
  }
}