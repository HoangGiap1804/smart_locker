class CategoryModel {
  String nameCategory;
  String pathImage;

  CategoryModel({
    required this.nameCategory,
    required this.pathImage,
  });

  static List<CategoryModel> getCategoryModel(){
    List<CategoryModel> list = [];

    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Beauty"));
    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Fashion"));
    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Kids"));
    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Man"));
    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Woman"));
    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Beauty"));
    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Beauty"));
    list.add(CategoryModel(pathImage: "assets/images/avata.jpg", nameCategory: "Beauty"));
    return list;
  }
} 
