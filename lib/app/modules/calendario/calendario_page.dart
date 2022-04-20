import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/calendario/controllers/eventos_controller.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioPage extends StatefulWidget {
  final String title;
  const CalendarioPage({Key? key, this.title = 'CalendarioPage'})
      : super(key: key);
  @override
  CalendarioPageState createState() => CalendarioPageState();
}

class CalendarioPageState
    extends ModularState<CalendarioPage, EventoController> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _hoje = DateTime.now();
  late final ValueNotifier<List<EventoModel>> eventosDoDia = ValueNotifier([]);
  final DateFormat formataData = DateFormat('dd/MM');
  late List<EventoModel> listaEventos;

  @override
  void initState() {
    super.initState();
    controller.init();
    listaEventos = [];
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<EventoController, Exception, List<EventoModel>>(
      store: store,
      onLoading: (_) => const Carregando(),
      onError: (_, exception) => LogErro(erro: exception),
      onState: (context, eventos) {
        listaEventos = eventos;
        return Column(
          children: [
            TableCalendar<EventoModel>(
              firstDay: DateTime.utc(_hoje.year, 1, 1),
              lastDay: DateTime.utc(_hoje.year, 12, 31),
              focusedDay: _hoje,
              locale: 'pt_BR',
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              eventLoader: (hoje) => _getEventosDoAno(hoje, eventos),
              onDaySelected: _diaSelecionado,
              headerStyle: const HeaderStyle(formatButtonVisible: false),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<EventoModel>>(
                valueListenable: eventosDoDia,
                builder: (context, eventos, _) {
                  return ListView.builder(
                    itemCount: eventos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          leading: Text(formataData.format(eventos[index].dia)),
                          title: Text(eventos[index].titulo),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  List<EventoModel> _getEventosDoAno(DateTime dia, List<EventoModel> eventos) {
    return eventos
        .where((element) =>
            element.dia.day == dia.day &&
            element.dia.month == dia.month &&
            element.dia.year == dia.year)
        .toList();
  }

  void _diaSelecionado(DateTime diaSelecionado, DateTime focusedDay) {
    print('$diaSelecionado');
    print('$focusedDay');

    var lista = listaEventos
        .where((element) =>
            element.dia.day == diaSelecionado.day &&
            element.dia.month == diaSelecionado.month &&
            element.dia.year == diaSelecionado.year)
        .toList();

    eventosDoDia.value = lista;
  }
}
