import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:marika_client/helpers/utils.dart' as utils;
import 'dart:async';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:marika_client/services/entities/user_info.dart';
import 'package:marika_client/services/local_storage.dart';
import 'package:path/path.dart';
import 'dart:convert';

class FileInfo {
  final File file;
  final String field;
  
  FileInfo({@required this.file, @required this.field});
}

abstract class BaseApi <T>{
  static final _authority = "54.238.187.122";
  static final _subPath = "/api/";
  static final s3Url = "https://s3-ap-southeast-1.amazonaws.com/shasket-staging/";

  // predefine method
  Future<T> get({Map<String, String> header, Map<String, String> query, bool needToken = false}) async{
    print("GET Start - " + apiUrl());

    Uri uri = Uri.http(_authority, _subPath + apiUrl(), query);
    Response response = await http.get(
      uri,
      headers: _buildHeader(header, needToken),
    ).timeout(const Duration(seconds: 20));
    var result = _responseHandle(response);
    print("GET End - " + apiUrl());
    return result;
  }

  Future<T> post({Map<String, String> header, Map<String, dynamic> body, bool needToken = false}) async{
    print("POST Start - " + apiUrl());

    Uri uri = Uri.http(_authority, _subPath + apiUrl());
    String stringBody = body == null ? "": json.encode(body);

    Map<String, String> candidateHeader = Map();
    if (header != null) {
      candidateHeader.addAll(header);
    }
    candidateHeader.addAll({"Content-Type":"application/json",});

    Response response = await http.post(
      uri,
      headers: _buildHeader(candidateHeader, needToken),
      body: stringBody,
    ).timeout(const Duration(seconds: 20));
    var result = _responseHandle(response);
    print("POST End - " + apiUrl());
    return result;
  }

  Future<T> patch({Map<String, String> header, Map<String, dynamic> body, bool needToken = false}) async{
    print("PATCH Start - " + apiUrl());

    Uri uri = Uri.http(_authority, _subPath + apiUrl());
    String stringBody = body == null ? "": json.encode(body);
    Map<String, String> candidateHeader = Map();
    if (header != null) {
      candidateHeader.addAll(header);
    }
    candidateHeader.addAll({"Content-Type":"application/json",});

    Response response = await http.patch(
      uri,
      headers: _buildHeader(candidateHeader, needToken),
      body: stringBody,
    ).timeout(const Duration(seconds: 20));
    var result = _responseHandle(response);
    print("PATCH End - " + apiUrl());
    return result;
  }

  Future<T> upload({@required List<FileInfo> files, Map<String, String> header, bool needToken = false}) async{
    print("UPLOAD Start - " + apiUrl());

    Uri uri = Uri.http(_authority, _subPath + apiUrl());
    var request = MultipartRequest("POST", uri)
      ..headers.addAll(_buildHeader(header, needToken));

    for (FileInfo fileInfo in files) {
      String fileName = basename(fileInfo.file.path);
      MediaType type = MediaType.parse(utils.getMediaType(fileName));
      request.files.add(
          MultipartFile(
              fileInfo.field,
              fileInfo.file.openRead(),
              await fileInfo.file.length(),
              filename: fileName,
              contentType: type,
          )
      );
    }

    StreamedResponse streamedResponse = await request.send().timeout(const Duration(seconds: 20));
    Response response = await Response.fromStream(streamedResponse);
    var result = _responseHandle(response);
    print("UPLOAD End - " + apiUrl());
    return result;
  }

  // predefine method
  Future<T> delete({Map<String, String> header, Map<String, String> query, bool needToken = false}) async{
    print("DELETE Start - " + apiUrl());

    Uri uri = Uri.http(_authority, _subPath + apiUrl(), query);
    Response response = await http.delete(
      uri,
      headers: _buildHeader(header, needToken),
    ).timeout(const Duration(seconds: 20));
    var result = _responseHandle(response);
    print("DELETE End - " + apiUrl());
    return result;
  }

  // utility methods
  Map<String, String> _buildHeader(Map<String, String> header, bool needToken) {
    Map<String, String> candidateHeader = Map();
    if (header != null) {
      candidateHeader.addAll(header);
    }
    if (needToken) {
      String token = LocalStorage().getInfo<UserInfo>().id;
      if (token == null) {
        throw Exception("${apiUrl()} error: have no token");
      }
      else {
        candidateHeader.addAll({"Authorization":token,});
      }
    }
    return candidateHeader;
  }

  Future<T> _responseHandle(Response response) {
    if (response.statusCode == 400 || response.statusCode == 401) {
      throw Exception("Authentication failed");
    }
    if (response.statusCode < 200 || response.statusCode > 401) {
      throw Exception(json.decode(response.body)["error"]["message"]);
    }
    return responseParse(response.body);
  }

  // abstract methods
  String apiUrl();
  Future<T> responseParse(String body);
}