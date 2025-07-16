import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../style/BaseScreen.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../Blogs/Logic/Blogs_cubit.dart';
import '../../Blogs/Logic/Blogs_state.dart';
import '../../Blogs/UI/blogs.dart';
import '../../OurTeam/Logic/Team_cubit.dart';
import '../../OurTeam/Logic/Team_state.dart';
import '../../OurTeam/Profile Details/UI/ProfileDetails.dart';
import '../../OurTeam/UI/team.dart';

// Bloc States
abstract class SearchState {}
class SearchInitial extends SearchState {
  final String query;
  SearchInitial(this.query);
}

// Bloc Cubit
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial(''));
  void updateQuery(String query) {
    emit(SearchInitial(query));
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final query = (state as SearchInitial).query;
          final TextEditingController _controller = TextEditingController(text: query);
          return Scaffold(
            backgroundColor: AppColors.neutral100,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary700,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.arrow_back, color: AppColors.primary700),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Search',
                      style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral100),
                    ),
                  ],
                ),
              ),
            ),
            body: BaseScreen(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutral100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.neutral600, width: 1),
                    ),
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral1000),
                      decoration: InputDecoration(
                        hintText: 'Search for a Blog or Team member...',
                        hintStyle: AppTexts.contentRegular.copyWith(color: AppColors.neutral600),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        suffixIcon: query.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, color: AppColors.neutral600),
                                onPressed: () {
                                  context.read<SearchCubit>().updateQuery('');
                                },
                              )
                            : null,
                      ),
                      onChanged: (val) {
                        context.read<SearchCubit>().updateQuery(val.trim());
                      },
                      textInputAction: TextInputAction.search,
                      onSubmitted: (val) {
                        context.read<SearchCubit>().updateQuery(val.trim());
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (_) => BlogsCubit()..fetchBlogs()),
                        BlocProvider(create: (_) => TeamCubit()..fetchTeamMembers()),
                      ],
                      child: query.isEmpty
                          ? SizedBox()
                          : _SearchResults(query: query),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// كارد مختصر لعضو الفريق في البحث
class _TeamSearchCard extends StatelessWidget {
  final Map<String, dynamic> member;
  const _TeamSearchCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProfileDetails(memberId: member['_id']),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.primary700),
        ),
        elevation: 0,
        color: AppColors.neutral100,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.neutral200, width: 0.5),
                  image: DecorationImage(
                    image: NetworkImage(member['image']),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'],
                      style: AppTexts.highlightAccent,
                    ),
                    Text(
                      member['track'],
                      style: AppTexts.contentRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SectionCountHeader extends StatelessWidget {
  final String sectionName;
  final int count;
  const SectionCountHeader({required this.sectionName, required this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Results for ',
                  style: AppTexts.featureStandard.copyWith(color: AppColors.neutral600),
                ),
                Text(
                  '"$sectionName"',
                  style: AppTexts.featureEmphasis.copyWith(color: AppColors.primary700),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Text(
          count.toString(),
          style: AppTexts.featureBold.copyWith(color: AppColors.primary700),
        ),
      ],
    );
  }
}

// ويدجت لعرض نتائج البحث مع معالجة حالة عدم وجود نتائج
class _SearchResults extends StatelessWidget {
  final String query;
  const _SearchResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogsCubit, BlogsState>(
      builder: (context, blogsState) {
        return BlocBuilder<TeamCubit, TeamState>(
          builder: (context, teamState) {
            List blogs = [];
            List team = [];
            if (blogsState is BlogsLoaded) {
              blogs = blogsState.blogs.where((b) => b.name.toLowerCase().contains(query.toLowerCase())).toList();
            }
            if (teamState is TeamLoaded) {
              team = teamState.teamMembers.where((m) => m['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
            }
            final noResults = blogs.isEmpty && team.isEmpty;
            if (noResults) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 160,
                      child: Image.asset(
                        'assets/img/not_found.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.search_off, size: 100, color: AppColors.neutral600),
                      ),
                    ),
                    const SizedBox(height: 0),
                    Text(
                      'No Results Found',
                      style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral1000),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We Couldn\'t Find Any Blogs or Team Members Matching Your Search.Try a Different Keyword.',
                      style: AppTexts.contentRegular.copyWith(color: AppColors.neutral400),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (blogs.isNotEmpty) ...[
                    SectionCountHeader(sectionName: query, count: blogs.length),
                    SizedBox(height: 8),
                    ...blogs.map((b) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: BlogCard(blog: b),
                        )),
                    SizedBox(height: 24),
                  ],
                  if (team.isNotEmpty) ...[
                    SectionCountHeader(sectionName: query, count: team.length),
                    SizedBox(height: 8),
                    ...team.map((m) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _TeamSearchCard(member: m),
                        )),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
} 