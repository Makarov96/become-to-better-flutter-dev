import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_dependecy_inversion/feature/user/presenter/bloc/bloc/profile_bloc.dart';
import 'package:sample_dependecy_inversion/packages/device_info/device_info_bloc/device_info_bloc.dart';
import 'package:sample_dependecy_inversion/packages/device_info/device_info_data.dart';
import 'package:sample_dependecy_inversion/sl.dart';

class ScreenUser extends StatelessWidget {
  const ScreenUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) =>
                sl.get<DeviceInfoBloc>()..add(DeviceInfoCall()),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: const _LayoutBodyScreenUser(),
        ));
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
          )
        ],
      ),
    );
  }
}