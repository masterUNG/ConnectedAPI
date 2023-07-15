import 'package:connectedapi/models/data_model.dart';
import 'package:connectedapi/models/token_model.dart';
import 'package:connectedapi/utiltiy/app_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDataApi extends StatefulWidget {
  const ListDataApi({super.key});

  @override
  State<ListDataApi> createState() => _ListDataApiState();
}

class _ListDataApiState extends State<ListDataApi> {
  TextEditingController textEditingController = TextEditingController();
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 32,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  // margin: const EdgeInsets.only(top: 64, bottom: 32),
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.shade300),
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus!.unfocus();

                      if (textEditingController.text.isEmpty) {
                        Get.snackbar('Have Space ?', 'Please Fill Search');
                      } else {
                        String urlApi1 =
                            'https://ds-event.pkru.ac.th/api/checkuserreq';
                        Map<String, dynamic> map1 = {};
                        map1['usercode'] = textEditingController.text;

                        await Dio()
                            .post(urlApi1, data: map1)
                            .then((value) async {
                          print('response value from api1 ---> $value');

                          TokenModel tokenModel =
                              TokenModel.fromMap(value.data);

                          String urlApi2 =
                              'https://ds-event.pkru.ac.th/api/studenevent';
                          Map<String, dynamic> map2 = {};
                          map2['studentcode'] = textEditingController.text;
                          map2['token'] = tokenModel.token;

                          await Dio().post(urlApi2, data: map2).then((value) {
                            print('response value from api2 ---> $value');

                            for (var element in value.data) {
                              DataModel dataModel = DataModel.fromMap(element);
                              appController.dataModels.add(dataModel);
                            }
                          });
                        });
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Search'))
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(() {
              return appController.dataModels.isEmpty
                  ? const SizedBox()
                  : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appController.dataModels.length,
                      itemBuilder: (context, index) =>
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appController.dataModels[index].event_name),
                              Text(appController.dataModels[index].topic_name_event, style: const TextStyle(color: Colors.red),),
                            ],
                          ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
