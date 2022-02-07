abstract class SetupService {
  final String baseUrl;
  final int connectTimeOut;
  final int receiveTimeOut;
  final Map<String, dynamic> headers;

  SetupService(this.baseUrl, this.connectTimeOut, this.receiveTimeOut, this.headers);
}