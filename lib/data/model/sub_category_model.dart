import 'package:my_ecommerce_admin/data/model/category_model.dart';

class SubCategoryModel {
  int? subcatId;
  String? subcatName;
  String? subcatNameAr;
  String? subcatDesc;
  String? subcatDescAr;
  String? subcatImageUrl;
  int? catId;

  SubCategoryModel(
      {this.subcatId,
      this.subcatName,
      this.subcatNameAr,
      this.subcatDesc,
      this.subcatDescAr,
      this.subcatImageUrl,
      this.catId});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    subcatId = json['subcat_id'];
    print(subcatId);
    subcatName = json['subcat_name'];
    subcatNameAr = json['subcat_name_ar'];
    subcatDesc = json['subcat_desc'];
    subcatDescAr = json['subcat_desc_ar'];
    subcatImageUrl = json['subcat_imageUrl'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcat_id'] = this.subcatId;
    data['subcat_name'] = this.subcatName;
    data['subcat_name_ar'] = this.subcatNameAr;
    data['subcat_desc'] = this.subcatDesc;
    data['subcat_desc_ar'] = this.subcatDescAr;
    data['subcat_imageUrl'] = this.subcatImageUrl;
    data['cat_id'] = this.catId;
    return data;
  }

  CategoryModel toCategoryModel() {
    return CategoryModel(
        catDesc: this.subcatDesc, catId: this.catId, catName: this.subcatName);
  }
}
