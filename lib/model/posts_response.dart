class PostResponse {
  EventLocation? eventLocation;
  String? sId;
  String? userId;
  String? description;
  String? title;
  List<String>? image;
  List<String>? tags;
  List<String>? likedUsers;
  String? eventCategory;
  String? eventStartAt;
  String? eventEndAt;
  String? eventId;
  bool? registrationRequired;
  List<String>? registration;
  String? eventDescription;
  int? likes;
  List<String>? comments;
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
        ? EventLocation.fromJson(json['eventLocation'])
        : null;
    sId = json['_id'];
    userId = json['userId'];
    description = json['description'];
    title = json['title'];
    image = json['image'] != null ? List<String>.from(json['image']) : null;
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    likedUsers = json['likedUsers'] != null ? List<String>.from(json['likedUsers']) : null;
    eventCategory = json['eventCategory'];
    eventStartAt = json['eventStartAt'];
    eventEndAt = json['eventEndAt'];
    eventId = json['eventId'];
    registrationRequired = json['registrationRequired'];
    registration = json['registration'] != null ? List<String>.from(json['registration']) : null;
    eventDescription = json['eventDescription'];
    likes = json['likes'];
    comments = json['comments'] != null ? List<String>.from(json['comments']) : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventLocation != null) {
      data['eventLocation'] = eventLocation!.toJson();
    }
    data['_id'] = sId;
    data['userId'] = userId;
    data['description'] = description;
    data['title'] = title;
    data['image'] = image;
    data['tags'] = tags;
    data['likedUsers'] = likedUsers;
    data['eventCategory'] = eventCategory;
    data['eventStartAt'] = eventStartAt;
    data['eventEndAt'] = eventEndAt;
    data['eventId'] = eventId;
    data['registrationRequired'] = registrationRequired;
    data['registration'] = registration;
    data['eventDescription'] = eventDescription;
    data['likes'] = likes;
    data['comments'] = comments;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class EventLocation {
  String? type;
  List<double>? coordinates;

  EventLocation({this.type, this.coordinates});

  EventLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'] != null ? List<double>.from(json['coordinates']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
