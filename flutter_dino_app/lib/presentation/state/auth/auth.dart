import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/api/api_consumer.dart';
import '../api_consumer/api_consumer.dart';

final authMethodProvider = FutureProvider<List<OAuth2Provider>>((ref) async {
  final ApiConsumer consumer = ref.read(apiProvider);
  final authMethod = await consumer.getAuthMethods();
  return authMethod.authProviders
      .map((e) => OAuth2Provider.fromJson(e.toJson()))
      .toList();
});

class OAuth2Provider {
  final String name;
  final String state;
  final String codeVerifier;
  final String codeChallenge;
  final String codeChallengeMethod;
  final String authUrl;

  OAuth2Provider({
    required this.name,
    required this.state,
    required this.codeVerifier,
    required this.codeChallenge,
    required this.codeChallengeMethod,
    required this.authUrl,
  });

  factory OAuth2Provider.fromJson(Map<String, dynamic> map) {
    return OAuth2Provider(
      name: map['name'],
      state: map['state'],
      codeVerifier: map['code_verifier'],
      codeChallenge: map['code_challenge'],
      codeChallengeMethod: map['code_challenge_method'],
      authUrl: map['auth_url'],
    );
  }
}
