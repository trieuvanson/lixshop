import 'product_slide_dto.dart';

class Slide {
  String? title;
  String? imageUrl;
  ProductSlideDTO? sanpham;
  String? type;
  String? content;
  bool? slide;
  String? date;

  Slide({
    this.title,
    this.imageUrl,
    this.sanpham,
    this.type,
    this.content,
    this.slide,
    this.date,
  });

  factory Slide.fromMap(Map<String, dynamic> json) => Slide(
        title: json["tieude"],
        imageUrl: json["urlhinh"],
        sanpham: json["sanpham"] != null
            ? ProductSlideDTO.fromMap(json["sanpham"])
            : null,
        type: json["loaitin"],
        content: json["noidung"],
        slide: json["slide"],
        date: json["ngay"],

      );

  Map<String, dynamic> toMap() => {
        "tieude": title,
        "urlhinh": imageUrl,
        "sanpham": sanpham,
        "loaitin": type,
        "noidung": content,
        "slide": slide,
        "ngay": date,
      };
}
