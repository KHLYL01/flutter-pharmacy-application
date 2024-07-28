import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../functions/check_internet.dart';
import '../services/services.dart';
import 'status_request.dart';

class Crud {
  MyServices services = Get.find();

  Future<Either<StatusRequest, Map>> postDataWithoutToken(
      String link, Map data) async {
    try {
      if (await checkInternet()) {
        log('Start');
        var response = await http.post(
          Uri.parse(link),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json;charset=UTF-8',
          },
        );
        log(response.statusCode.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map body = jsonDecode(response.body);
          log('crud');
          return Right(body);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postData(String link, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(link),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json;charset=UTF-8',
            'Authorization': 'Bearer ${services.getToken()}'
          },
        );
        log(response.statusCode.toString());
        if (response.statusCode.toString() == '200' ||
            response.statusCode.toString() == '201') {
          Map<String, dynamic> body = jsonDecode(response.body);
          return Right(body);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      e.printInfo();
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postImage(
    String link,
    String imagePath,
  ) async {
    try {
      if (await checkInternet()) {
        var headers = {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer ${services.getToken()}'
        };
        var request = http.MultipartRequest('POST', Uri.parse(link));
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imagePath,
          // '/C:/Users/KHALYL/Pictures/23112345678.jpg',
        ));
        request.headers.addAll(headers);
        log('hi 2');
        http.StreamedResponse response = await request.send();

        log('hi 3');

        log(response.statusCode.toString());
        if (response.statusCode.toString() == '200' ||
            response.statusCode.toString() == '201') {
          Map<String, dynamic> body =
              jsonDecode(await response.stream.bytesToString());
          return Right(body);
        } else {
          log(response.reasonPhrase.toString());
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      e.printInfo();
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String link) async {
    try {
      if (await checkInternet()) {
        log('crud');
        var headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer ${services.getToken()}'
        };
        var response = await http.get(Uri.parse(link), headers: headers);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> body = jsonDecode(response.body);
          log('crud =====1====');
          return Right(body);
        } else {
          log(response.reasonPhrase.toString());
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      e.printInfo();
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, List>> getAllData(String link) async {
    try {
      if (await checkInternet()) {
        log('crud');
        var headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer ${services.getToken()}'
        };
        var response = await http.get(Uri.parse(link), headers: headers);
        if (response.statusCode == 200 || response.statusCode == 201) {
          List<dynamic> body = jsonDecode(response.body);
          log(body.toString());

          return Right(body);
        } else {
          log(response.reasonPhrase.toString());
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      e.printInfo();
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, String>> deleteData(String link) async {
    try {
      if (await checkInternet()) {
        log('crud');
        var headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer ${services.getToken()}'
        };
        var response = await http.delete(Uri.parse(link), headers: headers);
        if (response.statusCode == 204 || response.statusCode == 200) {
          return const Right("delete successfully");
        } else {
          log(response.reasonPhrase.toString());
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      e.printInfo();
      return const Left(StatusRequest.serverException);
    }
  }
}
