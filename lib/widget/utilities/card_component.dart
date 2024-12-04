import 'package:flutter/material.dart';
import 'package:bookedge/screen/AlojamientoDetailsScreen.dart';

class CardComponent extends StatelessWidget {
  final Map<String, dynamic> data;

  const CardComponent({
    super.key,
    required this.data,
  });

  Color _getStatusColor() {
    String status = data['estado'] ?? '';
    switch (status) {
      case 'disponible':
        return Colors.green;
      case 'Reservado':
        return Colors.orange;
      case 'mantenimiento':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['id'].toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Tipo: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: Text(
                            data['tipo'] ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Capacidad: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: Text(
                            data['capacidad']?.toString() ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'inmobiliaria: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: Wrap(
                            spacing: 8.0,
                            children: (data['inmobiliaria'] as List<String>)
                                .map((comodidad) {
                              switch (comodidad) {
                                case 'wifi':
                                  return const Icon(Icons.wifi);
                                case 'jacuzzi':
                                  return const Icon(Icons.hot_tub);
                                default:
                                  return const Icon(Icons.help_outline);
                              }
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AlojamientoDetailsScreen(
                                          alojamiento: data)));
                        },
                        child: const Text('Ver detalles'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
