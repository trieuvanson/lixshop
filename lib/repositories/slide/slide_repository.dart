import 'dart:convert';

import 'package:lixshop/models/models.dart';
import 'package:lixshop/repositories/repositories.dart';

class SlideRepository extends AbstractRepository {
  final String thisUrl = "/datas/tintuc";

  Future<List<Slide>>? getSlides() async {
    final response = await get(url: mainUrl! + thisUrl);
    final entity = jsonDecode(response.data)['tintucs'];
    List<Slide> slides = [];
    for (var item in entity) {
      slides.add(Slide.fromMap(item));
    }
    return slides;
  }
}

final slideRepository = SlideRepository();
