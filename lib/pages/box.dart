import 'package:babay_pro/Utils/NativeApi.dart';
import 'package:babay_pro/api/HttpService.dart';
import 'package:babay_pro/models/community_post_model.dart';
import 'package:flutter/material.dart';

class BoxPage extends StatefulWidget {
  const BoxPage({super.key});

  @override
  State<BoxPage> createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  bool _isLoading = true;
  String? _errorText;
  List<CommunityPostModel> _posts = [];

  @override
  void initState() {
    super.initState();
    _getListData();
  }

  Future<void> _getListData() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final res = await HttpService().get("/posts");
      debugPrint("res--${res.data}");

      final Map<String, dynamic> json = Map<String, dynamic>.from(
        res.data as Map,
      );
      final List<dynamic> rawList = (json["data"] as List?) ?? [];

      setState(() {
        _posts = rawList
            .whereType<Map>()
            .map(
              (item) =>
                  CommunityPostModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      });
    } catch (e) {
      setState(() {
        _errorText = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Text("Community", style: TextStyle(color: Colors.black)),
            const Spacer(),
            IconButton(
              onPressed: _getListData,
              icon: const Icon(Icons.refresh, color: Colors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _getListData,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _topView()),
              if (_isLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_errorText != null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _StatusView(
                    title: "Load failed",
                    message: _errorText!,
                    buttonText: "Retry",
                    onTap: _getListData,
                  ),
                )
              else if (_posts.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _StatusView(
                    title: "No posts yet",
                    message: "Publish your first post and it will show here.",
                    buttonText: "Refresh",
                    onTap: _getListData,
                  ),
                )
              else
                _infoList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topView() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 10),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _posts.isEmpty ? 1 : _posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    child: const Text("Add story"),
                    onTap: ()  async {
                      print("start--");
                      final res = await Nativeapi.openCamera();
                      print("res===$res");
                    },
                  ),
                ],
              ),
            );
          }

          final post = _posts[index - 1];
          final avatar = post.userAvatar;
          final username = post.username.isNotEmpty ? post.username : "User";

          return Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                  child: ClipOval(
                    child: avatar.isNotEmpty
                        ? Image.network(
                            avatar,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _storyAvatarFallback(),
                          )
                        : _storyAvatarFallback(),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 72,
                  child: Text(
                    username,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _storyAvatarFallback() {
    return Container(
      color: const Color(0xFFE2E8F0),
      alignment: Alignment.center,
      child: const Icon(Icons.person, color: Color(0xFF64748B)),
    );
  }

  Widget _infoList() {
    return SliverList.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        final username = post.username.isNotEmpty ? post.username : "User";
        final avatar = post.userAvatar;
        final content = post.content;
        final likeCount = post.likeCount;
        final commentCount = post.commentCount;
        final uploadTime = _formatTime(post.uploadTime);
        final imageUrl = post.coverImageUrl;

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFE2E8F0),
                    backgroundImage: avatar.isNotEmpty
                        ? NetworkImage(avatar)
                        : null,
                    child: avatar.isEmpty
                        ? const Icon(Icons.person, color: Color(0xFF64748B))
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          uploadTime,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (imageUrl.isNotEmpty) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    width: double.infinity,
                    height: 380,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: const Color(0xFFE2E8F0),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint("post image error---$imageUrl --- $error");
                        return Container(
                          color: const Color(0xFFE2E8F0),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            size: 36,
                            color: Color(0xFF64748B),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border, color: Colors.grey),
                  ),
                  Text("$likeCount"),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.grey,
                    ),
                  ),
                  Text("$commentCount"),
                  const Spacer(),
                  Text("Post", style: TextStyle(color: Colors.grey.shade500)),
                ],
              ),
              if (content.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime? date) {
    final localDate = date?.toLocal();
    if (localDate == null) return "";

    final now = DateTime.now();
    final diff = now.difference(localDate);
    if (diff.inMinutes < 1) return "Just now";
    if (diff.inHours < 1) return "${diff.inMinutes}m ago";
    if (diff.inDays < 1) return "${diff.inHours}h ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";

    return "${localDate.year}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}";
  }
}

class _StatusView extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onTap;

  const _StatusView({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onTap, child: Text(buttonText)),
        ],
      ),
    );
  }
}
