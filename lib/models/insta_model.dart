class InstaModel {
  List<String> data;
  bool success;

  InstaModel({this.data, this.success});

  InstaModel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    return data;
  }
}