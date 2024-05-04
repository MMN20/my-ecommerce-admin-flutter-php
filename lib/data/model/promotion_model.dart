class PromotionModel {
  int? promotionsId;
  String? promotionsTitle;
  String? promotionsBody;
  String? promotionsImageUrl;

  PromotionModel(
      {this.promotionsId,
      this.promotionsTitle,
      this.promotionsBody,
      this.promotionsImageUrl});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    promotionsId = json['promotions_id'];
    promotionsTitle = json['promotions_title'];
    promotionsBody = json['promotions_body'];
    promotionsImageUrl = json['promotions_imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promotions_id'] = this.promotionsId;
    data['promotions_title'] = this.promotionsTitle;
    data['promotions_body'] = this.promotionsBody;
    data['promotions_imageUrl'] = this.promotionsImageUrl;
    return data;
  }
}
