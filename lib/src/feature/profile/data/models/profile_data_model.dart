import 'package:flutter/foundation.dart';

@immutable
class ProfileDataModel {
  final int id;
  final String empId;
  final String fullname;
  final String fullnameEn;
  final String fullnameBn;
  final String fathersName;
  final String mothersName;
  final String gender;
  final String nid;
  final String email;
  final String mobileNo;
  final String dateOfBirth;
  final int instituteId;
  final String managementType;
  final int designationId;
  final int subjectId;
  final int emisWorkstationId;
  final int workstationTypeId;
  final int paycodeId;
  final String levelName;
  final bool isTeacher;
  final bool isMpo;
  final int indexNumber;
  final int zoneId;
  final int divisionId;
  final int districtId;
  final int upazilaId;
  final bool isActive;
  final String emisToken;
  final String type;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const ProfileDataModel({
    required this.id,
    required this.empId,
    required this.fullname,
    required this.fullnameEn,
    required this.fullnameBn,
    required this.fathersName,
    required this.mothersName,
    required this.gender,
    required this.nid,
    required this.email,
    required this.mobileNo,
    required this.dateOfBirth,
    required this.instituteId,
    required this.managementType,
    required this.designationId,
    required this.subjectId,
    required this.emisWorkstationId,
    required this.workstationTypeId,
    required this.paycodeId,
    required this.levelName,
    required this.isTeacher,
    required this.isMpo,
    required this.indexNumber,
    required this.zoneId,
    required this.divisionId,
    required this.districtId,
    required this.upazilaId,
    required this.isActive,
    required this.emisToken,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        id: json["id"] ?? -1,
        empId: json["emp_id"] ?? "",
        fullname: json["fullname"] ?? "",
        fullnameEn: json["fullname_en"] ?? "",
        fullnameBn: json["fullname_bn"] ?? "",
        fathersName: json["fathers_name"] ?? "",
        mothersName: json["mothers_name"] ?? "",
        gender: json["gender"] ?? "",
        nid: json["nid"] ?? "",
        email: json["email"] ?? "",
        mobileNo: json["mobile_no"] ?? "",
        dateOfBirth: json["date_of_birth"]??"",
        instituteId: json["institute_id"] ?? -1,
        managementType: json["management_type"],
        designationId: json["designation_id"] ?? -1,
        subjectId: json["subject_id"] ?? -1,
        emisWorkstationId: json["emis_workstation_id"] ?? -1,
        workstationTypeId: json["workstation_type_id"] ?? -1,
        paycodeId: json["paycode_id"] ?? -1,
        levelName: json["level_name"] ?? "",
        isTeacher: json["is_teacher"] ?? false,
        isMpo: json["is_mpo"] ?? false,
        indexNumber: json["index_number"] ?? -1,
        zoneId: json["zone_id"] ?? -1,
        divisionId: json["division_id"] ?? -1,
        districtId: json["district_id"] ?? -1,
        upazilaId: json["upazila_id"] ?? -1,
        isActive: json["is_active"] ?? false,
        emisToken: json["emis_token"] ?? "",
        type: json["type"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        deletedAt: json["deleted_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_id": empId,
        "fullname": fullname,
        "fullname_en": fullnameEn,
        "fullname_bn": fullnameBn,
        "fathers_name": fathersName,
        "mothers_name": mothersName,
        "gender": gender,
        "nid": nid,
        "email": email,
        "mobile_no": mobileNo,
        "date_of_birth": dateOfBirth,
        "institute_id": instituteId,
        "management_type": managementType,
        "designation_id": designationId,
        "subject_id": subjectId,
        "emis_workstation_id": emisWorkstationId,
        "workstation_type_id": workstationTypeId,
        "paycode_id": paycodeId,
        "level_name": levelName,
        "is_teacher": isTeacher,
        "is_mpo": isMpo,
        "index_number": indexNumber,
        "zone_id": zoneId,
        "division_id": divisionId,
        "district_id": districtId,
        "upazila_id": upazilaId,
        "is_active": isActive,
        "emis_token": emisToken,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
