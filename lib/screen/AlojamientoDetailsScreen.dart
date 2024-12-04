import 'package:bookedge/layout/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlojamientoDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> alojamiento;

  const AlojamientoDetailsScreen({super.key, required this.alojamiento});

  Color _getStatusColor() {
    String status = alojamiento['estado'] ?? '';
    switch (status) {
      case 'disponible':
        return Colors.green.shade400;
      case 'Reservado':
        return Colors.orange.shade400;
      case 'mantenimiento':
        return Colors.red.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade300, 
        elevation: 4.0, 
        title: const Text(
          'Detalle Alojamiento',
          style: TextStyle(
            color: Colors.white, 
            fontSize: 24.0, 
            fontStyle: FontStyle.italic
          ),
        ),
        centerTitle: false,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status Container
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _getStatusColor(),
                width: 2,
              ),
            ),
            child: Text(
              alojamiento['estado'].toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _getStatusColor(),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Accommodation Details
          _buildDetailRow('Identificador', alojamiento['id']),
          _buildDetailRow('Tipo', alojamiento['tipo']),
          _buildDetailRow('Capacidad', '${alojamiento['capacidad']} personas'),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Text(
            alojamiento['descripcion'],
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),

          // Amenities
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'inmobiliaria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (alojamiento['inmobiliaria'] as List<String>)
                .map((comodidad) => _buildAmenityChip(comodidad))
                .toList(),
          ),

          SizedBox(height: 20),
          // Back Button
        ],
      ),
      bottomNavigationBar: const MenuWidget(
        currentIndex: 1,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityChip(String amenity) {
    final Map<String, IconData> amenityIcons = {
      'wifi': Icons.wifi,
      'jacuzzi': Icons.hot_tub,
    };

    return Chip(
      label: Text(amenity.toUpperCase()),
      avatar: Icon(amenityIcons[amenity] ?? Icons.help_outline),
    );
  }

  Widget _buildCharacteristicItem(String characteristic) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green[700], size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              characteristic,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
