class Datum {
  String? from;
  String? to;
  Intensity? intensity;

  Datum({this.from, this.to, this.intensity});

  Datum.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    intensity = json['intensity'] != null
        ? Intensity?.fromJson(json['intensity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['from'] = from;
    data['to'] = to;
    data['intensity'] = intensity!.toJson();
    return data;
  }
}

class Intensity {
  int? forecast;
  int? actual;
  String? index;

  Intensity({this.forecast, this.actual, this.index});

  Intensity.fromJson(Map<String, dynamic> json) {
    forecast = json['forecast'];
    actual = json['actual'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['forecast'] = forecast;
    data['actual'] = actual;
    data['index'] = index;
    return data;
  }
}

// class Root {
//   List<Datum?>? data;

//   Root({this.data});

//   Root.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Datum>[];
//       json['data'].forEach((v) {
//         data!.add(Datum.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['data'] = data != null ? data!.map((v) => v?.toJson()).toList() : null;
//     return data;
//   }

