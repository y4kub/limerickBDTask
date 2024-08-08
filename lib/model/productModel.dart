class ProductModel {
  ProductModel({
    required this.id,
    required this.code,
    required this.name,
    required this.unitId,
    required this.price,
    required this.type,
    required this.categoryId,

    required this.unitName,
    required this.unitQty,
    required this.categoryName,
    required this.stockQty,
  });
    final int id;
    final String code;
    final String name;
    final int unitId;
    final String price;
    final String type;
    final int categoryId;

    final String unitName;
    final String unitQty;
    final String categoryName;
    final String stockQty;

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
        id : json['id'],
        code : json['code'],
        name : json['name'],
        unitId : json['unit_id'],
        price : json['price'],
        type : json['type'],
        categoryId : json['category_id'],


        unitName : json['unit_name'],
        unitQty : json['unit_qty'],
        categoryName : json['category_name'],
        stockQty : json['stockQty'],
        );
  }

  // Map<String; dynamic> toJson() {
  //   final _data : <String; dynamic>{};
  //   _data['id'] : id;
  //   _data['code'] : code;
  //   _data['name'] : name;
  //   _data['unit_id'] : unitId;
  //   _data['price'] : price;
  //   _data['secondary_price'] : secondaryPrice;
  //   _data['pack_size'] : packSize;
  //   _data['stock'] : stock;
  //   _data['type'] : type;
  //   _data['category_id'] : categoryId;
  //   _data['unit_supply'] : unitSupply;
  //   _data['unit_supply_qty'] : unitSupplyQty;
  //   _data['unit_name'] : unitName;
  //   _data['unit_qty'] : unitQty;
  //   _data['category_name'] : categoryName;
  //   _data['stockQty'] : stockQty;
  //   return _data;
  // }
}