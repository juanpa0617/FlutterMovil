import 'package:flutter/material.dart';
import 'package:bookedge/widget/utilities/search_filtered_bar.dart';
import 'package:bookedge/widget/utilities/list_content.dart';
import '../layout/menu_widget.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});
  static const routeName = '/reservas';

  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  String _filterType = 'todas';
  String _searchQuery = '';
  String? expandedStatus;
  final List<Map<String, dynamic>> _reservas = [
    {
      'id': '1',
      'plan': 'Día de Sol',
      'alojamiento': 'Cabaña #1',
      'cliente': 'María Fernández Rodríguez',
      'fechaInicio': '2024-12-20',
      'fechaFin': '2024-12-27',
      'estado': 'pendiente',
      'acompanantes': [
        {
          'nombre': 'Carlos Fernández',
          'edad': 45,
          'parentesco': 'Esposo',
          'plan': ' Día de Sol',
        },
        {
          'nombre': 'Ana Fernández',
          'edad': 16,
          'parentesco': 'Hija',
          'plan': ' Día de Sol',
        },
        {
          'nombre': 'Luis Fernández',
          'edad': 12,
          'parentesco': 'Hijo',
          'plan': ' Día de Sol',
        }
      ]
    },
    {
      'id': '2',
      'plan': 'Luna de Miel Deluxe',
      'alojamiento': 'Cabaña #3',
      'cliente': 'Javier Martínez García',
      'fechaInicio': '2024-11-15',
      'fechaFin': '2024-11-22',
      'estado': 'confirmada',
      'acompanantes': [
        {
          'nombre': 'Elena Sánchez Pérez',
          'edad': 29,
          'parentesco': 'Esposa',
          'plan': 'Empresarial'
        }
      ]
    },
    {
      'id': '3',
      'plan': 'Empresarial',
      'alojamiento': 'Centro de Convenciones Montaña Verde',
      'cliente': 'Roberto Gutiérrez López',
      'fechaInicio': '2024-10-05',
      'fechaFin': '2024-10-08',
      'estado': 'cancelada',
      'acompanantes': [
        {
          'nombre': 'Andrea Ramírez',
          'edad': 35,
          'parentesco': 'Colega',
          'plan': 'Empresarial'
        },
        {
          'nombre': 'Miguel Torres',
          'edad': 42,
          'parentesco': 'Colega',
          'plan': ' Empresarial'
        }
      ]
    },
    {
      'id': '4',
      'plan': ' Romántica',
      'alojamiento': 'Habitacion #1',
      'cliente': 'Sofía Rodríguez Morales',
      'fechaInicio': '2024-09-10',
      'fechaFin': '2024-09-14',
      'estado': 'terminada',
      'acompanantes': [
        {
          'nombre': 'Diego Álvarez',
          'edad': 33,
          'parentesco': 'Pareja',
          'plan': ' Romántico '
        }
      ]
    },
    {
      'id': '5',
      'plan': 'Cumpleaños',
      'alojamiento': 'Cabaña #5',
      'cliente': 'Laura Pérez Jiménez',
      'fechaInicio': '2024-07-15',
      'fechaFin': '2024-07-25',
      'estado': 'pendiente',
      'acompanantes': [
        {
          'nombre': 'Pedro Pérez',
          'edad': 14,
          'parentesco': 'Hijo',
          'plan': 'Cumpleaños'
        },
        {
          'nombre': 'Marta Pérez',
          'edad': 11,
          'parentesco': 'Hija',
          'plan': 'Cumpleaños'
        }
      ]
    },
    {
      'id': '6',
      'plan': 'Romántico',
      'alojamiento': 'Cabaña #2',
      'cliente': 'Ana Torres Guzmán',
      'fechaInicio': '2024-11-01',
      'fechaFin': '2024-11-05',
      'estado': 'confirmada',
      'acompanantes': [
        {
          'nombre': 'Julia Hernández',
          'edad': 38,
          'parentesco': 'Amiga',
          'plan': 'Cumpleaños'
        }
      ]
    }
  ];

  final List<Map<String, String>> _filterOptions = [
    {'value': 'todas', 'label': 'Todas'},
    {'value': 'pendiente', 'label': 'Pendiente'},
    {'value': 'confirmada', 'label': 'Confirmada'},
    {'value': 'cancelada', 'label': 'Cancelada'},
    {'value': 'terminada', 'label': 'Terminada'},
  ];

  void _handleSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _handleFilterChanged(String value) {
    setState(() {
      _filterType = value;
    });
  }

  List<Map<String, dynamic>> get _filteredReservas {
    return _reservas.where((reserva) {
      final matchesSearchQuery =
          reserva['cliente'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilterType = _filterType == 'todas' ||
          reserva['estado'].toLowerCase() == _filterType.toLowerCase();
      return matchesSearchQuery && matchesFilterType;
    }).toList();
  }

  Map<String, List<Map<String, dynamic>>> get groupedReservas {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var reserva in _filteredReservas) {
      grouped.putIfAbsent(reserva['estado'], () => []).add(reserva);
    }
    return grouped;
  }

  List<String> get sortedStatuses {
    final statuses = groupedReservas.keys.toList();
    statuses.sort((a, b) {
      final order = ['pendiente', 'confirmada', 'cancelada', 'terminada'];
      return order.indexOf(a).compareTo(order.indexOf(b));
    });
    return statuses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.cyan.shade300, 
        elevation: 4.0, 
        title: const Text(
          'Reservas',
          style: TextStyle(
            color: Colors.white, 
            fontSize: 24.0, 
            fontStyle: FontStyle.italic
          ),
        ),
        centerTitle: false, 
        leadingWidth: 0, 
        leading:
        const SizedBox.shrink(), 
      ),
      body: Column(
        children: [
          SearchFilterBar(
            onSearchChanged: _handleSearchChanged,
            onFilterChanged: _handleFilterChanged,
            filterType: _filterType,
            filterOptions: _filterOptions,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sortedStatuses.length,
              itemBuilder: (context, index) {
                final status = sortedStatuses[index];
                final reservas = groupedReservas[status]!;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          status.toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        trailing: Icon(
                          expandedStatus == status
                              ? Icons.expand_less
                              : Icons.expand_more,
                        ),
                        onTap: () {
                          setState(() {
                            expandedStatus =
                                expandedStatus == status ? null : status;
                          });
                        },
                      ),
                      if (expandedStatus == status)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reservas.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox.shrink(),
                          itemBuilder: (context, index) {
                            final reserva = reservas[index];
                            return ListContent(data: reserva);
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MenuWidget(),
    );
  }
}
