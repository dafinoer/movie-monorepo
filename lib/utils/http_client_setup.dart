import 'package:repository_services/setup_service.dart';

class HttpClientSetup extends SetupService {
  HttpClientSetup._(String baseUrl, int connectTimeOut, int receiveTimeOut,
      Map<String, dynamic> headers)
      : super(
          baseUrl,
          connectTimeOut,
          receiveTimeOut,
          headers,
        );

  factory HttpClientSetup.dev() {
    const baseUrl = 'imdb8.p.rapidapi.com';
    return HttpClientSetup._(
      'https://$baseUrl',
      5000,
      5000,
      {
        'x-rapidapi-host': baseUrl,
        'x-rapidapi-key': '2ba9fc0247msh03a00937f091574p1d2bd1jsn2b5dbc8f848b',
      },
    );
  }
}
