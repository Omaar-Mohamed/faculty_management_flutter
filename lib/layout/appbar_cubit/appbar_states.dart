abstract class AppBarStates{}
class AppBarInitialState extends AppBarStates{}
class AppBarChangeState extends AppBarStates{}
class AppBarChangeIconState extends AppBarStates{}
class NotificationSuccessState extends AppBarStates{}
class NotificationErrorState extends AppBarStates{
  final String error;
  NotificationErrorState(this.error);
}
class NotificationLoadingState extends AppBarStates{}
