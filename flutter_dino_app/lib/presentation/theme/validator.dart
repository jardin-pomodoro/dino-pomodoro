import 'package:form_field_validator/form_field_validator.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Le mot de passe est requis'),
  MinLengthValidator(8,
      errorText: 'Le mot de passe doit faire au moins 8 charactères'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Le mot de passe doit conteni au moins un symbole')
]);

final usernameValidator = MultiValidator([
  RequiredValidator(errorText: "le nom d'utilisateur est requis"),
  MinLengthValidator(3,
      errorText: "Le nom d'utilisateur doit faire au moins 3 charactères"),
  MaxLengthValidator(20,
      errorText: "Le nom d'utilisateur doit faire au maximum 20 charactères"),
]);
