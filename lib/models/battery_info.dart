class HealthInfo {
  int _id;
  int _capacity;
  String _date;

  HealthInfo(this._capacity, this._date);

  HealthInfo.withId(this._id, this._capacity, this._date);

  int get id => _id;

  int get capacity => _capacity;

  String get date => _date;

  set capacity(int newCapacity) {
    this._capacity = newCapacity;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['capacity'] = _capacity;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  HealthInfo.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._capacity = map['capacity'];
    this._date = map['date'];
  }
}
