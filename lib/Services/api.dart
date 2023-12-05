

import 'package:http/http.dart' as Http;

class API {
// static Future<GetPostVoidReasonResponse> callGetPostVoidReason(
//   int businessUnit, int serviceType, String? channel) async {
// var url = Uri.parse(POSOnlineGetPostVoidReasonAPIURL + "?business_unit=$businessUnit&service_type=$serviceType");

// try {
//   var deviceInfo = await getDeviceInfo();
//   UserToken? userToken = await checkTokenExpire(channel);

//   Map<String, String> headers = {
//     "Content-type": "application/json",
//     "charset": "UTF-16",
//     "Authorization": userToken!.accessToken.toString(),
//     "device_info" : json.encode(deviceInfo)
//   };
  


//   if(channel == 'posmobile'){
//     headers['user_token'] = userToken.userToken ?? "";
//   }
  
//   if (await _isAllowCertificate == false) {
//     throw "certificate not allow";
//   }

//   debugPrint("user_token => ${userToken.userToken}");
//   HttpClient _client = new HttpClient(context: await securityContext);

//   _client.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => true;

//   final _ioClient = new IOClient(_client);
//   var response = await _ioClient
//       .get(url,
//           headers: headers)
//       .timeout(Duration(seconds: timeout));

//   String vv = utf8.decode(response.bodyBytes);
//   Map<String,dynamic> map = json.decode(vv);
//   debugPrint('get post void reason =====> $vv');
//   GetPostVoidReasonResponse msg = GetPostVoidReasonResponse.fromJson(map);

//   _ioClient.close();
//   return msg;
// } on TimeoutException {
//   throw TimeoutException('call api timeout');
// } on Http.ClientException {
//   throw Http.ClientException('call api client exception');
// } catch (e) {
//   debugPrint(e.toString());
//   throw e;
// }
//   }
  }