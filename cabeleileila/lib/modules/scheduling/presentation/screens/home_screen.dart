import 'package:cabeleileila/core/colors/colors_system.dart';
import 'package:cabeleileila/core/enums/button_enums.dart';
import 'package:cabeleileila/core/widgets/button/presentation/button_widget.dart';
import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';
import 'package:cabeleileila/modules/scheduling/presentation/screens/add_scheduling_screen.dart';
import 'package:cabeleileila/modules/scheduling/presentation/screens/edit_schedulling_screen.dart';
import 'package:cabeleileila/modules/scheduling/presentation/state/home_state.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    _controller.fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Meus Agendamentos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: SystemColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ButtonWidget(
                  text: "Fazer novo agendamento",
                  styleType: ButtonStyleType.fill,
                  color: ButtonColor.primary,
                  startIcon: Icons.add_circle_outline,
                  action: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSchedulingScreen()),
                    ).then((value) {
                      if (value == true) {
                        _controller.fetchList();
                      }
                    });
                  },
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _controller.listData,
                builder: (context, value, child) {
                  return FutureBuilder(
                    future: value,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final items = snapshot.data;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: items!.length,
                            itemBuilder: (context, index) {
                              return _cardScheduling(items, index);
                            },
                          ),
                        );
                      }

                      return Container();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardScheduling(List<Scheduling> items, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Serviço: ${items[index].serviceType}"),
                Text("Data e Hora: ${items[index].dateHour}"),
                Text("Status: ${items[index].status}"),
              ],
            ),
            IconButton(
              onPressed: () {
                List<String> dateTimeSeparate = items[index].dateHour.split(',').map((e) => e.trim()).toList();

                String date = dateTimeSeparate[0];

                List<String> parts = date.split('/');

                int month = int.parse(parts[1]);
                int day = int.parse(parts[0]);
                int year = int.parse(parts[2]);

                DateTime dateFormatted = DateTime(year, month, day);

                if (!_controller.isTodayWithinTwoDays(dateFormatted)) {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => EditSchedulingScreen(
                        serviceType: items[index].serviceType,
                        dateTime: items[index].dateHour,
                        id: items[index].id!,
                      ),
                    ),
                  )
                      .then((value) {
                    if (value == true) {
                      _controller.fetchList();
                    }
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Atenção"),
                        content: Text(
                          "Você está a menos de dois dias da data agendada. Faça a alteração pelo nosso telefone.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }
}
