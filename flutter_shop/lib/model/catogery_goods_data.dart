class CatogeryGoodsData {
  String code;
  String message;
  List<DataListBean> data;

  CatogeryGoodsData({this.code, this.message, this.data});

  CatogeryGoodsData.fromJson(Map<String, dynamic> json) {    
    this.code = json['code'];
    this.message = json['message'];
    this.data = (json['data'] as List)!=null?(json['data'] as List).map((i) => DataListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data != null?this.data.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class DataListBean {
  String image;
  String goodsName;
  String goodsId;
  double oriPrice;
  double presentPrice;

  DataListBean({this.image, this.goodsName, this.goodsId, this.oriPrice, this.presentPrice});

  DataListBean.fromJson(Map<String, dynamic> json) {    
    this.image = json['image'];
    this.goodsName = json['goodsName'];
    this.goodsId = json['goodsId'];
    this.oriPrice = json['oriPrice'];
    this.presentPrice = json['presentPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    return data;
  }
}
