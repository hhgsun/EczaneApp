import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference userRegister =
      Firestore.instance.collection("kullanici_kayitlari");

  Future<void> addRegister(String deviceid, String marka, String model) async {
    var register = await userRegister.document(deviceid).get();
    var data = {
      'toplamAcma': FieldValue.increment(1),
      'marka': marka,
      'model': model,
    };
    if (register.exists) {
      await userRegister.document(deviceid).updateData(data);
    } else {
      await userRegister.document(deviceid).setData(data);
    }
  }

}
