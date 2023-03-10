import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/search_fragment/search_bloc.dart';
import 'package:haveliapp/home/fragments/search_fragment/search_event.dart';
import 'package:haveliapp/home/fragments/search_fragment/search_state.dart';
import 'package:haveliapp/mywidgets/search_item.dart';

import '../../../auth/auth_bloc.dart';
import '../../../auth/auth_state.dart' as AuthState;
import '../../../constants.dart';

class SearchFragment extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {

      if (state is Failed) {
        if (state.message == UNAUTHENTICATED) {
          BlocProvider.of<AuthBloc>(context).emit(AuthState.UnAuthenticated());
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    }, builder: (context, state) {
      return Column(
        children: [
          SizedBox(
            height: 8,
          ),
          TextField(
            onChanged: (value) {
              if (value.isEmpty || value == null) {
                BlocProvider.of<SearchBloc>(context).emit(Init());
                return;
              }
              BlocProvider.of<SearchBloc>(context).add(Search(value));
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Search Peopole",
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                size: 32,
              ),
            ),
          ),
          Expanded(
            child: state is Loaded
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      if (state is Loaded) {
                        if (index == state.list.length) {
                          if(state.nextUrl != null && !(state is LoadingMore) ){
                            BlocProvider.of<SearchBloc>(context).add(LoadMore(state.nextUrl!));
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                      return SearchItem(state.list[index]);
                    },
                    itemCount: state is Loaded
                        ? state.nextUrl != null
                            ? state.list.length + 1
                            : state.list.length
                        : 0,
                  )
                : state is Loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(),
          ),
        ],
      );
    });
  }
}
