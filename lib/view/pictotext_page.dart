import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictotext/bloc/pictotext_bloc.dart';
import 'package:pictotext/view/widgets/widgets.dart';

class PictotextPage extends StatelessWidget {
  const PictotextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PictotextBloc(),
      child: const PictotextView(),
    );
  }
}

class PictotextView extends StatelessWidget {
  const PictotextView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pictotext'),
      ),
      body: BlocBuilder<PictotextBloc, PictotextState>(
        buildWhen: (previous, current) =>
            previous.items.length != current.items.length,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemImage(index: index);
            },
          );
        },
      ),
      floatingActionButton: BlocBuilder<PictotextBloc, PictotextState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case TextStatus.loading:
              return const FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: null,
                child: Icon(Icons.add),
              );
            default:
              return FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onPressed: () =>
                    context.read<PictotextBloc>().add(RecognizeImage()),
                child: const Icon(Icons.add),
              );
          }
        },
      ),
    );
  }
}
