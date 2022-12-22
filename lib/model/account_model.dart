class Account {
  String id;
  String userName;
  String selfIntroduction;
  List? favorite;

  Account(
      {required this.id,
      required this.userName,
      required this.selfIntroduction,
      this.favorite});
}

class CompanyAccount {
  String? id;
  String companyName;
  String number;
  String comment;

  CompanyAccount(
      {this.id,
      required this.companyName,
      required this.number,
      required this.comment});
}
