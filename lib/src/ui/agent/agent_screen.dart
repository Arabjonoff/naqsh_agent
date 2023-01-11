import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:naqsh_agent/src/bloc/agent/agent_bloc.dart';
import 'package:naqsh_agent/src/model/client/client_model.dart';
import 'package:naqsh_agent/src/ui/agent/add_agent_screen.dart';
import 'package:naqsh_agent/src/ui/agent/serach_screen.dart';
import 'package:naqsh_agent/src/widget/button/ontap_widget.dart';
import '../../bloc/category/category_bloc.dart';
import '../../model/category/category_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/utils.dart';
import '../bottom_menu/bottom_menu_screen.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({Key? key}) : super(key: key);

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  int agentId = 0;

  @override
  void initState() {
    agentBloc.getClients();
    super.initState();
  }
  @override
  void dispose() {
    agentBloc.getClients();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        elevation: 5,
        foregroundColor: AppTheme.black24,
        backgroundColor: AppTheme.white,
        centerTitle: true,
        title:const Text('Agentlar',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black),),
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SearchScreen();
            }));
          }, icon: const Icon(Icons.search_rounded)),
          Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset('assets/icons/filter.svg'),
              onPressed: () {
                categoryBloc.getCategories();
                Scaffold.of(context).openEndDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Center(child: Text('Filtr',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Turi boyich',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0 * w),
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
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
                                    agentId = snapshot.data![index].id;
                                  },
                                  title: Text(snapshot.data![index].name),
                              );
                            },);
                      }
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(child: OnTapWidget(title: 'Orqaga', onTap: (){
                    Navigator.pop(context);
                  },color: false,)),
                  Expanded(child: OnTapWidget(title: 'Qollash', onTap: (){})),
                ],
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ClientModel>>(
              stream: agentBloc.getClient,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<ClientModel> data = snapshot.data!;
                  return data.isNotEmpty?ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 20*h,horizontal: 20*h),
                          margin: EdgeInsets.symmetric(horizontal: 20*w,vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.white,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(4,15),
                                blurRadius: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              span('Ismi:', data[index].name),
                              span('Tel raqam:', data[index].phone),
                              span('Agent turi:', data[index].category.toString()),
                              span('Sana:', DateFormat('yyyy/MM/dd').format(data[index].lastOperationDate)),
                              Row(
                                children: [
                                  Text('Som uzs:',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                                  const SizedBox(width: 20,),
                                  Text(priceFormat.format(data[index].summaUzs).toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.green),),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Row(
                                children: [
                                  Text('Som usd:',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                                  const SizedBox(width: 20,),
                                  Text(priceFormat.format(data[index].summaUsd).toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.green),),
                                ],
                              ),
                            ],
                          ),
                        );
                      }):const Center(child: Text('Sizda agentlar yoq. Qoshish uchun + tugmasini bosing'));
                }
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            ),
          ),
        ],
      ),
      floatingActionButton:FloatingActionButton(onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAgentScreen())),backgroundColor: AppTheme.purple,child: const Icon(Icons.add),),
    );
  }
  Widget span(String title,content){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
        ),
        const SizedBox(width: 20,),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(content,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.7)),),
        )
      ],
    );
  }
}
