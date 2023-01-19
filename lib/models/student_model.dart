class StudentModel{

  final String _name,_dob,_semester,_phone;
  final bool _present;

  StudentModel(this._name, this._dob, this._semester, this._phone, this._present);

  bool get present => _present;

  get phone => _phone;

  get semester => _semester;

  get dob => _dob;

  String get name => _name;
}