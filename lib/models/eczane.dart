class Eczane{
  final String adi;
  String tel;
  String ilce;
  String acikAdres;
  String enlem;
  String boylam;

  Eczane({
    this.adi,
    this.tel,
    this.ilce,
    this.acikAdres,
    this.enlem,
    this.boylam
  });

  factory Eczane.fromJson(Map<String,dynamic> res) {
    return Eczane(
      adi: res['name'] ?? '',
      tel: res['phone'] ?? '',
      ilce: res['dist'] ?? '',
      acikAdres: res['address'] ?? '',
      enlem: res['loc'] == '' ? '' : res['loc'].toString().split(',')[0],
      boylam: res['loc'] == '' ? '': res['loc'].toString().split(',')[1]
    );
  }

}