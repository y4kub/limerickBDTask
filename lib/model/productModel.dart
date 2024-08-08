class ProductModel {
  ProductModel({
    required this.id,
    required this.code,
    required this.name,
    required this.unitId,
    required this.price,
    required this.secondaryPrice,
    required this.packSize,
    required this.stock,
    required this.type,
    required this.categoryId,
    required this.unitSupply,
    required this.unitSupplyQty,
    required this.unitName,
    required this.unitQty,
    required this.categoryName,
    required this.stockQty,
  });
  late final int id;
  late final String code;
  late final String name;
  late final int unitId;
  late final String price;
  late final String secondaryPrice;
  late final String packSize;
  late final String stock;
  late final String type;
  late final int categoryId;
  late final int unitSupply;
  late final String unitSupplyQty;
  late final String unitName;
  late final String unitQty;
  late final String categoryName;
  late final String stockQty;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    code = json['code'];
    name = json['name'];
    unitId = json['unit_id'];
    price = json['price'];
    secondaryPrice = json['secondary_price'];
    packSize = json['pack_size'];
    stock = json['stock'];
    type = json['type'];
    categoryId = json['category_id'];
    unitSupply = json['unit_supply'];
    unitSupplyQty = json['unit_supply_qty'];
    unitName = json['unit_name'];
    unitQty = json['unit_qty'];
    categoryName = json['category_name'];
    stockQty = json['stockQty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['code'] = code;
    _data['name'] = name;
    _data['unit_id'] = unitId;
    _data['price'] = price;
    _data['secondary_price'] = secondaryPrice;
    _data['pack_size'] = packSize;
    _data['stock'] = stock;
    _data['type'] = type;
    _data['category_id'] = categoryId;
    _data['unit_supply'] = unitSupply;
    _data['unit_supply_qty'] = unitSupplyQty;
    _data['unit_name'] = unitName;
    _data['unit_qty'] = unitQty;
    _data['category_name'] = categoryName;
    _data['stockQty'] = stockQty;
    return _data;
  }
}