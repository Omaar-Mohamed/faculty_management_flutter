import 'package:flutter/material.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../layout/professor_general/professor_general.dart';

class ProfessorCourseDetailScreen extends StatelessWidget {
  const ProfessorCourseDetailScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: ProfessorGeneral(),
      body: Center(child: Text("Professor Course Details Screen")),
    );
  }
}
