import 'package:flutter/material.dart';

import '../global/button_for_grid_widget.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        // childAspectRatio: 2.5 / 4, //IF COUNT is 4
        childAspectRatio: 1 / 1,
      ),
      children: const [
        ButtonForGridWidget(
          name: 'Users',
          route: '/users',
          iconz: Icons.supervised_user_circle_sharp,
        ),
        ButtonForGridWidget(
          name: 'Payments',
          route: '/payments',
          iconz: Icons.payment,
        ),
        ButtonForGridWidget(
          name: 'Images',
          route: '/image-storage',
          iconz: Icons.photo,
        ),
        ButtonForGridWidget(
          name: 'Contacts',
          route: '/contacts',
          iconz: Icons.phone,
        ),
        ButtonForGridWidget(
          name: 'FAQs',
          route: '/faq',
          iconz: Icons.question_answer,
        ),
        ButtonForGridWidget(
          name: 'Administrators',
          route: '/admin',
          iconz: Icons.admin_panel_settings,
        ),
      ],
    );
  }
}
