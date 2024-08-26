class CategoryModel {
  final String name;
  final List<CategoryModel>? subCategories;

  CategoryModel({required this.name, this.subCategories});
}
