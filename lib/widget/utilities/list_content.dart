import 'package:bookedge/screen/ReservationDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListContent extends StatelessWidget {
  final Map<String, dynamic> data;

  const ListContent({
    super.key,
    required this.data,
  });

  Color _getStatusColor() {
    String status = data['estado'] ?? '';
    switch (status) {
      case 'confirmada':
        return Colors.green.shade400; // Vivid green
      case 'pendiente':
        return Colors.amber.shade400; // Bright yellow-orange
      case 'cancelada':
        return Colors.red.shade400; // Bright red
      case 'terminada':
        return Colors.blue.shade400; // Vibrant blue
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['cliente'] ?? 'Cliente desconocido',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          data['alojamiento'] ?? 'Alojamiento desconocido',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data['fechaInicio'] != null && data['fechaFin'] != null
                          ? '${DateFormat('MMM d').format(DateTime.parse(data['fechaInicio']))} - ${DateFormat('MMM d, yyyy').format(DateTime.parse(data['fechaFin']))}'
                          : 'Fechas desconocidas',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity, // Ocupa todo el ancho disponible
                  child: Align(
                    alignment:
                        Alignment.centerRight, // Alinea el contenido a la derecha
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReservationDetailsScreen(reserva: data)));
                      },
                      child: const Text('Ver detalles'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _getStatusColor(),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
