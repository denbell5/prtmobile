import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/navigation/navigator.dart';

class TracksetStore extends StatefulWidget {
  const TracksetStore({
    Key? key,
  }) : super(key: key);

  @override
  State<TracksetStore> createState() => _TracksetStoreState();
}

class _TracksetStoreState extends State<TracksetStore> {
  @override
  void initState() {
    super.initState();
    final bloc = TrackingStoreBloc.of(context);
    if (!bloc.state.isInitialized) {
      bloc.add(
        TrackingStoreInitialized(isWithFetch: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingStoreBloc, TrackingStoreState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: AppNavbar(
            topBarPadding: MediaQuery.of(context).padding.top,
            leading: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: TouchableIcon(
                iconData: CupertinoIcons.arrow_left,
                color: AppColors.white,
                onTap: () {
                  AppNavigator.of(context).pop();
                },
              ),
            ),
            middle: Text(
              'For students',
              style: AppTypography.h3.white(),
            ),
          ),
          child: ExpandableListV2(
            animationData: kExpandAnimationData,
            slivers: [
              SliverToBoxAdapter(
                child: ListHeader(
                  isLoading: state is TrackingStoreLoadingState,
                  leading: Text(
                    'Trackset List',
                    style: ListHeader.kTextStyle.bolder(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  state.tracksets
                      .map((tr) => TracksetSoView(trackset: tr))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
