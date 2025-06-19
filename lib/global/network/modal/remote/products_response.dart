class ProductsResponse {
  List<ProductData>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsResponse({this.products, this.total, this.skip, this.limit});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductData>[];
      json['products'].forEach((v) {
        products!.add(ProductData.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

class ProductData {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  String? returnPolicy;
  int? minimumOrderQuantity;
  List<String>? images;
  String? thumbnail;

  ProductData({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    rating = json['rating'];
    stock = json['stock'];
    tags = json['tags'].cast<String>();
    brand = json['brand'];
    sku = json['sku'];
    weight = json['weight'];

    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];

    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];
    images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['rating'] = rating;
    data['stock'] = stock;
    data['tags'] = tags;
    data['brand'] = brand;
    data['sku'] = sku;
    data['weight'] = weight;
    data['warrantyInformation'] = warrantyInformation;
    data['shippingInformation'] = shippingInformation;
    data['availabilityStatus'] = availabilityStatus;

    data['returnPolicy'] = returnPolicy;
    data['minimumOrderQuantity'] = minimumOrderQuantity;
    data['images'] = images;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
