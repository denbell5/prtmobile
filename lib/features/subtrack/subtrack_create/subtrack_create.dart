import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/misc/misc.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/navigation/navigator.dart';

class SubtrackCreateValue {
  final int? start;
  final int? end;

  SubtrackCreateValue({
    required this.start,
    required this.end,
  });

  SubtrackCreateValue copyWith({
    int? start,
    int? end,
  }) {
    return SubtrackCreateValue(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}

class SubtrackCreateDialog extends StatefulWidget {
  const SubtrackCreateDialog({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  _SubtrackCreateDialogState createState() => _SubtrackCreateDialogState();
}

class _SubtrackCreateDialogState extends State<SubtrackCreateDialog> {
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid = false;

  String? _higherLevelErrorText;
  bool get _isValidOnHigherLevel => _higherLevelErrorText == null;

  var _value = SubtrackCreateValue(
    start: null,
    end: null,
  );

  void _validateAndSaveForm() {
    setState(() {
      _isFormValid = _formKey.currentState!.validate();
    });
    String? higherLevelErrorText;
    if (_isFormValid) {
      _formKey.currentState!.save();
      higherLevelErrorText = _validateHigherLevel();
    }
    setState(() {
      _higherLevelErrorText = higherLevelErrorText;
    });
  }

  void _onSubmit() {
    _validateAndSaveForm();
    if (_isFormValid && _isValidOnHigherLevel) {
      final bloc = TrackingBloc.of(context);
      bloc.add(
        SubtrackCreated(
          value: _value,
          tracksetId: widget.track.tracksetId,
          trackId: widget.track.id,
        ),
      );
    }
  }

  void _listenTrackingBloc(BuildContext context, TrackingState state) {
    if (state is TrackingUpdatedState && state.isAfterSubtrackCreated) {
      AppNavigator.of(context).pop();
    }
  }

  String? _validateIntField(
    String? valueText, {
    required String name,
  }) {
    if (valueText == null || valueText.isEmpty) {
      return '$name is required';
    }
    final value = int.tryParse(valueText);
    if (value == null) {
      return '$name has to be numeric';
    }
    if (value < 0) {
      return '$name cannot be negative';
    }
    return null;
  }

  void _saveIntIfParses(
    String? valueText,
    void Function(int value) save,
  ) {
    final value = int.tryParse(valueText ?? '');
    if (value != null) {
      save(value);
    }
  }

  String? _validateHigherLevel() {
    final subtracks = widget.track.subtracks.entities;
    final range = Range(_value.start!, _value.end!);
    return combineValidators([
      () => validateRange(range),
      () => validateIntersection(range: range, subtracks: subtracks),
    ]);
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
                  'Add new Subtrack',
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
                    _validateAndSaveForm();
                    if (_isFormValid) {
                      _formKey.currentState!.save();
                      setState(() {
                        _higherLevelErrorText = _validateHigherLevel();
                      });
                    }
                  },
                  child: Column(
                    children: [
                      Input(
                        label: 'Start',
                        onSaved: (startString) {
                          _saveIntIfParses(
                            startString,
                            (start) => _value = _value.copyWith(start: start),
                          );
                        },
                        validator: (startText) {
                          return _validateIntField(startText, name: 'Start');
                        },
                      ),
                      Input(
                        label: 'End',
                        onSaved: (endString) {
                          _saveIntIfParses(
                            endString,
                            (end) => _value = _value.copyWith(end: end),
                          );
                        },
                        validator: (endText) {
                          return _validateIntField(endText, name: 'End');
                        },
                      ),
                      const Height(kDefaultPadding / 2),
                      Text(
                        _higherLevelErrorText ?? '',
                        style: AppTypography.error,
                      ),
                      const Height(kDefaultPadding / 2),
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
