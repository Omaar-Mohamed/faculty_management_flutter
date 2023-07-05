import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_flutter/layout/appbar_cubit/appbar_states.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../layout/appbar_cubit/appbar_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppbarCubit()..getNotification(),
      child: BlocConsumer<AppbarCubit,AppBarStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var cubit = AppbarCubit.get(context);
          return Scaffold(
            appBar: projectAppBar(context),
            body: ConditionalBuilder(
              condition: AppbarCubit.get(context).notificationModel?.data! != null,
              builder: (BuildContext context) {
                return ListView.builder(
                itemCount: cubit.notificationModel?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return NotificationItem(
                    title: cubit.notificationModel!.data![index].title,
                    subtitle: cubit.notificationModel!.data![index].description,
                    // date: cubit.notificationModel!.data![index].createdAt,
                    date:DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(cubit.notificationModel!.data![index].createdAt!)),
                    isRead: cubit.notificationModel!.data![index].read!, // alternate between read and unread
                  );
                },
              );
              },
              fallback: (BuildContext context) => Center(child: CircularProgressIndicator())

            ),
          );
        },

      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? date;
  final bool isRead;

  NotificationItem({
     this.title,
     this.subtitle,
     this.date,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isRead ? Colors.grey : Colors.blue,
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
      title: Text(title!, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle!),
      trailing: Text(date!),
      onTap: () {
        // handle notification item tap
      },
    );
  }
}
