import 'package:admin_gl_cashman/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/colors.dart';
import '../widgets/global/button_for_grid_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_admin.png'),
              fit: BoxFit.cover,
            ),
          ),
          //! ISI
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 300),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 250),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'ADMIN\nGL MANAGER',
                      style: AppTextStyle.heading,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: GridView(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        children: const [
                          ButtonForGridWidget(
                            name: "Users data",
                            route: "/dataUser",
                            iconz: Icons.supervised_user_circle_sharp,
                          ),
                          ButtonForGridWidget(
                            name: "Payment data",
                            route: "/dataPayment",
                            iconz: Icons.payments_sharp,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 275,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.primary,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Hari ini',
                              style: AppTextStyle.mediumThin,
                            ),
                            // SizedBox(height: 10),
                            Text(
                              DateFormat('dd-MMM-yyyy').format(DateTime.now()),
                              style: AppTextStyle.subHeading,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '© Copyright 2024 by Grand Laswi, Al Right Reserved',
                    style: AppTextStyle.mediumThin,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 100,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
