import 'package:http/http.dart' as http;
class ApiRequest{
  static getRequest(String url)async{
    var response = await http.get(Uri.parse(url));
    print("URL: $url");
    print("RESPONSE: ${response.body}");
    return response;
  }
}