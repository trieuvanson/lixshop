// class Product {
//   final int? id;
//   final String? title;
//   final String? img;
//   final double? price;
//   final double? rating;
//   final String? type;
//
// //<editor-fold desc="Data Methods">
//
//   Product({
//     this.id,
//     this.title,
//     this.img,
//     this.price,
//     this.rating,
//     this.type,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is Product &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           title == other.title &&
//           img == other.img &&
//           price == other.price &&
//           rating == other.rating &&
//           type == other.type);
//
//   @override
//   int get hashCode =>
//       id.hashCode ^
//       title.hashCode ^
//       img.hashCode ^
//       price.hashCode ^
//       rating.hashCode ^
//       type.hashCode;
//
//   @override
//   String toString() {
//     return 'Product{' +
//         ' id: $id,' +
//         ' title: $title,' +
//         ' img: $img,' +
//         ' price: $price,' +
//         ' rating: $rating,' +
//         ' type: $type,' +
//         '}';
//   }
//
//   Product copyWith({
//     int? id,
//     String? title,
//     String? img,
//     double? price,
//     double? rating,
//     String? type,
//   }) {
//     return Product(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       img: img ?? this.img,
//       price: price ?? this.price,
//       rating: rating ?? this.rating,
//       type: type ?? this.type,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'img': img,
//       'price': price,
//       'rating': rating,
//       'type': type,
//     };
//   }
//
//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: int.parse(map['id']),
//       title: map['title'] as String,
//       img: map['img'] as String,
//       price: double.parse(map['price']),
//       rating: double.parse(map['rating']),
//       type: map['type'] as String,
//     );
//   }
// //</editor-fold>
// }
