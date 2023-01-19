class StudentModel{

  String _name,_dob,_phone,_semester,_image;
  bool _present;

  StudentModel(this._name, this._dob, this._phone, this._semester, this._image,this._present);


  bool get present => _present;

  get image => _image;

  get semester => _semester;

  get phone => _phone;

  get dob => _dob;

  String get name => _name;

  set present(bool value) {
    _present = value;
  }
}