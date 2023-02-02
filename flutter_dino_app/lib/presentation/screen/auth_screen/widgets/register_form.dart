import 'package:flutter/material.dart';
import '../../../../domain/usecases/register_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../data/datasource/api/repository/api_user_repository.dart';
import '../../../state/api_consumer/api_consumer.dart';
import '../../../theme/validator.dart';
import '../../../widgets/snackbar.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();

}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  String password = '';
  String username = '';
  String email = '';
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final client = ref.read(apiProvider);
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: EmailValidator(errorText: 'Email non valide'),
              ),
              TextFormField(
                onChanged: (value) => username = value,
                decoration: const InputDecoration(
                  labelText: "Nom d'utilisateur",
                ),
                validator: usernameValidator,
              ),
              TextFormField(
                onChanged: (value) => password = value,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
                validator: passwordValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmation',
                ),
                obscureText: true,
                validator: (val) {
                  if (val != null) {
                    print(val);
                    print(password);
                    return MatchValidator(errorText: 'Les mots de passes ne correspondent pas').validateMatch(val, password);
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () async {
                final form = _formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  final register = RegisterUseCase(ApiUserRepository(client));
                  final result = await register(RegisterParam());
                  result.fold((l) {
                    showErrorSnackBar(context, l.message);
                  }, (r) {
                    Navigator.of(context).pop();
                    showSnackBar(context, 'inscription reussie');
                  });
                }
              }, child: const Text("S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}