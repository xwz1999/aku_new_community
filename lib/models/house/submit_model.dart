import 'dart:io';

class SubmitModel {
  int id;
  String emergencyContact;
  String emergencyContactNumber;
  String correspondenceAddress;
  String workUnits;
  String payBank;
  String bankAccountName;
  String bankAccount;
  List<String> idCardFrontImgUrl;
  List<String> idCardBackImgUrl;
  File? idCardFrontFile;
  File? idCardBackFile;

  SubmitModel({
    required this.id,
    required this.emergencyContact,
    required this.emergencyContactNumber,
    required this.correspondenceAddress,
    required this.workUnits,
    required this.payBank,
    required this.bankAccountName,
    required this.bankAccount,
    required this.idCardFrontImgUrl,
    required this.idCardBackImgUrl,
    required this.idCardFrontFile,
    required this.idCardBackFile,
  });

  factory SubmitModel.init() => SubmitModel(
      id: 0,
      emergencyContact: '',
      emergencyContactNumber: '',
      correspondenceAddress: '',
      workUnits: '',
      payBank: '',
      bankAccountName: '',
      bankAccount: '',
      idCardFrontImgUrl: [],
      idCardBackImgUrl: [],
      idCardBackFile: null,
      idCardFrontFile: null);
}
