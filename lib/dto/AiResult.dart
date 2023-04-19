class AiResult {
  int? code;
  String? message;
  Data? data;

  AiResult({this.code, this.message, this.data});

  AiResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Artifacts>? artifacts;

  Data({this.artifacts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['artifacts'] != null) {
      artifacts = <Artifacts>[];
      json['artifacts'].forEach((v) {
        artifacts!.add(new Artifacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artifacts != null) {
      data['artifacts'] = this.artifacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artifacts {
  String? base64;
  int? seed;
  String? finishReason;

  Artifacts({this.base64, this.seed, this.finishReason});

  Artifacts.fromJson(Map<String, dynamic> json) {
    base64 = json['base64'];
    seed = json['seed'];
    finishReason = json['finishReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base64'] = this.base64;
    data['seed'] = this.seed;
    data['finishReason'] = this.finishReason;
    return data;
  }
}