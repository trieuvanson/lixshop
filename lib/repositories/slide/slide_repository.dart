import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lixshop/models/models.dart';
import 'package:lixshop/repositories/repositories.dart';

class SlideRepository extends AbstractRepository {
  final String thisUrl = "/datas/tintuc";

  Future<List<Slide>>? getSlides() async {
    List<Slide> slides = [];
    try {
      final response = await get(url: mainUrl! + thisUrl);
      final entity = jsonDecode(response.data)['tintucs'];
      for (var item in entity) {
        slides.add(Slide.fromMap(item));
      }
      return slides;
    } on DioError catch (e) {
      return slides;
    } catch (e) {
      print('error: $e');
    }
    return slides;
  }
}

final slideRepository = SlideRepository();
