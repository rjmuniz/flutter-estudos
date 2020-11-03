import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request:${data.method} ${data.url}, headers: ${data.headers}, body: ${data.body}');

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async{
    print('Response: ${data.statusCode}, headers: ${data.headers}, body: ${data.body}');
    return data;
  }
}
