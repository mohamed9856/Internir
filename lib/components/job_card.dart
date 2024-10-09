import 'package:flutter/material.dart';
import 'package:internir/components/custom_button.dart';
import 'package:internir/models/adzuna_model.dart';
import 'package:internir/utils/app_color.dart';
import 'package:internir/utils/size_config.dart';
import 'package:internir/utils/utils.dart';

Widget jobCard(Results job) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 16 * SizeConfig.horizontalBlock,
      vertical: 16 * SizeConfig.verticalBlock,
    ),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                job.title,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16 * SizeConfig.textRatio,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 8 * SizeConfig.horizontalBlock,
            ),
            Text(
              "Posted: ${timeFormat(job.created)}",
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12 * SizeConfig.textRatio,
                fontWeight: FontWeight.w500,
                color: AppColor.grey1,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3 * SizeConfig.verticalBlock,
        ),
        Text(
          job.company.displayName,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12 * SizeConfig.textRatio,
            fontWeight: FontWeight.w500,
            color: AppColor.grey3,
          ),
        ),
        SizedBox(
          height: 16 * SizeConfig.verticalBlock,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location: ${job.location.displayName}",
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12 * SizeConfig.textRatio,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                  ),
                  Text(
                    "Salary: ${job.salaryMin} - ${job.salaryMax}",
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12 * SizeConfig.textRatio,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                  ),
                  if (job.contractTime != null)
                    Text(
                      "Hours: ${job.contractTime}",
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12 * SizeConfig.textRatio,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey1,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 16 * SizeConfig.horizontalBlock,
            ),
            CustomButton(
              text: "Apply",
              width: 100 * SizeConfig.horizontalBlock,
              onPressed: () {},
              backgroundColor: AppColor.lightBlue,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 16 * SizeConfig.horizontalBlock,
                vertical: 8 * SizeConfig.verticalBlock,
              ),
              fontSize: 14 * SizeConfig.textRatio,
            ),
          ],
        ),
      ],
    ),
  );
}
