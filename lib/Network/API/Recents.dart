import 'package:dio/dio.dart';
import 'package:park_locator/Model/DBModels/Recent.dart';
import '../Dio_helper.dart';
import '../endpoints.dart';

Future<int> addRecent(Map recent, String token) async {
  Response response;
  await DioHelper.postData(url: AddBookMark, data: recent, token: token)
      .then((value) {
    response=value;  })
      .catchError((onError) {response.statusCode;}
  );
  return response.statusCode;
}

Future<Recent> getHistory(String driverID, String token) async
{
  Recent history= new Recent();
  Response response =await DioHelper.getData(url: getRecent+'?id=$driverID', token: token);
    if(response.data !=null)
    {
      history = Recent.fromJson(response.data);
    }

  return history;
}

Future<int> deleteRecent(String id, String token)
async {
  Dio dio = new Dio();
  String url = "http://164.92.174.146/";
  dio.options.headers = {"Authorization": 'Bearer $token'};
  Response response = await dio.delete(url+"Recent/delete?id=$id");
  return response.statusCode;
}

Future<int> clearHistory(String id, String token)
async {
  Dio dio = new Dio();
  String url = "http://164.92.174.146/";
  dio.options.headers = {"Authorization": 'Bearer $token'};
  Response response = await dio.delete(url+"clear_driver_history?driverID=$id");
  return response.statusCode;
}

