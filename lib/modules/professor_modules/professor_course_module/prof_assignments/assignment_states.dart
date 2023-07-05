import '../../../../models/course_model/prof_add_assignment.dart';
import '../../../../models/course_model/prof_get_assignment.dart';

abstract class AssignmentStates{}
class AssignmentInitialState extends AssignmentStates{}
class AssignmentChangeState extends AssignmentStates{}
class AssignmentUploadState extends AssignmentStates{}
class AssignmentOpenState extends AssignmentStates{}

class ProfAddAssignmentLoading extends AssignmentStates{}
class ProfAddAssignmentSuccess extends AssignmentStates{
late final ProfAddAssignment? profAddAssignment;
ProfAddAssignmentSuccess(this.profAddAssignment);
}
class ProfAddAssignmentError extends AssignmentStates{
  final String error;
  ProfAddAssignmentError(this.error);
}

