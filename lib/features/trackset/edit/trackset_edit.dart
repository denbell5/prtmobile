import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/navigation/navigator.dart';
import 'package:prtmobile/utils/utils.dart';

class TracksetEditValue {
  final String id;
  final String name;
  final DateRange dateRange;

  TracksetEditValue({
    required this.id,
    required this.name,
    required this.dateRange,
  });

  TracksetEditValue copyWith({
    String? name,
    DateRange? dateRange,
  }) {
    return TracksetEditValue(
      id: id,
      name: name ?? this.name,
      dateRange: dateRange ?? this.dateRange,
    );
  }
}

class TracksetEditDialog extends StatefulWidget {
  const TracksetEditDialog({
    Key? key,
    required this.trackset,
  }) : super(key: key);

  final Trackset trackset;

  @override
  _TracksetEditDialogState createState() => _TracksetEditDialogState();
}

class _TracksetEditDialogState extends State<TracksetEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final _inputKey = GlobalKey<InputState>();
  final _dateRangePickerKey = GlobalKey<FormFieldState<DateRange>>();

  bool _isFormValid = false;

  bool _shouldNameByDateRange = false;

  late TracksetEditValue _value;

  @override
  void initState() {
    super.initState();
    _value = TracksetEditValue(
      id: widget.trackset.id,
      name: widget.trackset.name,
      dateRange: DateRange(
        start: widget.trackset.startAt,
        end: widget.trackset.endAt,
      ),
    );
  }

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
      bloc.add(TracksetEdited(_value));
    }
  }

  void _listenTrackingBloc(BuildContext context, TrackingState state) {
    if (state is TrackingUpdatedState && state.isAfterTracksetEdited) {
      AppNavigator.of(context).pop();
    }
  }

  void _setNameFromDateRange(DateRange dateRange) {
    final formattedDateRange = formatDateRange(
      dateRange.start,
      dateRange.end,
    );
    _inputKey.currentState!.setValue(
      formattedDateRange,
    );
  }

  Widget _buildNameInput(BuildContext context) {
    return Input(
      key: _inputKey,
      label: 'Name',
      initialValue: _value.name,
      onSaved: (name) {
        _value = _value.copyWith(name: name);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter trackset name';
        }
        return null;
      },
    );
  }

  Widget _buildNameFromDateCheckbox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _shouldNameByDateRange = !_shouldNameByDateRange;
        });
        if (_shouldNameByDateRange) {
          final dateRange = _dateRangePickerKey.currentState!.value!;
          _setNameFromDateRange(dateRange);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: kDefaultPadding,
        ),
        child: Row(
          children: [
            Checkbox(
              checked: _shouldNameByDateRange,
            ),
            const SizedBox(width: kDefaultPadding / 3),
            const Text('Name based on date range'),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangePicker(BuildContext context) {
    return DateRangePicker(
      formFieldKey: _dateRangePickerKey,
      initialValue: _value.dateRange,
      onSaved: (dateRange) {
        _value = _value.copyWith(dateRange: dateRange);
      },
      onChanged: (dateRange) {
        if (_shouldNameByDateRange) {
          _setNameFromDateRange(dateRange);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const formFieldDivider = SizedBox(height: kDefaultPadding / 2);
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
                Expanded(
                  child: Text(
                    'Edit ${widget.trackset.name}',
                    style: FormStyles.kHeaderTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
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
                      _buildNameInput(context),
                      _buildNameFromDateCheckbox(context),
                      formFieldDivider,
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
                              label: 'Save',
                              child: Text(
                                'Save',
                                style: FormStyles.kSubmitButtonTextStyle,
                              ),
                              padding: FormStyles.kSubmitButtonPadding,
                              isLoading: state is TrackingLoadingState,
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
