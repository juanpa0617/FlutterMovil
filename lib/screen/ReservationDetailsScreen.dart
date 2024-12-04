import 'package:bookedge/layout/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> reserva;

  const ReservationDetailsScreen({super.key, required this.reserva});

  Color _getStatusColor() {
    String status = reserva['estado'] ?? '';
    switch (status) {
      case 'confirmada':
        return Colors.green.shade400;
      case 'pendiente':
        return Colors.amber.shade400;
      case 'cancelada':
        return Colors.red.shade400;
      case 'terminada':
        return Colors.blue.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.cyan.shade300, 
        elevation: 4.0, 
        title: const Text(
          'Detalle Reserva',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
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
                reserva['estado'].toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _getStatusColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildDetailRow('Cliente', reserva['cliente']),
            _buildDetailRow('Alojamiento', reserva['alojamiento']),
            _buildDetailRow('Plan', reserva['plan']),
            _buildDateRow(),

            // Companions Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Acompañantes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),

            if (reserva['acompanantes'] != null &&
                reserva['acompanantes'].isNotEmpty)
              ...List.generate(reserva['acompanantes'].length, (index) {
                final companion = reserva['acompanantes'][index];
                return Column(
                  children: [
                    _buildCompanionCard(companion),
                    SizedBox(height: 10),
                  ],
                );
              })
            else
              Text(
                'No hay acompañantes registrados',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),

            SizedBox(height: 20),

          ],
        ),
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
            value ?? 'No especificado',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanionCard(Map<String, dynamic> companion) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  companion['nombre'] ?? 'Nombre no disponible',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  '${companion['edad'] ?? 'N/A'} años',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Parentesco:',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  companion['parentesco'] ?? 'No especificado',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Plan:',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  companion['plan'] ?? 'No especificado',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  

  Widget _buildDateRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fechas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fecha de Inicio',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              Text(
                reserva['fechaInicio'] != null
                    ? DateFormat('MMM d, yyyy')
                        .format(DateTime.parse(reserva['fechaInicio']))
                    : 'No especificada',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fecha de Fin',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              Text(
                reserva['fechaFin'] != null
                    ? DateFormat('MMM d, yyyy')
                        .format(DateTime.parse(reserva['fechaFin']))
                    : 'No especificada',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    
  }
  
}
