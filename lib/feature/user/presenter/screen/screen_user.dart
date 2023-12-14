import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_dependecy_inversion/feature/services/param_through_screen/param_through_screen.dart';
import 'package:sample_dependecy_inversion/feature/user/presenter/bloc/bloc/profile_bloc.dart';
import 'package:sample_dependecy_inversion/feature/user/presenter/screen/screen_user_detail.dart';
import 'package:sample_dependecy_inversion/packages/device_info/device_info_bloc/device_info_bloc.dart';
import 'package:sample_dependecy_inversion/packages/device_info/device_info_data.dart';
import 'package:sample_dependecy_inversion/packages/internet_conection/internet_conection.dart';
import 'package:sample_dependecy_inversion/sl.dart';

class ScreenUser extends StatelessWidget {
  const ScreenUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => sl.get<DeviceInfoBloc>()..add(DeviceInfoCall()),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const _LayoutBodyScreenUser(),
      ),
    );
  }
}

class _LayoutBodyScreenUser extends StatelessWidget {
  const _LayoutBodyScreenUser();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: sl.get<DeviceInfoData>().versionName,
            initialData: '',
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const Divider(),
          BlocBuilder<ProfileBloc, ProfileState>(
            bloc: sl.get<ProfileBloc>()..add(const ProfileInitEvent()),
            builder: (context, state) {
              if (state.isSuccessState) {
                return SizedBox(
                  child: Text(state.userProfile),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const Divider(),
          BlocBuilder<DeviceInfoBloc, DeviceInfoState>(
            bloc: sl.get<DeviceInfoBloc>()..add(DeviceInfoCall()),
            builder: (context, state) {
              if (state is DeviceInfoSuccess) {
                return SizedBox(
                  child: Text(state.deviceName),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          BlocSelector<ProfileBloc, ProfileState, String>(
            bloc: sl.get<ProfileBloc>()..add(const ProfileInitEvent()),
            selector: (state) => state.userName,
            builder: (context, value) {
              return Text(value);
            },
          ),
          const Divider(),
          BlocBuilder<ProfileBloc, ProfileState>(
            bloc: sl.get<ProfileBloc>()..add(const GetDataFromBackendEvent()),
            builder: (context, state) {
              if (state is ProfileFBSuccess) {
                return SizedBox(
                  child: Text(state.userFBName),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              sl.get<InternetGuard>()(
                checker: (value) {
                  if (value) {
                    action(context: context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              );
            },
            child: const Text('go to details view'),
          )
        ],
      ),
    );
  }

  void action({required BuildContext context}) {
    sl.get<ParamsThroughScreen>().userName = 'Steven Colocho';
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenUserDetail(),
      ),
    );
  }
}

const snackBar = SnackBar(
  content: Text('Yay! No tienes internet!'),
);

const snackBarSuccess = SnackBar(
  content: Text('Yay! ya tienes internet!'),
);
