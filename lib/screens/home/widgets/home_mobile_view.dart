import 'package:flutter/material.dart';
import 'package:flutter_practice_application/app/app.router.dart';
import 'package:flutter_practice_application/models/user_model.dart';
import 'package:flutter_practice_application/screens/home/home_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class HomeMobileView extends ViewModelWidget<HomeViewModel> {
  const HomeMobileView({
    super.key,
  });

  @override
  Widget build(BuildContext context, viewModel) {
    return ListView.builder(
      itemCount: viewModel.userDetailList.length,
      itemBuilder: (context, index) {
        UserModel user = viewModel.userDetailList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {
              viewModel.navigationService.navigateToUserDetailsPage(
                  user: user, id: user.id, icon: true);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 38, 42, 49),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff76ABAE),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xff76ABAE),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(174, 15, 14, 14),
                                ),
                              ),
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: GoogleFonts.archivo(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.email_rounded,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            '${user.email}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.phone,
                              color: Color.fromARGB(174, 15, 14, 14),
                            ),
                          ),
                          Text(
                            '${user.phoneNumber}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.male,
                                color: Color.fromARGB(174, 15, 14, 14),
                              ),
                            ),
                            Text(
                              '${user.gender}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 14.0,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.date_range,
                                color: Color.fromARGB(174, 15, 14, 14),
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(user.dateOfBirth!),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ]),
                      const SizedBox(height: 5),
                      if (user.userNote != null) ...[
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Visibility(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(240, 238, 227, 124),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                child: Text(
                                  '${user.userNote}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
