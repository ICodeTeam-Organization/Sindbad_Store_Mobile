import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_features/view_offer_feature/ui/widgets/action_button_widget.dart';

class ViewOfferScreen extends StatelessWidget {
  const ViewOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back),
                    Text("data"),
                    Icon(Icons.search),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ActionButtonWidget(
                  title: 'test',
                  icon: Icon(Icons.delete),
                )
              ),
              Container(
                height: 160.h,
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("title"),
                              Text(" : "),
                              Text("data"),
                            ],
                          ),
                          Text("data"),
                          Text("data"),
                          Row(
                            children: [
                              Icon(Icons.delete),
                              Text("data"),
                              SizedBox(width: 5.w,),
                              Icon(Icons.delete),
                              Text("data"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Text("data"),
                          SizedBox(height: 10.h,),
                          ActionButtonWidget(
                            title: 'test',
                            icon: Icon(Icons.delete),
                            isSolid: false,
                          ),
                          SizedBox(height: 5.h,),
                          ActionButtonWidget(
                            title: 'test',
                            icon: Icon(Icons.delete),
                            isSolid: false,
                          ),
                          SizedBox(height: 5.h,),
                          ActionButtonWidget(
                            title: 'test',
                            icon: Icon(Icons.delete),
                            isSolid: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}