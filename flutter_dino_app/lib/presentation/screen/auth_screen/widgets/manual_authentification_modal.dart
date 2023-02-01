
import 'package:flutter/material.dart';

import '../../../widgets/bottom_sheet_decoration.dart';
import 'login_form.dart';
import 'register_form.dart';

class ManualAuthentification extends StatelessWidget {
  const ManualAuthentification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) => Scaffold(
            body: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: [
                  Container(
                    decoration: bottom_sheet_decoration(),
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
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: const TabBarView(
                              children: [LoginForm(), RegisterForm()],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const Text('manual Authentification'),
    );
  }
}