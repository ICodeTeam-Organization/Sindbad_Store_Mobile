import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/nottifction_entity.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/nutifiction_cubit/notifiction_cubit.dart';

class NottifictionItem extends StatefulWidget {
  final int type;

  const NottifictionItem({
    super.key,
    required this.type,
  });

  @override
  State<NottifictionItem> createState() => _NottifictionItemState();
}

class _NottifictionItemState extends State<NottifictionItem> {
  ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  List<NotifctionEntity> notifictionList = [];
  bool isLoading = false;
  bool isLoadingMore = true;
  @override
  void initState() {
    super.initState();
    context
        .read<NotifictionCubit>()
        .getNotifiction(pageNumber: 1, pageSize: 10, type: widget.type);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.7) {
        if (isLoadingMore) {
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
          }
          context.read<NotifictionCubit>().getNotifiction(
              pageNumber: ++pageNumber, pageSize: 10, type: widget.type);
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotifictionCubit, NotifictionState>(
        listener: (context, state) {
      if (state is NotifictionSuccess) {
        if (state.notifictionList.length < 10) {
          isLoadingMore = false;
        }
        notifictionList.addAll(state.notifictionList);
      }
    }, builder: (context, state) {
      if (state is NotifictionLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NotifictionFailure) {
        return Center(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 4),
            child: Text(
              state.errorMessage,
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
            ),
          ),
        );
      } else if (state is NotifictionSuccess ||
          state is NotifictionPagtionLoading ||
          state is NotiftionPagtionFailure) {
        return notifictionList.isNotEmpty
            ? ListView.builder(
                controller: scrollController,
                itemCount: notifictionList.length,
                itemBuilder: (context, index) {
                  return NotifictionTileWidget(
                    notifictionList: notifictionList[index],
                  );
                },
              )
            : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height / 35),
                child: const Center(
                  child: Text('لا توجد اشعارات'),
                ),
              );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}

class NotifictionTileWidget extends StatefulWidget {
  final NotifctionEntity notifictionList;
  const NotifictionTileWidget({
    super.key,
    required this.notifictionList,
  });

  @override
  State<NotifictionTileWidget> createState() => _NotifictionTileWidgetState();
}

class _NotifictionTileWidgetState extends State<NotifictionTileWidget> {
  bool? isRead;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isRead = true;
        });
        // context
        //     .read<ReadNotifictionCubit>()
        //     .readNotifiction(widget.notifictionList.notifictionId);
        // context
        //     .read<UnreadNotifictionCubit>()
        //     .getUnreadNotifiction(widget.notifictionList.notifictionId);
        // if (widget.notifictionList.notficationAction == 2) {
        //   Navigator.pushNamed(
        //     context,
        //     RouteName.displayPricing,
        //     arguments: widget.notifictionList.orderId,
        //   );
        // } else {
        //   Navigator.pushNamed(context, '/order_track',
        //       arguments: widget.notifictionList.orderId);
        // }
      },
      child: Container(
        color: isRead ?? widget.notifictionList.notficationstatus
            ? null
            : const Color(0xfff1fff0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.notifictionList.notficationTitle,
                      style: isRead ?? widget.notifictionList.notficationstatus
                          ? KTextStyle.textStyle14.copyWith(
                              color: Colors.grey,
                            )
                          : KTextStyle.textStyle14),
                  const Spacer(),
                  Text(widget.notifictionList.orderNumber,
                      style: isRead ?? widget.notifictionList.notficationstatus
                          ? KTextStyle.textStyle14.copyWith(
                              color: Colors.grey,
                            )
                          : KTextStyle.textStyle14),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            widget.notifictionList.notficationBody,
                            style: KTextStyle.textStyle12
                                .copyWith(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                      '${widget.notifictionList.notficationDate.year}/${widget.notifictionList.notficationDate.month}/${widget.notifictionList.notficationDate.day}',
                      style: isRead ?? widget.notifictionList.notficationstatus
                          ? KTextStyle.textStyle14.copyWith(
                              color: Colors.grey,
                            )
                          : KTextStyle.textStyle14),
                ],
              )
            ]),
          ),
          // )
          //       ],
          //     ),
          //   ]),
          //   // title: ,
          // ),
        ),
      ),
    );
  }
}
