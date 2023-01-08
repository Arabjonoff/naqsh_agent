import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

import '../../bloc/agent/agent_bloc.dart';
import '../../dialog/add_agent_type/agent_type_dialog.dart';
import '../../dialog/add_agent_type/agent_type_list.dart';
import '../../model/http_result.dart';
import '../../provider/repository.dart';
import '../../utils/utils.dart';
import '../../widget/button/ontap_widget.dart';
import '../../widget/textfield/textfield_widget.dart';

class AddAgentScreen extends StatefulWidget {
  const AddAgentScreen({Key? key}) : super(key: key);

  @override
  State<AddAgentScreen> createState() => _AddAgentScreenState();
}

class _AddAgentScreenState extends State<AddAgentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sumUzsController = TextEditingController();
  TextEditingController usdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController controller = TextEditingController();

  var data = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AgentTypeDialog.showAddAgentTypeDialog(context);
              },
              icon: Icon(Icons.add_circle_outline_rounded)),
        ],
        elevation: 0,
        foregroundColor: AppTheme.black24,
        backgroundColor: AppTheme.background,
      ),
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0 * h, vertical: 10 * h),
                  child: Text(
                    'Kontr agent',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: data,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2090),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData(
                                dialogTheme: const DialogTheme(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                primaryColor: Colors.blue,
                                colorScheme: const ColorScheme.light(
                                    primary: AppTheme.purple),
                                buttonTheme: const ButtonThemeData(
                                    textTheme: ButtonTextTheme
                                        .primary), // This will change to light theme.
                              ),
                              child: child!,
                            );
                          });
                      if (newDate == null) return;
                      setState(() => data = newDate);
                    },
                    child: TextFieldWidget(
                      controller: dateController,
                      icon: 'assets/icons/calendar.svg',
                      hint: '${data.year}/${data.month}/${data.day}',
                      enables: false,
                    )),
                TextFieldWidget(
                    controller: nameController,
                    icon: 'assets/icons/profile.svg',
                    hint: 'Ismi'),
                TextFieldWidget(
                  controller: phoneController,
                  icon: 'assets/icons/call.svg',
                  hint: 'Tel',
                  type: true,
                ),
                TextFieldWidget(
                    controller: sumUzsController,
                    icon: 'assets/icons/sum.svg',
                    hint: 'Summa uzs',
                    type: true),
                TextFieldWidget(
                    controller: usdController,
                    icon: 'assets/icons/sum.svg',
                    hint: 'Summa usd',
                    type: true),
                GestureDetector(
                    onTap: () {
                      AgentTypeListDialog.showAgentTypeListDialog(context);
                    },
                    child: TextFieldWidget(
                      controller: controller,
                      icon: 'assets/icons/category.svg',
                      hint: 'Agent turi',
                      enables: false,
                    )),
                TextFieldWidget(
                    controller: commentController,
                    icon: 'assets/icons/message.svg',
                    hint: 'Izoh'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 32.0 * w),
            child: OnTapWidget(
                title: 'Davom etish',
                onTap: () async {
                  Repository repository = Repository();
                  HttpResult response = await repository.addClients(
                      nameController.text,
                      surnameController.text,
                      phoneController.text,
                      sumUzsController.text,
                      usdController.text,
                      '${data.year}/${data.month}/${data.day}',
                      commentController.text);
                  if (response.result["status"] == "ok") {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    agentBloc.getClients();
                  }
                }),
          )
        ],
      ),
    );
  }
}
