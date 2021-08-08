import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserSessionController extends GetxController {
  Map<String, String> _cookies = {};
  Map<String, String> _headers = {'Accept': 'application/json, text/plain, */*', 'Host': 'www.funsport101.com', 'Origin': 'https://www.funsport101.com'};
  var login = false.obs;

  void updateSession(http.Response resp) {
    if (!resp.headers.containsKey('set-cookie')) {
      return;
    }

    var setCookies = resp.headers['set-cookie']!.split(',');

    for (var setCookie in setCookies) {
      var cookies = setCookie.split(';');

      for (var cookie in cookies) {
        _setCookie(cookie);
      }
    }

    _headers['cookie'] = _generateCookieHeader();
    login.value = _isLogin();
  }

  void clearSession() {
    _cookies.clear();
    _headers.remove('cookie');
    login.value = _isLogin();
  }

  bool _isLogin() {
    return _headers.containsKey('cookie') && _cookies.length > 0;
  }

  Map<String, String> getSessionHeaders() {
    return _headers;
  }

  String _generateCookieHeader() {
    String cookie = '';

    for (var key in _cookies.keys) {
      if (cookie.length > 0) cookie += ';';
      cookie += key + '=' + _cookies[key]!;
    }

    return cookie;
  }

  void _setCookie(String rawCookie) {

    if (rawCookie.length > 0 && rawCookie.contains('=')) {
      var indexOf = rawCookie.indexOf('=');
      var key = rawCookie.substring(0, indexOf).trim();
      var value = rawCookie.substring(indexOf + 1);
      // ignore keys that aren't cookies
      if (key.toLowerCase() == 'path'
          || key.toLowerCase() == 'expires'
          || key.toLowerCase() == 'domain'
      ) return;

      this._cookies[key] = value;
    }
  }
}
