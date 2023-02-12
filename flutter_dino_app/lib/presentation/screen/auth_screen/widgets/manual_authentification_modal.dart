import 'package:flutter/material.dart';

import '../../../widgets/bottom_sheet_decoration.dart';
import 'login_form.dart';
import 'register_form.dart';

class ManualAuthentification extends StatelessWidget {
  ManualAuthentification({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _modelScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Scaffold(
              extendBody: false,
              key: _modelScaffoldKey,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Container(
                  decoration: bottomSheetDecoration(),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(icon: Icon(Icons.login)),
                            Tab(icon: Icon(Icons.app_registration_rounded)),
                          ],
                          labelColor: Theme.of(context).primaryColor,
                        ),
                        const Divider(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: TabBarView(
                            children: [
                              LoginForm(_modelScaffoldKey),
                              RegisterForm(_modelScaffoldKey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: const Text('Email'),
    );
  }
}
