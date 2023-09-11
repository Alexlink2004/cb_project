import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VotingSummaryPieChart extends StatelessWidget {
  final int votesFor;
  final int votesAgainst;
  final int votesAbstain;
  final double chartRadius;

  const VotingSummaryPieChart({
    Key? key,
    required this.votesFor,
    required this.votesAgainst,
    required this.votesAbstain,
    this.chartRadius = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  // Tu lógica aquí para manejar toques en las secciones
                },
              ),
              borderData: FlBorderData(
                show: true,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 110,
              sections: showingSections(),
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          child: Text(
            "Resumen de Votación",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(
                0xFF121212,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Row(
            children: [
              _buildLegendItem(Color(0xFF34C759), "A favor"),
              _buildLegendItem(Color(0xFFFF3B30), "En contra"),
              _buildLegendItem(Color(0xFFFFCC00), "Abstención"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Color(
              0xFF121212,
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Color(0xFF34C759), // Verde
        value: votesFor.toDouble(),
        title: 'A favor',

        radius: chartRadius,
      ),
      PieChartSectionData(
        color: Color(0xFFFF3B30), // Rojo
        value: votesAgainst.toDouble(),
        title: 'En contra',
        radius: chartRadius,
      ),
      PieChartSectionData(
        color: Color(0xFFFFCC00), // Amarillo
        value: votesAbstain.toDouble(),
        title: 'Abstención',
        radius: chartRadius,
      ),
    ];
  }
}
