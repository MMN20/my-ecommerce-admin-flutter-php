class CategoryModel {
  int? catId;
  String? catName;
  String? catNameAr;
  String? catDesc;
  String? catDescAr;
  String? catImageUrl;

  CategoryModel(
      {this.catId,
      this.catName,
      this.catNameAr,
      this.catDesc,
      this.catDescAr,
      this.catImageUrl});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catNameAr = json['cat_name_ar'];
    catDesc = json['cat_desc'];
    catDescAr = json['cat_desc_ar'];
    catImageUrl = json['cat_imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_name_ar'] = this.catNameAr;
    data['cat_desc'] = this.catDesc;
    data['cat_desc_ar'] = this.catDescAr;
    data['cat_imageUrl'] = this.catImageUrl;
    return data;
  }
}
