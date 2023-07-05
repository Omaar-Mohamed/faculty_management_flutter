import 'package:sms_flutter/models/course_model/SubmitAssignment.dart';
import 'package:sms_flutter/models/course_model/assignments_model.dart';
import 'package:sms_flutter/models/course_model/delete_assignment.dart';
import 'package:sms_flutter/models/course_model/get_tags_model.dart';
import 'package:sms_flutter/models/course_model/prof_add_material_model.dart';
import 'package:sms_flutter/models/course_model/prof_course_model.dart';
import 'package:sms_flutter/models/course_model/prof_upload_material_model.dart';

import '../../../../models/course_model/assignment_detail_model.dart';
import '../../../../models/course_model/course_model.dart';
import '../../../../models/course_model/prof_assignment_detial_model.dart';
import '../../../../models/course_model/prof_get_assignment.dart';
import '../../../../models/course_model/student_course_material_model.dart';
import '../../../../models/course_model/tag_material_model.dart';

abstract class CourseStates{}

class CourseInitialState extends CourseStates{}

class CourseLoadingState extends CourseStates{}

class CourseSuccessState extends CourseStates{
  late final CourseModel? courseModel;
  CourseSuccessState(this.courseModel);
}

class CourseErrorState extends CourseStates{
  final String error;
  CourseErrorState(this.error);
}

class StudentCourseMaterialLoadingState extends CourseStates{}

class StudentCourseMaterialSuccessState extends CourseStates{
  late final StudentCourseMaterialModel? studentCourseMaterialModel;
  StudentCourseMaterialSuccessState(this.studentCourseMaterialModel);
}

class StudentCourseMaterialErrorState extends CourseStates{
  final String error;
  StudentCourseMaterialErrorState(this.error);
}

class TagLoadingState extends CourseStates{}
class TagSuccessState extends CourseStates{
  late final TagsModel? tagsModel;
  TagSuccessState(this.tagsModel);
}
class TagErrorState extends CourseStates{
  final String error;
  TagErrorState(this.error);
}

class TagMaterialLoadingState extends CourseStates{}
class TagMaterialSuccessState extends CourseStates{
  late final TagMaterialModel? tagMaterialModel;
  TagMaterialSuccessState(this.tagMaterialModel);
}
class TagMaterialErrorState extends CourseStates{
  final String error;
  TagMaterialErrorState(this.error);
}

class AssignmentsLoadingState extends CourseStates{}
class AssignmentsSuccessState extends CourseStates{
  late final AssignmentsModel? assignmentsModel;
  AssignmentsSuccessState(this.assignmentsModel);
}
class AssignmentsErrorState extends CourseStates{
  final String error;
  AssignmentsErrorState(this.error);
}

class AssignmentDetailLoadingState extends CourseStates{}
class AssignmentDetailSuccessState extends CourseStates{
  late final AssignmentDetailModel? assignmentDetailModel;
  AssignmentDetailSuccessState(this.assignmentDetailModel);
}
class AssignmentDetailErrorState extends CourseStates{
  final String error;
  AssignmentDetailErrorState(this.error);
}

class SubmitAssignmentLoadingState extends CourseStates{}
class SubmitAssignmentSuccessState extends CourseStates{
  late final SubmitAssignment? submitAssignmentModel;
  SubmitAssignmentSuccessState(this.submitAssignmentModel);
}
class SubmitAssignmentErrorState extends CourseStates{
  final String error;
  SubmitAssignmentErrorState(this.error);
}

class ProfCourseLoadingState extends CourseStates{}
class ProfCourseSuccessState extends CourseStates{
  late final ProfCourseModel? profCourseModel;
  ProfCourseSuccessState(this.profCourseModel);
}
class ProfCourseErrorState extends CourseStates{
  final String error;
  ProfCourseErrorState(this.error);
}

class ProfCourseMaterialTagsLoadingState extends CourseStates{}
class ProfCourseMaterialTagsSuccessState extends CourseStates{
  late final TagsModel? tagsModel;
  ProfCourseMaterialTagsSuccessState(this.tagsModel);
}
class ProfCourseMaterialTagsErrorState extends CourseStates{
  final String error;
  ProfCourseMaterialTagsErrorState(this.error);
}
class ProfUploadFileLoadingState extends CourseStates{}
class ProfUploadFileSuccessState extends CourseStates{
  late final ProfUploadFileModel? profUploadFileModel;
  ProfUploadFileSuccessState(this.profUploadFileModel);
}
class ProfUploadFileErrorState extends CourseStates{
   final String error;
  ProfUploadFileErrorState(this.error);
}

