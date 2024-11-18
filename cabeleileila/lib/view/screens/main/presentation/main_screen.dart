import 'package:cabeleileila/constants/colors/colors_constants.dart';
import 'package:cabeleileila/constants/enums/button_enums.dart';
import 'package:cabeleileila/view/widgets/buttonWidget/presentation/button_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppBar(),
      body: Column(
        children: [
          Text("Meus Agendamentos"),
          Text("Você possui 2 agendamentos"),
          ButtonWidget(
            text: "Fazer novo agendamento",
            styleType: ButtonStyleType.fill,
            color: ButtonColor.primary,
            startIcon: Icons.add_circle_outline,
          ),
          ButtonWidget(
            text: "Filtrar por data",
            styleType: ButtonStyleType.outline,
            color: ButtonColor.secondary,
            endIcon: Icons.calendar_month,
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return Card();
            },
          ),
        ],
      ),
    );
  }

  PreferredSize _customAppBar() {
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        120,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: SystemColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Olá, fulano.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "vamos agendar?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_outline,
                    color: SystemColors.primary,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
