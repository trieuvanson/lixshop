class CategoryFilter {
  double id;
  String name;
  bool? isSelected;

  CategoryFilter(
      {required this.id, required this.name, this.isSelected = false});

  //copyWith
  CategoryFilter copyWith({double? id, String? name, bool? isSelected}) {
    return CategoryFilter(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  //to String
  @override
  String toString() {
    return 'CategoryFilter {id: $id, name: $name, isSelected: $isSelected}';
  }
}
