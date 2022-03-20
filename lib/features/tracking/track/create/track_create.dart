import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'package:prtmobile/core/core.dart';

class TrackCreateValue {
  final String name;

  TrackCreateValue({
    required this.name,
  });

  TrackCreateValue copyWith({
    String? name,
  }) {
    return TrackCreateValue(
      name: name ?? this.name,
    );
  }
}

class TrackCreateDialog extends StatefulWidget {
  const TrackCreateDialog({
    Key? key,
    required this.tracksetId,
  }) : super(key: key);

  final String tracksetId;

  @override
  _TrackCreateDialogState createState() => _TrackCreateDialogState();
}

class _TrackCreateDialogState extends State<TrackCreateDialog> {
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid = false;

  TrackCreateValue _value = TrackCreateValue(
    name: '',
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
        TrackCreated(
          value: _value,
          tracksetId: widget.tracksetId,
        ),
      );
    }
  }

  void _listenTrackingBloc(BuildContext context, TrackingState state) {
    if (state is TrackingUpdatedState && state.isAfterTrackCreated) {
      AppNavigator.of(context).pop();
    }
  }

  Widget _buildNameInput(BuildContext context) {
    return Input(
      label: 'Name',
      onSaved: (name) {
        _value = _value.copyWith(name: name);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Track name';
        }
        return null;
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
                  'Add new Track',
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
