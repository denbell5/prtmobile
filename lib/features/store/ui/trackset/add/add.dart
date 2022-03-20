import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/navigation/navigator.dart';

class AddTracksetSoDialog extends StatefulWidget {
  const AddTracksetSoDialog({
    Key? key,
    required this.trackset,
  }) : super(key: key);

  final TracksetSo trackset;

  @override
  _AddTracksetSoDialogState createState() => _AddTracksetSoDialogState();
}

class _AddTracksetSoDialogState extends State<AddTracksetSoDialog> {
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid = false;

  late DateRange _value = DateRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      Duration(days: widget.trackset.recommendedDays),
    ),
  );

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState!.validate();
    });
  }

  void _onSubmit() {
    _validateForm();
    if (_isFormValid) {
      _formKey.currentState!.save();
      final bloc = TrackingBloc.of(context);
      bloc.add(
        TracksetSoAdded(
          tracksetSo: widget.trackset,
          dateRange: _value,
        ),
      );
    }
  }

  void _listenTrackingBloc(BuildContext context, TrackingState state) {
    if (state is TrackingUpdatedState && state.isAfterTracksetSoAdded) {
      AppNavigator.of(context).pop();
    }
  }

  Widget _buildDateRangePicker(BuildContext context) {
    return DateRangePicker(
      initialValue: _value,
      onSaved: (dateRange) {
        _value = dateRange!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      child: BottomSafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: 0.0,
                  child: TouchableIcon(
                    iconData: CupertinoIcons.xmark,
                    onTap: () {},
                  ),
                ),
                Text(
                  'Add ${widget.trackset.name}',
                  style: FormStyles.kHeaderTextStyle,
                ),
                TouchableIcon(
                  iconData: CupertinoIcons.xmark,
                  onTap: () {
                    AppNavigator.of(context).pop();
                  },
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                child: Form(
                  key: _formKey,
                  onChanged: () {
                    _validateForm();
                  },
                  child: Column(
                    children: [
                      _buildDateRangePicker(context),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding * 2,
                        ),
                        child: BlocConsumer<TrackingBloc, TrackingState>(
                          listener: _listenTrackingBloc,
                          builder: (context, state) {
                            return Button(
                              child: Text(
                                'Save',
                                style: FormStyles.kSubmitButtonTextStyle,
                              ),
                              padding: FormStyles.kSubmitButtonPadding,
                              isLoading: state is TrackingLoadingState &&
                                  state.isAddingTracksetSo,
                              onTap: _onSubmit,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
