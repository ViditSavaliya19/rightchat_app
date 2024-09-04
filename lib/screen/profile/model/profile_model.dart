class ProfileModel {
  String? name, mobile, email, bio,uid;

  ProfileModel({this.name, this.mobile, this.email, this.bio,this.uid});

  factory ProfileModel.mapToModel(Map m1) {
    return ProfileModel(
      bio: m1['bio'],
      mobile: m1['mobile'],
      email: m1['email'],
      name: m1['name'],
      uid:m1['uid'],
    );
  }
}
