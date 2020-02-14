class ChuckCategory {
  final List<String> categories;

  ChuckCategory({this.categories});

  factory ChuckCategory.fromJson(List<dynamic> json) {
    return ChuckCategory(
      categories: json != null ? List<String>.from(json) : null,
    );
  }

  List<dynamic> toJson() {
    List<dynamic> data = List();
    if (this.categories != null) {
      data = this.categories;
    }
    return data;
  }
}
