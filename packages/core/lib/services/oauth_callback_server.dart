import 'dart:io';

class OAuthCallbackServer {
  final int port;
  HttpServer? _server;
  void Function(String code)? onAuthCodeReceived;

  OAuthCallbackServer({this.port = 5000});

  Future<void> start() async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    print('🚀 OAuth Callback Server started at http://localhost:$port/');

    await for (HttpRequest request in _server!) {
      final uri = request.uri;

      if (uri.path == '/callback') {
        final code = uri.queryParameters['code'];
        // final state = uri.queryParameters['state'];

        if (code != null) {
          // Notify your app
          onAuthCodeReceived?.call(code);

          // Respond to the browser
          request.response
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.html
            ..write(
              '<html lang="en"><h1>Authentication successful! You can close this tab.</h1></html>',
            )
            ..close();

          // Optionally stop the server if you don't need it anymore
          await stop();
        } else {
          request.response
            ..statusCode = HttpStatus.badRequest
            ..write('Missing code in the callback URL.')
            ..close();
        }
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found')
          ..close();
      }
    }
  }

  Future<void> stop() async {
    await _server?.close(force: true);
    print('🛑 OAuth Callback Server stopped.');
  }
}
