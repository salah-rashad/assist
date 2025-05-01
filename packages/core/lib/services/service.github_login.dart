import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assist_core/services/service.connection.dart';

typedef OnAuthCodeReceived =
    void Function(String userCode, String verificationUri);
typedef OnSessionTimeout = void Function();
typedef OnSessionCompleted = void Function(String accessToken);
typedef OnSessionError = void Function(String error);

class GithubLoginSession {
  final String clientId;
  final Duration timeoutDuration;
  OnAuthCodeReceived? onAuthCodeReceived;
  OnSessionCompleted? onSessionCompleted;
  OnSessionTimeout? onSessionTimeout;
  OnSessionError? onSessionError;

  final HttpClient _httpClient = HttpClient();
  Timer? _timeoutTimer;
  bool _isCancelled = false;
  bool _isActive = false;

  GithubLoginSession({
    required this.clientId,
    this.timeoutDuration = const Duration(minutes: 10),
  });

  Future<void> start() async {
    if (_isActive && !_isCancelled) {
      onSessionError?.call('Session already running.');
      return;
    }
    _isActive = true;

    final isConnected = InternetConnectionService.isConnected();
    if (!await isConnected) {
      onSessionError?.call('No internet connection.');
      _cancelInternal();
      return;
    }

    try {
      final deviceData = await _requestDeviceCode();
      if (deviceData == null) {
        onSessionError?.call('Failed to get device code.');
        return;
      }

      // Notify app to show user code + URI
      onAuthCodeReceived?.call(
        deviceData['user_code'],
        deviceData['verification_uri'],
      );

      // Start timeout timer
      _timeoutTimer = Timer(timeoutDuration, () {
        _cancelInternal();
        onSessionTimeout?.call();
      });

      // Start polling
      final token = await _pollForAccessToken(
        deviceData['device_code'],
        deviceData['interval'],
      );

      if (token != null) {
        _cleanup();
        onSessionCompleted?.call(token);
      } else if (!_isCancelled) {
        // If polling ended without cancel, treat as error
        onSessionError?.call('Failed to obtain access token.');
      }
    } on TimeoutException {
      _cancelInternal();
      onSessionError?.call('⏱️ Network timeout. Please check your connection.');
    } catch (e) {
      if (!_isCancelled) {
        _cancelInternal();
        onSessionError?.call('Exception: $e');
      }
    }
  }

  Future<Map<String, dynamic>?> _requestDeviceCode() async {
    print('🔑 Requesting device code...');
    final uri = Uri.parse('https://github.com/login/device/code');
    final request = await _httpClient.postUrl(uri);

    request.headers.contentType = ContentType(
      'application',
      'x-www-form-urlencoded',
    );
    request.headers.set('Accept', 'application/json');
    request.write('client_id=$clientId&scope=read:user repo');

    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      return json.decode(body);
    } else {
      return null;
    }
  }

  Future<String?> _pollForAccessToken(String deviceCode, int interval) async {
    final uri = Uri.parse('https://github.com/login/oauth/access_token');

    while (!_isCancelled) {
      print('🔑 Polling for access token...');
      await Future.delayed(Duration(seconds: interval));
      if (_isCancelled) break;

      final request = await _httpClient.postUrl(uri);
      request.headers.contentType = ContentType(
        'application',
        'x-www-form-urlencoded',
      );
      request.headers.set('Accept', 'application/json');
      request.write(
        'client_id=$clientId&device_code=$deviceCode&grant_type=urn:ietf:params:oauth:grant-type:device_code',
      );

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      final data = json.decode(body);

      if (data.containsKey('access_token')) {
        return data['access_token'];
      } else if (data['error'] == 'authorization_pending') {
        continue;
      } else {
        // If the error is not pending, stop
        print('Login error: ${data['error_description']}');
        return null;
      }
    }

    return null;
  }

  void cancel() {
    _cancelInternal();
    onSessionError?.call('🛑 Session manually cancelled.');
  }

  void _cancelInternal() {
    _isCancelled = true;
    _timeoutTimer?.cancel();
  }

  void _cleanup() {
    _timeoutTimer?.cancel();
    _httpClient.close();
    _isActive = false;
  }
}
