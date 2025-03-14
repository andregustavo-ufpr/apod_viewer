import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';

void main(){
  late Apod sut;
  setUp((){
    sut = Apod.fromMap({
      "date": "2025-02-02",
      "explanation": "TEST",
      "hdurl": "test",
      "media_type": "image",
      "service_version": "v1",
      "title": "TEST",
      "url": "test"
    });
  });

  test('date should return a Datetime object or null', (){
    expect(sut.date, isA<DateTime?>());
  });
  test('explanation should return a string or null', (){
    expect(sut.explanation, isA<String?>());
  });
  test('highResUrl should return a string or null', (){
    expect(sut.highResUrl, isA<String?>());
  });
  test('imageUrl should return a string or null', (){
    expect(sut.imageUrl, isA<String?>());
  });
  test('mediaType should return a string or null', (){
    expect(sut.mediaType, isA<String?>());
  });
  test('title should return a string or null', (){
    expect(sut.title, isA<String?>());
  });
  test('copyrightName should return a string without \n', (){
    sut.copyright = "\n";

    expect(sut.copyrightName!.contains("\n"), false);
  });

  test("toMap should return a Map", (){
    expect(sut.toMap(), isA<Map<String, dynamic>>());
  });

  test('fromMap should create a new apod', (){
    Apod _test = Apod.fromMap({"date": "2025-01-01"});

    expect(_test, isA<Apod>());
  });
  
}