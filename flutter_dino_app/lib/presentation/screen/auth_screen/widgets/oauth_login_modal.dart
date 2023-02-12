import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garden_pomodoro/presentation/screen/growing_screen/growing_screen_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../data/datasource/api/api_consumer.dart';
import '../../../../state/api_consumer/api_consumer.dart';
import '../../../../state/auth/auth.dart';
import '../../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../../state/services/auth_service_provider.dart';
import '../../../router.dart';
import '../../../widgets/bottom_sheet_decoration.dart';
import '../../../widgets/snackbar.dart';

Widget buildOauthLoginModal(OAuth2Provider provider, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: LoginOAuthModal(
              provider: provider,
              context: context,
            ),
          ),
        );
      },
      child: Text(provider.name),
    ),
  );
}

class LoginOAuthModal extends ConsumerStatefulWidget {
  final OAuth2Provider provider;
  final BuildContext context;

  const LoginOAuthModal({
    super.key,
    required this.provider,
    required this.context,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginOAuthModalState();
}

class _LoginOAuthModalState extends ConsumerState<LoginOAuthModal> {
  late final WebViewController _controller;

  PlatformWebViewControllerCreationParams _optimisedParams() {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      return WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    }
    return const PlatformWebViewControllerCreationParams();
  }

  FutureOr<NavigationDecision> _onNavigationRequest(
      NavigationRequest request) async {
    if (!request.url.startsWith(redirectUri)) {
      return NavigationDecision.navigate;
    }
    final authService = ref.read(authServiceProvider);
    final uri = Uri.parse(request.url);
    final code = uri.queryParameters['code'];
    if (code != null) {
      final codeVerifier = widget.provider.codeVerifier;
      final result = await authService.loginWithOAuth2(
        widget.provider.name,
        code,
        codeVerifier,
      );

      ref.read(authStateNotifierProvider.notifier).setUser(result.data!);
      authService.userAuthSuccess(result.data!);

      goOnNextPage();
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void goOnNextPage() {
    Navigator.of(context).pop();
    showSnackBar(context, 'Connexion reussie');
    GrowingScreenWidget.navigateTo(context);
  }

  @override
  void initState() {
    super.initState();
    final PlatformWebViewControllerCreationParams params = _optimisedParams();
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    final provider = widget.provider;
    final initalUrl = buildUrlFromProvider(provider);
    _controller = controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        "Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.5195.124 Mobile Safari/537.36",
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) => _onNavigationRequest(request),
        ),
      )
      ..loadRequest(Uri.parse(initalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          decoration: bottomSheetDecoration(),
          height: MediaQuery.of(context).size.height * 0.8,
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
