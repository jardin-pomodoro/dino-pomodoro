import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../domain/services/auth_service.dart';
import '../../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../../state/services/auth_service_provider.dart';
import '../../../widgets/snackbar.dart';
import '../../growing_screen/growing_screen_widget.dart';

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
    final authService = ref.read(authServiceProvider);
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.75,
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
                  final result =
                      await authService.login(LoginParam(email, password));
                  if (mounted) {
                    if (!result.isSuccess) {
                      showErrorSnackBar(context, result.failureMessage);
                    } else {
                      ref
                          .read(authStateNotifierProvider.notifier)
                          .setUser(result.data!);
                      authService.userAuthSuccess(result.data!);
                      Navigator.of(context).pop();
                      showSnackBar(context, 'Connexion reussie');
                      GrowingScreenWidget.navigateTo(context);
                    }
                  }
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
