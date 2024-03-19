//  final String imageUrl = '$s3Endpoint/$fileName';

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

dynamic fileName;
dynamic s3Endpoint;

class ImageUpload {
  String url = ' https://app-development.s3.amazonaws.com/';
  String accessKey = ' accesskey';
  String secretKey = 'secretKey';
  String folder = 'FOLDER';
  String region = 'us-east-1';
  String bucketName = 'app-development';

  final String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<String?> uploadImageWeb(
    Uint8List data, {
    String? name,
    String? extension,
  }) async {
    fileName = name?.replaceAll(' ', '') ?? '${getRandomString(10)}';
    final length = data.length;

    s3Endpoint = 'https://${bucketName}.s3.${region}.amazonaws.com';

    final uri = Uri.parse(s3Endpoint);
    final req = http.MultipartRequest('POST', uri);
    final multipartFile = http.MultipartFile(
        'file', http.ByteStream.fromBytes(data), length,
        filename: fileName);

    final policy = Policy.fromS3PresignedPost(
        fileName, bucketName, accessKey, 15, length,
        region: region);
    final key =
        SigV4.calculateSigningKey(secretKey, policy.datetime, region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;

    try {
      await req.send();

      return '$fileName';
    } catch (e) {
      return '$fileName';
    }
  }
}

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize,
      {this.region = 'us-east-1'});

  factory Policy.fromS3PresignedPost(
    String key,
    String bucket,
    String accessKeyId,
    int expiryMinutes,
    int maxFileSize, {
    required String region,
  }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
        region: region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
{ "expiration": "$expiration",
  "conditions": [
    {"bucket": "$bucket"},
    ["starts-with", "\$key", "$key"],
    {"acl": "public-read"},
    ["content-length-range", 1, $maxFileSize],
    {"x-amz-credential": "$credential"},
    {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
    {"x-amz-date": "$datetime" }
  ]
}
''';
  }
}
