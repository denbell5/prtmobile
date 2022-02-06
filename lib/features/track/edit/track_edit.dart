import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/navigation/navigator.dart';
import 'package:prtmobile/styles/styles.dart';

class TrackEditValue {
  final String name;

  TrackEditValue({
    required this.name,
  });

  TrackEditValue copyWith({
    String? name,
  }) {
    return TrackEditValue(
      name: name ?? this.name,
    );
  }
}

class TrackEditDialog extends StatefulWidget {
  const TrackEditDialog({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  _TrackEditDialogState createState() => _TrackEditDialogState();
}

class _TrackEditDialogState extends State<TrackEditDialog> {
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid = false;

  late TrackEditValue _value = TrackEditValue(
    name: widget.track.name,
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
        TrackEdited(
          value: _value,
          trackId: widget.track.id,
          tracksetId: widget.track.tracksetId,
        ),
      );
    }
  }

  void _listenTrackingBloc(BuildContext context, TrackingState state) {
    if (state is TrackingUpdatedState && state.isAfterTrackEdited) {
      AppNavigator.of(context).pop();
    }
  }

  Widget _buildNameInput(BuildContext context) {
    return Input(
      label: 'Name',
      initialValue: _value.name,
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
                Expanded(
                  child: Text(
                    'Edit ${widget.track.name}',
                    style: AppTypography.h4.greyed(),
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
