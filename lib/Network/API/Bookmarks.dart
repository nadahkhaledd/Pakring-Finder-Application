import 'package:dio/dio.dart';
import 'package:park_locator/Network/Dio_helper.dart';
import '../../Model/DBModels/Bookmark.dart';
import '../endpoints.dart';


Dio dio = new Dio();
String url = "http://164.92.174.146/";

Future<List> getBookmarks( String driverID, String token) async
{
  List<Bookmark> bookmarks= [];
  Response response =await DioHelper.getData(url: url+"get_user_bookmark?driverID=$driverID", token: token);
  for(var element in response.data)
  {
    if(element !=null)
    {
      bookmarks.add(Bookmark.fromJson(element));
    }
  }
  return bookmarks;
}

Future<int> deleteBookmark(String id, String token)
async {

  dio.options.headers = {"Authorization": 'Bearer $token'};
  Response response = await dio.delete(url+"Bookmark/delete?id=$id");
  return response.statusCode;
}

Future<int> addBookmark(Bookmark bookmark, String token) async {
  Response response;
  await DioHelper.postData(url: AddBookMark, data: bookmark.toJson(), token: token)
      .then((value) {
        response=value;  })
      .catchError((onError) {response.statusCode;}
  );
  return response.statusCode;
}

Future<int> clearDriverBookmarks(String id, String token)
async {
  dio.options.headers = {"Authorization": 'Bearer $token'};
  Response response = await dio.delete(url+"clear_driver_bookmark?driverID=$id");
  return response.statusCode;
}
