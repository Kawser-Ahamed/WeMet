
class UserEntities{
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String fullName;
  final String bio;
  final String profileImageUrl;
  final String coverPhotoUrl;
  final int followers;
  final int following;

  UserEntities({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.bio,
    required this.profileImageUrl,
    required this.coverPhotoUrl,
    required this.followers,
    required this.following,
  });
}
