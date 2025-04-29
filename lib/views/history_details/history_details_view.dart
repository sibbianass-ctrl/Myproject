import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/models/validated_sortie.dart';
import 'package:my_project/utils/resources/history/history_strings.dart';
import 'package:my_project/utils/resources/oridnary_visit/oridnary_visit_strings.dart';
import 'package:my_project/utils/responsive_utils.dart';
import 'package:my_project/views/history_details/widgets/open_in_new_button.dart';
import 'package:my_project/views/history_details/widgets/status_widget.dart';
import 'package:my_project/views/history_gallery/history_gallery.dart';
import 'package:my_project/views/home/widgets/validated_text_label.dart';
import 'package:my_project/views/price_list_view/price_list_view.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../enums/visit_type_enum.dart';
import '../../utils/resources/global/app_colors.dart';
import '../../utils/resources/global/app_strings.dart';
import '../../widgets/custom_app_bar.dart';

class HistoryDetailsView extends StatelessWidget {
  final ValidatedSortie validatedSortie;
  const HistoryDetailsView({super.key, required this.validatedSortie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define breakpoints for responsiveness
          bool isTablet = constraints.maxWidth > 600;
          return Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 40.0 : 12,
                  vertical: 18.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //------------ Title ----------------------
                    Center(
                      child: Column(
                        children: [
                          Text(
                            validatedSortie.lotName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${AppStrings.dateLabel}: ${validatedSortie.planningDate}",
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 13),
                            ),
                          ),
                          Text(
                            "${AppStrings.numberLabel}: ${validatedSortie.lotNumber}",
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context, 13),
                                color: AppColors.grey),
                          ),
                          ValidatedTextLabel(
                            text:
                                '${HistoryStrings.validatedAt} : ${validatedSortie.reelDate}',
                            textSize: getResponsiveFontSize(context, 10),
                          ),
                          const SizedBox(height: 16),
                          // State Cardes
                          Row(
                            children: [
                              StatusWidget(
                                  title: AppStrings.workStateLabel,
                                  status: validatedSortie.siteState),
                              StatusWidget(
                                  title: AppStrings.workRateLabel,
                                  status: validatedSortie.workRate),
                              StatusWidget(
                                  title: AppStrings.visitType,
                                  status: validatedSortie.visitType ==
                                          VisitTypeEnum.ordinary
                                      ? AppStrings.ordinary
                                      : AppStrings.attachment),
                            ],
                          ),
                          const SizedBox(height: 32),

                          if (validatedSortie.visitType ==
                              VisitTypeEnum.ordinary) ...[
                            Text(
                              OridnaryVisitStrings.progressRateLabel,
                              style: TextStyle(
                                  fontSize: getResponsiveFontSize(context, 12)),
                            ),
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 5.0,
                              percent: validatedSortie.progressRate / 100,
                              center: Text(
                                '${validatedSortie.progressRate}%',
                                style: TextStyle(fontSize: 12),
                              ),
                              progressColor: Colors.green,
                            ),
                          ] else
                            OpenInNewButton(
                                text: HistoryStrings.showPriceListLabel,
                                icon: Icons.table_chart_outlined,
                                onPressed: () {
                                  Get.to(() => PriceListView(
                                        prestations: validatedSortie
                                            .cardItemsPrestations,
                                      ));
                                }),
                          SizedBox(height: 16),
                          OpenInNewButton(
                              text: HistoryStrings.showPhotosLabel,
                              icon: Icons.photo_library_outlined,
                              onPressed: () {
                                Get.to(() => HistoryGallery(
                                      imageUrls: validatedSortie.photos,
                                    ));
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
