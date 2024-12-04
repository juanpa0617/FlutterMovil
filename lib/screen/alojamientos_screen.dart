import 'package:bookedge/screen/AlojamientoDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:bookedge/widget/utilities/search_filtered_bar.dart';
import 'package:bookedge/widget/utilities/card_component.dart';
import '../layout/menu_widget.dart';

class AlojamientosScreen extends StatefulWidget {
  const AlojamientosScreen({super.key});
  static const routeName = '/alojamientos';

  @override
  State<AlojamientosScreen> createState() => _AlojamientosScreenState();
}

class _AlojamientosScreenState extends State<AlojamientosScreen> {
  // Hardcoded accommodation data
  final List<Map<String, dynamic>> _alojamientos = [
    {
      'id': 'CAB-001',
      'tipo': 'Cabaña Familiar',
      'capacidad': 6,
      'estado': 'disponible',
      'inmobiliaria': ['wifi', 'jacuzzi'],
      'descripcion': 'Amplia cabaña con vista al bosque, perfecta para familias grandes.',

    },
    {
      'id': 'HAB-002',
      'tipo': 'Habitación Estandar',
      'capacidad': 4,
      'estado': 'Reservado',
      'inmobiliaria': ['wifi'],
      'descripcion': 'Moderno departamento en el corazón de la ciudad.',
     
    },
    {
      'id': 'HAB-003',
      'tipo': 'Habitación  Romantica',
      'capacidad': 2,
      'estado': 'disponible',
      'inmobiliaria': ['jacuzzi'],
      'descripcion': 'Acogedor loft diseñado para parejas.',
     
    },
    {
      'id': 'CAB-004',
      'tipo': 'Cabaña Fiesta',
      'capacidad': 8,
      'estado': 'mantenimiento',
      'inmobiliaria': ['wifi', 'jacuzzi'],
      'descripcion': 'Resort de lujo con todas las comodidades.',
      
    }
  ];

  String _filterType = 'todas';
  String _searchQuery = '';
  List<Map<String, dynamic>> _filteredItems = [];

  final List<Map<String, String>> _filterOptions = [
    {'value': 'todas', 'label': 'Todas'},
    {'value': 'disponible', 'label': 'Disponible'},
    {'value': 'mantenimiento', 'label': 'Mantenimiento'},
    {'value': 'Reservado', 'label': 'Reservado'},
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _filteredItems = _alojamientos;
    });
  }

  void _handleSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
      _filterItems();
    });
  }

  void _handleFilterChanged(String value) {
    setState(() {
      _filterType = value;
      _filterItems();
    });
  }

  void _filterItems() {
    setState(() {
      _filteredItems = _alojamientos.where((item) {
        bool matchesSearch = _searchQuery.isEmpty ||
            item['tipo']!.toLowerCase().contains(_searchQuery.toLowerCase());

        bool matchesFilter =
            _filterType == 'todas' || item['estado'] == _filterType;

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.cyan.shade300, 
        elevation: 4.0, 
        title: const Text(
          'Alojamientos',
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
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlojamientoDetailsScreen(
                          alojamiento: _filteredItems[index],
                        ),
                      ),
                    );
                  },
                  child: CardComponent(
                    data: _filteredItems[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MenuWidget(
        currentIndex: 1,
      ),
    );
  }
}