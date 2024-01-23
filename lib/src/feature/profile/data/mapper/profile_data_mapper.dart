import '../../domain/entities/profile_data_entity.dart';
import '../models/profile_data_model.dart';

abstract class ProfileDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ProfileDataModelToEntityMapper
    extends ProfileDataMapper<ProfileDataModel, ProfileDataEntity> {
  @override
  ProfileDataModel fromEntityToModel(ProfileDataEntity entity) {
    return ProfileDataModel(
        id: entity.id,
        empId: entity.empId,
        fullname: entity.fullname,
        fullnameEn: entity.fullnameEn,
        fullnameBn: entity.fullnameBn,
        fathersName: entity.fathersName,
        mothersName: entity.mothersName,
        gender: entity.gender,
        nid: entity.nid,
        email: entity.email,
        mobileNo: entity.mobileNo,
        dateOfBirth: entity.dateOfBirth,
        instituteId: entity.instituteId,
        managementType: entity.managementType,
        designationId: entity.designationId,
        subjectId: entity.subjectId,
        emisWorkstationId: entity.emisWorkstationId,
        workstationTypeId: entity.workstationTypeId,
        paycodeId: entity.paycodeId,
        levelName: entity.levelName,
        isTeacher: entity.isTeacher,
        isMpo: entity.isMpo,
        indexNumber: entity.indexNumber,
        zoneId: entity.zoneId,
        divisionId: entity.divisionId,
        districtId: entity.districtId,
        upazilaId: entity.upazilaId,
        isActive: entity.isActive,
        emisToken: entity.emisToken,
        type: entity.type,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        deletedAt: entity.deletedAt);
  }

  @override
  ProfileDataEntity toEntityFromModel(ProfileDataModel model) {
    return ProfileDataEntity(
        id: model.id,
        empId: model.empId,
        fullname: model.fullname,
        fullnameEn: model.fullnameEn,
        fullnameBn: model.fullnameBn,
        fathersName: model.fathersName,
        mothersName: model.mothersName,
        gender: model.gender,
        nid: model.nid,
        email: model.email,
        mobileNo: model.mobileNo,
        dateOfBirth: model.dateOfBirth,
        instituteId: model.instituteId,
        managementType: model.managementType,
        designationId: model.designationId,
        subjectId: model.subjectId,
        emisWorkstationId: model.emisWorkstationId,
        workstationTypeId: model.workstationTypeId,
        paycodeId: model.paycodeId,
        levelName: model.levelName,
        isTeacher: model.isTeacher,
        isMpo: model.isMpo,
        indexNumber: model.indexNumber,
        zoneId: model.zoneId,
        divisionId: model.divisionId,
        districtId: model.districtId,
        upazilaId: model.upazilaId,
        isActive: model.isActive,
        emisToken: model.emisToken,
        type: model.type,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        deletedAt: model.deletedAt);
  }
}

extension ProfileDataModelExt on ProfileDataModel {
  ProfileDataEntity get toProfileDataEntity =>
      _ProfileDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProfileDataEntityExt on ProfileDataEntity {
  ProfileDataModel get toProfileDataModel =>
      _ProfileDataModelToEntityMapper().fromEntityToModel(this);
}
