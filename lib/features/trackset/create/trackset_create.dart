import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

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
  bool _isFormValid = false;

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
      Navigator.of(context).pop();
    }
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
                  child: TouchableX(
                    onTap: () {},
                  ),
                ),
                Text(
                  'Add new trackset',
                  style: AppTypography.h4.greyed(),
                ),
                TouchableX(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding * 2,
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
                      Input(
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
                      ),
                      formFieldDivider,
                      DateRangePicker(
                        initialValue: _value.dateRange,
                        onSaved: (dateRange) {
                          _value = _value.copyWith(dateRange: dateRange);
                        },
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding * 2,
                        ),
                        child: BlocConsumer<TrackingBloc, TrackingState>(
                          listener: _listenTrackingBloc,
                          builder: (context, state) {
                            return Button(
                              label: 'Add',
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
