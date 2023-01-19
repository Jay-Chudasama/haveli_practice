class ProductModel{

  String _title,_discountPrice,_price,_image;
  int _quantity;

  ProductModel(this._title, this._discountPrice, this._price, this._image,
      this._quantity);

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  get image => _image;

  set image(value) {
    _image = value;
  }

  get price => _price;

  set price(value) {
    _price = value;
  }

  get discountPrice => _discountPrice;

  set discountPrice(value) {
    _discountPrice = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  void add(){
    _quantity++;
  }

  void subtract(){
    _quantity--;
  }
}