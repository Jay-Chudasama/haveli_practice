class TodoModel{

  late String _task,_symbol;
  bool _completed = false;

  TodoModel(this._task){
    generateSymbol();
  }


  String get task => _task;

  void generateSymbol(){
    _symbol = _task[0];
  }


  set completed(bool value) {
    _completed = value;
  }

  get symbol => _symbol;

  bool get completed => _completed;
}