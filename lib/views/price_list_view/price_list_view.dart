import 'package:flutter/material.dart';
import 'package:my_project/utils/resources/take_attachment_visit/take_attachment_visit_strings.dart';
import 'package:my_project/views/price_list_view/widgets/custom_data_column.dart';
import '../../models/prestation.dart';

class PriceListView extends StatelessWidget {
  PriceListView({Key? key, required this.prestations});
  final List<Prestation> prestations;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(TakeAttachmentVisitStrings.priceListLabel,
              style: TextStyle(fontSize: 16))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 16.0, // Space between columns
                border: TableBorder.all(color: Colors.grey), // Table borders
                columns: [
                  CustomDataColumn(
                      labelText: TakeAttachmentVisitStrings.prestationLabel),
                  CustomDataColumn(
                    labelText: TakeAttachmentVisitStrings.initialQuantityLabel,
                  ),
                  CustomDataColumn(
                    labelText: TakeAttachmentVisitStrings.quantityConsumedLabel,
                  ),
                  CustomDataColumn(
                    labelText:
                        TakeAttachmentVisitStrings.remainingQuantityLabel,
                  ),
                  CustomDataColumn(
                    labelText: TakeAttachmentVisitStrings.unitLabel,
                  ),
                ],
                rows: prestations.map((prestation) {
                  return DataRow(cells: [
                    DataCell(
                      // onTap: () {
                      //   log(prestation.label);
                      // },
                      SizedBox(
                        width: size.width,
                        child: Text(
                          prestation.label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    DataCell(Text(prestation.initialQuantity
                        .toStringAsFixed(2))), // Initial Quantity
                    DataCell(Text(prestation.quantityConsumed
                        .toStringAsFixed(2))), // Quantity Consumed
                    DataCell(Text(prestation.remainingQuantity
                        .toStringAsFixed(2))), // Remaining Quantity
                    DataCell(Text(prestation.unit)), // Unit
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
