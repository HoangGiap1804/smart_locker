import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_locker/module/profile/models/profile_model.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProfileModel> getUserInfo(String id) async{
    String username = ""; 
    String password = ""; 

    String pincode = "";
    String address = "";
    String city = "";
    String state = "";
    String country = "";
 
    String bankAccountNumber = "";
    String accountHolderName = "";
    String ifscCode = "";
    try{
      DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('users') 
      .doc(id)
      .get();

      if (doc.exists) {
        Map<String, dynamic>? userData = doc.data() as Map<String, dynamic>?;
         username = userData!['username'];
         password = userData['password'];

         pincode = userData['pincode'];
         address = userData['address'];
         city = userData['city'];
         state = userData['state'];
         country = userData['country'];

         bankAccountNumber = userData['bankAccountNumber'];
         accountHolderName = userData['accountHolderName'];
         ifscCode = userData['ifscCode'];

      } else {
        print("User không tồn tại!");
      }

    }catch (e) {
      print(e);
    }
    return ProfileModel(
      id: id,
      username: username, 
      password: password, 
      pincode: pincode, 
      address: address, 
      city: city, 
      state: state, 
      country: country, 
      bankAccountNumber: bankAccountNumber, 
      accountHolderName: accountHolderName, 
      ifscCode: ifscCode
    );
  }

  Future<String> UpdateInfo(ProfileModel profileModel) async {
    String res = "error";
    try {

      // add user to cloud firestore
      await _firestore.collection("users").doc(profileModel.id).set({
        'username': profileModel.username,
        'password': profileModel.password,
        'pincode': profileModel.pincode,
        'address': profileModel.address,
        'city': profileModel.city,
        'state': profileModel.state,
        'country': profileModel.country,
        'bankAccountNumber': profileModel.bankAccountNumber,
        'accountHolderName': profileModel.accountHolderName,
        'ifscCode': profileModel.ifscCode,
      });


      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
