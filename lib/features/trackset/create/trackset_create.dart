import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/navigation/navigator.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

class TracksetCreateValue {
  final String name;
  final DateRange dateRange;

  TracksetCreateValue({
    required this.name,
    required this.dateRange,
  });

  TracksetCreateValue copyWith({
    String? name,
    DateRange? dateRange,
  }) {
    return TracksetCreateValue(
      name: name ?? this.name,
      dateRange: dateRange ?? this.dateRange,
    );
  }
}

class TracksetCreateDialog extends StatefulWidget {
  const TracksetCreateDialog({Key? key}) : super(key: key);

  @override
  _TracksetCreateDialogState createState() => _TracksetCreateDialogState();
}

class _TracksetCreateDialogState extends State<TracksetCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _inputKey = GlobalKey<InputState>();
  final _dateRangePickerKey = GlobalKey<FormFieldState<DateRange>>();

  bool _isFormValid = false;

  bool _shouldNameByDateRange = false;

  TracksetCreateValue _value = TracksetCreateValue(
    name: '',
    dateRange: DateRange(
      start: DateTime.now(),
      end: DateTime.now().add(
        const Duration(days: 90),
      ),
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
      bloc.add(TracksetCreated(_value));
    }
  }

  void _listenTrackingBloc(BuildContext context, TrackingState state) {
    if (state is TrackingUpdatedState && state.isAfterTracksetCreated) {
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
                Text(
                  'Add new trackset',
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
