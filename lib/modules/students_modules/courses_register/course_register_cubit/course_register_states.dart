abstract class CourseRegesterStates{}

class CourseRegisterInitialState extends CourseRegesterStates{}

class CourseRegisterChangeBottomNavstate extends CourseRegesterStates{}

class CourseRegesterLoadingState extends CourseRegesterStates{}
class CourseRegesterSuccessState extends CourseRegesterStates{}
class CourseRegesterErrorState extends CourseRegesterStates{
  final String error;
  CourseRegesterErrorState(this.error);
}

class SubmitCourseRegesterLoadingState extends CourseRegesterStates{}
class SubmitCourseRegesterSuccessState extends CourseRegesterStates{}
class SubmitCourseRegesterErrorState extends CourseRegesterStates{
  final String error;
  SubmitCourseRegesterErrorState(this.error);
}

class Tapped extends CourseRegesterStates{}

class CourseRegisterSelectedState extends CourseRegesterStates{}
class CourseRegisterUnSelectedState extends CourseRegesterStates{}