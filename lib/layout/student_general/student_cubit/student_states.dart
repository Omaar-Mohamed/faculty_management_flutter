
import '../../../models/student_drawer_sections/student_drawer_section.dart';

abstract class StudentStates{}

class StudentInitialState extends StudentStates{}

class ChangeDrawerSection extends StudentStates{}

class StudentInSchedualeState extends StudentStates{}

class StudentInCoursesState extends StudentStates{}

class StudentInCommunityState extends StudentStates{}

class StudentInReportState extends StudentStates{}

class StudentInCourseRegisterState extends StudentStates{}

class StudentInMeetingsRegisterState extends StudentStates{}

class StudentInPaymentState extends StudentStates{}

class StudentInSettingsState extends StudentStates{}

class StudentInLogOutState extends StudentStates{}

class ChangeDrawerColor extends StudentStates{}

class StudentChangeDrawerSectionState extends StudentStates {
  final DrawerSections section;
  final int currentPage;

  StudentChangeDrawerSectionState({required this.section, required this.currentPage});
}
