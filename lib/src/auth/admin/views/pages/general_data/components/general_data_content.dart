import 'package:cb_project/src/auth/admin/controllers/general_data_content_controller.dart';
import 'package:cb_project/src/auth/admin/views/pages/general_data/components/user_card.dart';
import 'package:cb_project/src/server/api/users_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../server/models/user.dart';
import 'add_user_popup.dart';

class GeneralDataPage extends StatefulWidget {
  const GeneralDataPage({super.key});

  @override
  GeneralDataPageState createState() => GeneralDataPageState();
}

class GeneralDataPageState extends State<GeneralDataPage> {
  @override
  void initState() {
    final generalDataContentController =
        Provider.of<GeneralDataContentController>(context, listen: false);
    generalDataContentController.getUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final generalDataContentController =
        Provider.of<GeneralDataContentController>(context);
    final users = UsersApi().filterUsersByPosition(
        generalDataContentController.users, 'Administrador');

    final Size size = MediaQuery.of(context).size;
    // debugPrint('${size.width}');
    if (users.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox.fromSize(
          size: size,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                flex: 2,
                child: AddUserButton(),
              ),
              const SizedBox(height: 16),
              Expanded(
                flex: 30,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width >= 800
                        ? size.width <= 1100
                            ? 2
                            : 3
                        : 1,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    //  childAspectRatio: 4 / 3,
                  ),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      index: index,
                      user: users[index],
                      onEdit: (User user, index) {},
                      onDelete: (index) {
                        generalDataContentController.deleteUser(
                          users[index].id!,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else if (users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "No hay usuarios aún",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("agrega uno para empezar"),
            const SizedBox(
              height: 15,
            ),
            SvgPicture.asset(
              'assets/illustrations/no_data.svg',
              width: 100,
            ),
            const SizedBox(
              height: 25,
            ),
            const AddUserButton(),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
