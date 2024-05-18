class UserProfileDataEntities{
   
  final int id;
  final String email;
  final String fullName;
  final String bio;
  final String profileImageUrl;
  final String coverPhotoUrl;
  final int followers;
  final int following;

  UserProfileDataEntities({
    required this.id,
    required this.email,
    required this.fullName,
    required this.bio,
    required this.profileImageUrl,
    required this.coverPhotoUrl,
    required this.followers,
    required this.following,
  });
}