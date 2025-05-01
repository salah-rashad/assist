import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class StatusTable extends StatelessWidget {
  const StatusTable({
    super.key,
    required this.items,
    this.keyWidth,
    this.valueWidth,
    this.keyAlignment,
    this.valueAlignment,
    this.padding,
  });

  final Map<String, Widget> items;
  final TableColumnWidth? keyWidth;
  final TableColumnWidth? valueWidth;
  final AlignmentGeometry? keyAlignment;
  final AlignmentGeometry? valueAlignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final keyWidth = this.keyWidth ?? const FlexColumnWidth(1);
    final valueWidth = this.valueWidth ?? const FlexColumnWidth(1);
    final keyAlignment = this.keyAlignment ?? AlignmentDirectional.centerStart;
    final valueAlignment =
        this.valueAlignment ?? AlignmentDirectional.centerStart;
    final padding = this.padding ?? const EdgeInsets.all(8);
    return Table(
      columnWidths: {0: keyWidth, 1: valueWidth},
      children:
          items.entries.map((entry) {
            return TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: padding,
                    child: Align(
                      alignment: keyAlignment,
                      child: Text(
                        entry.key,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.small.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: padding,
                    child: Align(alignment: valueAlignment, child: entry.value),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
