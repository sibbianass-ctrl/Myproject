// import '../enums/space_type.dart';

// class UserInfoService {
//   //Private static instance of the singleton
//   static final UserInfoService _instance = UserInfoService._internal();

//   //Private named constructor
//   UserInfoService._internal();

//   //Factory constructor to return the singleton instance
//   factory UserInfoService() {
//     return _instance;
//   }

//   //Properties for storing user information
//   String id = '';
//   String tecId = '';
//   String userFullName = '';
//   String username = '';
//   String responsableName = '';
//   String responsablePhoneNumber = '';
//   SpaceType spaceType = SpaceType.unknown;

//   String enterpriseId = '';

//   //Method to set user information
//   void setUserInfo({
//     required String id,
//     required String userFullName,
//     required String username,
//     required String responsableName,
//     required String responsablePhoneNumber,
//   }) {
//     this.id = id;
//     this.userFullName = userFullName;
//     this.username = username;
//     this.responsableName = responsableName;
//     this.responsablePhoneNumber = responsablePhoneNumber;
//   }

//   //Method to clear user information
//   void clearUserInfo() {
//     id = '';
//     userFullName = '';
//     username = '';
//     responsableName = '';
//     responsablePhoneNumber = '';
//   }

//   void fromJson(data) {
//     id = data['id'];
//     userFullName = data['firstName'] + ' ' + data['lastName'];
//     username = data['username'];
//     // responsableName = data['attributes']['responsableName'] ?? 'hhhh';
//     responsableName =
//         (data['attributes']['responsableName'] as List?)?.first ?? 'NULL';

//     responsablePhoneNumber =
//         (data['attributes']['responsablePhoneNumber'] as List?)?.first ??
//             'NULL';
//   }

//   void fromJsonEntreprise(data) {
//     // id = data['id'];
//     userFullName = data['name'];
//     username = 'ICE: ' + data['ice'] + ' - IFF: ' + data['iff'];
//   }

//   //ToString method to return user information as a string
//   @override
//   String toString() {
//     return 'UserInfoService(id: $id, userFullName: $userFullName, username: $username, role: ${spaceType.name})';
//   }
// }
import '../enums/space_type.dart';

class UserInfoService {
  //Private static instance of the singleton
  static final UserInfoService _instance = UserInfoService._internal();

  //Private named constructor
  UserInfoService._internal();

  //Factory constructor to return the singleton instance
  factory UserInfoService() {
    return _instance;
  }

  //Properties for storing user information
  String? token; // <-- AJOUTEZ CETTE LIGNE ICI
  String id = '';
  String tecId = '';
  String userFullName = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String responsableName = '';
  String responsablePhoneNumber = '';
  SpaceType spaceType = SpaceType.unknown;

  String enterpriseId = '';

  //Method to set user information
  void setUserInfo({
    required String id,
    required String userFullName,
    required String username,
    required String responsableName,
    required String responsablePhoneNumber,
    required String firstName,
    required String lastName,
    required String email,
  }) {
    this.id = id;
    this.userFullName = userFullName;
    this.username = username;
    this.responsableName = responsableName;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.responsablePhoneNumber = responsablePhoneNumber;
  }

  //Method to clear user information
  void clearUserInfo() {
    id = '';
    userFullName = '';
    username = '';
    responsableName = '';
    username = '';
    firstName = '';
    lastName = '';
    responsablePhoneNumber = '';
    token = null; // <-- Assurez-vous de le vider aussi au logout
  }

  void fromJson(data) {
    id = data['id'];
    userFullName = data['firstName'] + ' ' + data['lastName'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    email = data['email'];
    username = data['username'];
    // responsableName = data['attributes']['responsableName'] ?? 'hhhh';
    responsableName =
        (data['attributes']['responsableName'] as List?)?.first ?? 'NULL';

    responsablePhoneNumber =
        (data['attributes']['responsablePhoneNumber'] as List?)?.first ??
            'NULL';
  }

  void fromJsonEntreprise(data) {
    // id = data['id'];
    userFullName = data['name'];
    username = 'ICE: ' + data['ice'] + ' - IFF: ' + data['iff'];
  }

  //ToString method to return user information as a string
  @override
  String toString() {
    return 'UserInfoService(id: $id, userFullName: $userFullName, username: $username, role: ${spaceType.name})';
  }
}
