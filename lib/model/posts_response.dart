class PostResponse {
  EventLocation? eventLocation;
  String? sId;
  String? userId;
  String? description;
  String? title;
  List<String>? image;
  List<String>? tags;
  List<Null>? likedUsers;
  String? eventCategory;
  String? eventStartAt;
  String? eventEndAt;
  String? eventId;
  bool? registrationRequired;
  List<Null>? registration;
  String? eventDescription;
  int? likes;
  List<Null>? comments;
  String? createdAt;
  int? iV;

  PostResponse(
      {this.eventLocation,
        this.sId,
        this.userId,
        this.description,
        this.title,
        this.image,
        this.tags,
        this.likedUsers,
        this.eventCategory,
        this.eventStartAt,
        this.eventEndAt,
        this.eventId,
        this.registrationRequired,
        this.registration,
        this.eventDescription,
        this.likes,
        this.comments,
        this.createdAt,
        this.iV});

  PostResponse.fromJson(Map<String, dynamic> json) {
    eventLocation = json['eventLocation'] != null
        ? new EventLocation.fromJson(json['eventLocation'])
        : null;
    sId = json['_id'];
    userId = json['userId'];
    description = json['description'];
    title = json['title'];
    image = json['image'].cast<String>();
    tags = json['tags'].cast<String>();
    if (json['likedUsers'] != null) {
      likedUsers = <Null>[];
      json['likedUsers'].forEach((v) {
        likedUsers!.add(new Null.fromJson(v));
      });
    }
    eventCategory = json['eventCategory'];
    eventStartAt = json['eventStartAt'];
    eventEndAt = json['eventEndAt'];
    eventId = json['eventId'];
    registrationRequired = json['registrationRequired'];
    if (json['registration'] != null) {
      registration = <Null>[];
      json['registration'].forEach((v) {
        registration!.add(new Null.fromJson(v));
      });
    }
    eventDescription = json['eventDescription'];
    likes = json['likes'];
    if (json['comments'] != null) {
      comments = <Null>[];
      json['comments'].forEach((v) {
        comments!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventLocation != null) {
      data['eventLocation'] = this.eventLocation!.toJson();
    }
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['description'] = this.description;
    data['title'] = this.title;
    data['image'] = this.image;
    data['tags'] = this.tags;
    if (this.likedUsers != null) {
      data['likedUsers'] = this.likedUsers!.map((v) => v.toJson()).toList();
    }
    data['eventCategory'] = this.eventCategory;
    data['eventStartAt'] = this.eventStartAt;
    data['eventEndAt'] = this.eventEndAt;
    data['eventId'] = this.eventId;
    data['registrationRequired'] = this.registrationRequired;
    if (this.registration != null) {
      data['registration'] = this.registration!.map((v) => v.toJson()).toList();
    }
    data['eventDescription'] = this.eventDescription;
    data['likes'] = this.likes;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class EventLocation {
  String? type;
  List<double>? coordinates;

  EventLocation({this.type, this.coordinates});

  EventLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
