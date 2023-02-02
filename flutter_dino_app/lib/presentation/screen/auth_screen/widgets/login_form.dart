import 'package:flutter/material.dart';
import 'package:flutter_dino_app/data/datasource/api/repository/api_user_repository.dart';
import 'package:flutter_dino_app/domain/usecases/login_use_case.dart';
import 'package:flutter_dino_app/presentation/state/api_consumer/api_consumer.dart';
import 'package:flutter_dino_app/presentation/widgets/snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();

}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = ''; 

  @override
  Widget build(BuildContext context) {
    final client = ref.read(apiProvider);
    return Form(
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
              onChanged: (value) => password = value,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final form = _formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  final login = LoginUseCase(ApiUserRepository(client));
                  final result = await login(LoginParam(email, password));
                  result.fold((l) {
                    showErrorSnackBar(context, l.message);
                  }, (r) {
                    Navigator.of(context).pop();
                    showSnackBar(context, 'Connexion reussie');
                  });
                }
              },
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
