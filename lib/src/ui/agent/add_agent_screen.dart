import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/bloc/category/category_bloc.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

import '../../bloc/agent/agent_bloc.dart';
import '../../dialog/add_agent_type/agent_type_dialog.dart';
import '../../model/category/category_model.dart';
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
  bool _loading = false;
  bool type = false;
  String agentType = 'Agent turi';
  int agentId = 0;

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
                      setState(() => type = !type);
                      categoryBloc.getCategories();
                    },
                    child: TextFieldWidget(
                      controller: controller,
                      icon: 'assets/icons/category.svg',
                      hint: agentType,
                      enables: false,
                    )),
                if (type)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20 * w),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: StreamBuilder<List<CategoryModel>>(
                        stream: categoryBloc.getCategory,
                        builder: (context, snapshot) {

                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      onTap: () {
                                        agentType = snapshot.data![index].name;
                                        agentId = snapshot.data![index].id;
                                        setState(() => type = false);
                                      },
                                      title: Text(snapshot.data![index].name),
                                      trailing: IconButton(
                                        onPressed: () {
                                          Repository r = Repository();
                                          r.categoryDelete(agentId = snapshot.data![index].id);
                                          setState(() => type = false);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ));
                                });
                          }
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        }),
                  )
                else
                  const SizedBox(),
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
                loading: _loading,
                title: 'Davom etish',
                onTap: () async {
                  setState(() => _loading = true);
                  Repository repository = Repository();
                  HttpResult response = await repository.addClients(
                      nameController.text,
                      surnameController.text,
                      phoneController.text,
                      sumUzsController.text,
                      usdController.text,
                      '${data.year}/${data.month}/${data.day}',
                      commentController.text,
                    agentId,
                  );
                  if (response.result["status"] == "ok") {
                    setState(() => _loading = false);
                    // ignore: use_build_context_synchronously
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      behavior: SnackBarBehavior.floating,
                      dismissDirection: DismissDirection.down,
                      content: AwesomeSnackbarContent(
                        title: "Xatolik",
                        message: "Nimadur xato qaytadan urinib koring",
                        contentType: ContentType.success,
                        inMaterialBanner: false,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context)
                      ..hideCurrentMaterialBanner()
                      ..showSnackBar(snackBar);
                    agentBloc.getClients();
                  } else {
                    setState(() => _loading = false);
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      behavior: SnackBarBehavior.floating,
                      dismissDirection: DismissDirection.down,
                      content: AwesomeSnackbarContent(
                        title: "Xatolik",
                        message: "Nimadur xato qaytadan urinib koring",
                        contentType: ContentType.failure,
                        inMaterialBanner: false,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context)
                      ..hideCurrentMaterialBanner()
                      ..showSnackBar(snackBar);
                  }
                }),
          )
        ],
      ),
    );
  }
}
