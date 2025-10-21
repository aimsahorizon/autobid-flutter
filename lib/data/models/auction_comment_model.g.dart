// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuctionComment _$AuctionCommentFromJson(Map<String, dynamic> json) =>
    _AuctionComment(
      id: json['id'] as String,
      auctionId: json['auctionId'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      category:
          $enumDecodeNullable(_$CommentCategoryEnumMap, json['category']) ??
          CommentCategory.general,
      status:
          $enumDecodeNullable(_$CommentStatusEnumMap, json['status']) ??
          CommentStatus.pending,
      isSellerComment: json['isSellerComment'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
      isEdited: json['isEdited'] as bool? ?? false,
      parentCommentId: json['parentCommentId'] as String?,
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      likedBy:
          (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AuctionCommentToJson(_AuctionComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'auctionId': instance.auctionId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
      'category': _$CommentCategoryEnumMap[instance.category]!,
      'status': _$CommentStatusEnumMap[instance.status]!,
      'isSellerComment': instance.isSellerComment,
      'isPinned': instance.isPinned,
      'isEdited': instance.isEdited,
      'parentCommentId': instance.parentCommentId,
      'editedAt': instance.editedAt?.toIso8601String(),
      'likedBy': instance.likedBy,
      'likeCount': instance.likeCount,
    };

const _$CommentCategoryEnumMap = {
  CommentCategory.mechanical: 'mechanical',
  CommentCategory.cosmetic: 'cosmetic',
  CommentCategory.history: 'history',
  CommentCategory.documentation: 'documentation',
  CommentCategory.inspection: 'inspection',
  CommentCategory.shipping: 'shipping',
  CommentCategory.general: 'general',
};

const _$CommentStatusEnumMap = {
  CommentStatus.pending: 'pending',
  CommentStatus.answered: 'answered',
  CommentStatus.resolved: 'resolved',
};