class ProfGetAssignmentLoadingState extends CourseStates{}
class ProfGetAssignmentSuccessState extends CourseStates{
  late final ProfGetAssignment? assignmentsModel;
  ProfGetAssignmentSuccessState(this.assignmentsModel);
}
class ProfGetAssignmentErrorState extends CourseStates{
  final String error;
  ProfGetAssignmentErrorState(this.error);
}

class ProfAddAssignmentLoading extends CourseStates{}
class ProfAddAssignmentSuccess extends CourseStates{
  late final ProfGetAssignment? assignmentsModel;
  ProfAddAssignmentSuccess(this.assignmentsModel);
}
class ProfAddAssignmentError extends CourseStates{
  final String error;
  ProfAddAssignmentError(this.error);
}

class ProfDeleteAssignmentLoading extends CourseStates{}
class ProfDeleteAssignmentSuccess extends CourseStates{
  late final DeleteAssignment? deleteAssignment;
  ProfDeleteAssignmentSuccess(this.deleteAssignment);
}
class ProfDeleteAssignmentError extends CourseStates{
  final String error;
  ProfDeleteAssignmentError(this.error);
}
class ProfGetAssignmentDetailLoading extends CourseStates{}
class ProfGetAssignmentDetailSuccess extends CourseStates{
  late final ProfGetAssignmentDetail? profGetAssignmentDetail;
  ProfGetAssignmentDetailSuccess(this.profGetAssignmentDetail);
}
class ProfGetAssignmentDetailError extends CourseStates{
  final String error;
  ProfGetAssignmentDetailError(this.error);
}

class ProfAddTagLoadingState extends CourseStates{}
class ProfAddTagSuccessState extends CourseStates{
  // late final TagsModel? tagsModel;
  // ProfAddTagSuccessState(this.tagsModel);
}
class ProfAddTagErrorState extends CourseStates{
  final String error;
  ProfAddTagErrorState(this.error);
}

class profAddLectureMaterialLoadingState extends CourseStates{}
class profAddLectureMaterialSuccessState extends CourseStates{
  late final ProfAddMaterialModel? profAddMaterialModel;
  profAddLectureMaterialSuccessState(this.profAddMaterialModel);
}
class profAddLectureMaterialErrorState extends CourseStates{
  final String error;
  profAddLectureMaterialErrorState(this.error);
}

class profAddSectionMaterialLoadingState extends CourseStates{}
class profAddSectionMaterialSuccessState extends CourseStates{
  late final ProfAddMaterialModel? profAddMaterialModel;
  profAddSectionMaterialSuccessState(this.profAddMaterialModel);
}
class profAddSectionMaterialErrorState extends CourseStates{
  final String error;
  profAddSectionMaterialErrorState(this.error);
}
class StudentGetSectionMaterialLoadingState extends CourseStates{}
class StudentGetSectionMaterialSuccessState extends CourseStates{
  // late final StudentGetSectionMaterialModel? studentGetSectionMaterialModel;
  // StudentGetSectionMaterialSuccessState(this.studentGetSectionMaterialModel);
}
class StudentGetSectionMaterialErrorState extends CourseStates{
  final String error;
  StudentGetSectionMaterialErrorState(this.error);
}

class ProfAddSectionTagLoadingState extends CourseStates{}
class ProfAddSectionTagSuccessState extends CourseStates{
  // late final TagsModel? tagsModel;
  // ProfAddSectionTagSuccessState(this.tagsModel);
}
class ProfAddSectionTagErrorState extends CourseStates{
  final String error;
  ProfAddSectionTagErrorState(this.error);
}
class StudentGetMaterialSecionLoadingState extends CourseStates{}
class StudentGetMaterialSecionSuccessState extends CourseStates{
  // late final StudentGetMaterialSectionModel? studentGetMaterialSectionModel;
  // StudentGetMaterialSecionSuccessState(this.studentGetMaterialSectionModel);
}
class StudentGetMaterialSecionErrorState extends CourseStates{
  final String error;
  StudentGetMaterialSecionErrorState(this.error);
}
