import 'models.dart';

class HeroModel {
  String? response;
  int? id;
  String? name;
  Powerstats? powerstats;
  Biography? biography;
  Appearance? appearance;
  Work? work;
  Connections? connections;
  Image? images;
  String? error;

  HeroModel(
      {this.response,
      this.id,
      this.name,
      this.powerstats,
      this.biography,
      this.appearance,
      this.work,
      this.connections,
      this.images,
      this.error});

  HeroModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] ?? "error";

    id = json['id'];
    name = json['name'];
    powerstats = json['powerstats'] != null
        ? new Powerstats.fromJson(json['powerstats'])
        : null;
    biography = json['biography'] != null
        ? new Biography.fromJson(json['biography'])
        : null;
    appearance = json['appearance'] != null
        ? new Appearance.fromJson(json['appearance'])
        : null;
    work = json['work'] != null ? new Work.fromJson(json['work']) : null;
    connections = json['connections'] != null
        ? new Connections.fromJson(json['connections'])
        : null;
    images = json['images'] != null ? new Image.fromJson(json['images']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.powerstats != null) {
      data['powerstats'] = this.powerstats?.toJson();
    }
    if (this.biography != null) {
      data['biography'] = this.biography?.toJson();
    }
    if (this.appearance != null) {
      data['appearance'] = this.appearance?.toJson();
    }
    if (this.work != null) {
      data['work'] = this.work?.toJson();
    }
    if (this.connections != null) {
      data['connections'] = this.connections?.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images?.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}
