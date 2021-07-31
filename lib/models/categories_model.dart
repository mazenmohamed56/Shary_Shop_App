class CategoriesModel {
  bool status;
  CategoryModel data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryModel.fromJson(json['data']);
  }
}

class CategoryModel {
  int currentPage;
  List<CategoryDataModel> categories = [];
  CategoryModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      categories.add(CategoryDataModel.fromJson(element));
    });
  }
}

class CategoryDataModel {
  int id;
  String name;
  String image;
  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
