class CartInfo {
  String goodsId;
  String goodsName;
  String img;
  double price;
  double prePrice;
  int count;

  CartInfo({this.goodsId, this.goodsName, this.img, this.price,this.prePrice, this.count});

  CartInfo.fromJson(Map<String, dynamic> json) {
    this.goodsId = json['goodsId'];
    this.goodsName = json['goodsName'];
    this.img = json['img'];
    this.price = json['price'];
    this.prePrice = json['prePrice'];
    this.count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['img'] = this.img;
    data['price'] = this.price;
    data['prePrice'] = this.prePrice;
    data['count'] = this.count;
    return data;
  }
}


