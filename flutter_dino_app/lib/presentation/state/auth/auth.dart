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
    print(map);
    return OAuth2Provider(
      name: map['name'],
      state: map['state'],
      codeVerifier: map['codeVerifier'],
      codeChallenge: map['codeChallenge'],
      codeChallengeMethod: map['codeChallengeMethod'],
      authUrl: map['authUrl'],
    );
  }
}

const String redirectUri = 'https://pocketbase.nospy.fr/redirect.html';

class DiscordOauthVariable {
  static const String scope = 'identify%20email';
  static const clientId = '1064464779634298911';
  static String buildUrl(OAuth2Provider provider) {
    final state = provider.state;
    final codeChallenge = provider.codeChallenge;
    final codeMethode = provider.codeChallengeMethod;
    final clientIdEncoded = Uri.encodeQueryComponent(clientId);
    final redirectUriEncoded = Uri.encodeQueryComponent(redirectUri);
    return 'https://discord.com/api/oauth2/authorize?redirect_uri=$redirectUriEncoded&client_id=$clientIdEncoded&response_type=code&scope=$scope&state=$state&code_challenge=$codeChallenge&code_challenge_method=$codeMethode';
  }
}
