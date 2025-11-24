// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuctionComment {

 String get id; String get auctionId; String get authorId; String get authorName; String get content; DateTime get timestamp; CommentCategory get category; CommentStatus get status; bool get isSellerComment; bool get isPinned; bool get isEdited; String? get parentCommentId;// For replies/threads
 DateTime? get editedAt; List<String> get likedBy; int get likeCount;
/// Create a copy of AuctionComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuctionCommentCopyWith<AuctionComment> get copyWith => _$AuctionCommentCopyWithImpl<AuctionComment>(this as AuctionComment, _$identity);

  /// Serializes this AuctionComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuctionComment&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.content, content) || other.content == content)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSellerComment, isSellerComment) || other.isSellerComment == isSellerComment)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&const DeepCollectionEquality().equals(other.likedBy, likedBy)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,authorId,authorName,content,timestamp,category,status,isSellerComment,isPinned,isEdited,parentCommentId,editedAt,const DeepCollectionEquality().hash(likedBy),likeCount);

@override
String toString() {
  return 'AuctionComment(id: $id, auctionId: $auctionId, authorId: $authorId, authorName: $authorName, content: $content, timestamp: $timestamp, category: $category, status: $status, isSellerComment: $isSellerComment, isPinned: $isPinned, isEdited: $isEdited, parentCommentId: $parentCommentId, editedAt: $editedAt, likedBy: $likedBy, likeCount: $likeCount)';
}


}

/// @nodoc
abstract mixin class $AuctionCommentCopyWith<$Res>  {
  factory $AuctionCommentCopyWith(AuctionComment value, $Res Function(AuctionComment) _then) = _$AuctionCommentCopyWithImpl;
@useResult
$Res call({
 String id, String auctionId, String authorId, String authorName, String content, DateTime timestamp, CommentCategory category, CommentStatus status, bool isSellerComment, bool isPinned, bool isEdited, String? parentCommentId, DateTime? editedAt, List<String> likedBy, int likeCount
});




}
/// @nodoc
class _$AuctionCommentCopyWithImpl<$Res>
    implements $AuctionCommentCopyWith<$Res> {
  _$AuctionCommentCopyWithImpl(this._self, this._then);

  final AuctionComment _self;
  final $Res Function(AuctionComment) _then;

/// Create a copy of AuctionComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? auctionId = null,Object? authorId = null,Object? authorName = null,Object? content = null,Object? timestamp = null,Object? category = null,Object? status = null,Object? isSellerComment = null,Object? isPinned = null,Object? isEdited = null,Object? parentCommentId = freezed,Object? editedAt = freezed,Object? likedBy = null,Object? likeCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CommentCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommentStatus,isSellerComment: null == isSellerComment ? _self.isSellerComment : isSellerComment // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likedBy: null == likedBy ? _self.likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AuctionComment].
extension AuctionCommentPatterns on AuctionComment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuctionComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuctionComment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuctionComment value)  $default,){
final _that = this;
switch (_that) {
case _AuctionComment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuctionComment value)?  $default,){
final _that = this;
switch (_that) {
case _AuctionComment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String auctionId,  String authorId,  String authorName,  String content,  DateTime timestamp,  CommentCategory category,  CommentStatus status,  bool isSellerComment,  bool isPinned,  bool isEdited,  String? parentCommentId,  DateTime? editedAt,  List<String> likedBy,  int likeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuctionComment() when $default != null:
return $default(_that.id,_that.auctionId,_that.authorId,_that.authorName,_that.content,_that.timestamp,_that.category,_that.status,_that.isSellerComment,_that.isPinned,_that.isEdited,_that.parentCommentId,_that.editedAt,_that.likedBy,_that.likeCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String auctionId,  String authorId,  String authorName,  String content,  DateTime timestamp,  CommentCategory category,  CommentStatus status,  bool isSellerComment,  bool isPinned,  bool isEdited,  String? parentCommentId,  DateTime? editedAt,  List<String> likedBy,  int likeCount)  $default,) {final _that = this;
switch (_that) {
case _AuctionComment():
return $default(_that.id,_that.auctionId,_that.authorId,_that.authorName,_that.content,_that.timestamp,_that.category,_that.status,_that.isSellerComment,_that.isPinned,_that.isEdited,_that.parentCommentId,_that.editedAt,_that.likedBy,_that.likeCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String auctionId,  String authorId,  String authorName,  String content,  DateTime timestamp,  CommentCategory category,  CommentStatus status,  bool isSellerComment,  bool isPinned,  bool isEdited,  String? parentCommentId,  DateTime? editedAt,  List<String> likedBy,  int likeCount)?  $default,) {final _that = this;
switch (_that) {
case _AuctionComment() when $default != null:
return $default(_that.id,_that.auctionId,_that.authorId,_that.authorName,_that.content,_that.timestamp,_that.category,_that.status,_that.isSellerComment,_that.isPinned,_that.isEdited,_that.parentCommentId,_that.editedAt,_that.likedBy,_that.likeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuctionComment extends AuctionComment {
  const _AuctionComment({required this.id, required this.auctionId, required this.authorId, required this.authorName, required this.content, required this.timestamp, this.category = CommentCategory.general, this.status = CommentStatus.pending, this.isSellerComment = false, this.isPinned = false, this.isEdited = false, this.parentCommentId, this.editedAt, final  List<String> likedBy = const [], this.likeCount = 0}): _likedBy = likedBy,super._();
  factory _AuctionComment.fromJson(Map<String, dynamic> json) => _$AuctionCommentFromJson(json);

@override final  String id;
@override final  String auctionId;
@override final  String authorId;
@override final  String authorName;
@override final  String content;
@override final  DateTime timestamp;
@override@JsonKey() final  CommentCategory category;
@override@JsonKey() final  CommentStatus status;
@override@JsonKey() final  bool isSellerComment;
@override@JsonKey() final  bool isPinned;
@override@JsonKey() final  bool isEdited;
@override final  String? parentCommentId;
// For replies/threads
@override final  DateTime? editedAt;
 final  List<String> _likedBy;
@override@JsonKey() List<String> get likedBy {
  if (_likedBy is EqualUnmodifiableListView) return _likedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likedBy);
}

@override@JsonKey() final  int likeCount;

/// Create a copy of AuctionComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuctionCommentCopyWith<_AuctionComment> get copyWith => __$AuctionCommentCopyWithImpl<_AuctionComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuctionCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuctionComment&&(identical(other.id, id) || other.id == id)&&(identical(other.auctionId, auctionId) || other.auctionId == auctionId)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.content, content) || other.content == content)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSellerComment, isSellerComment) || other.isSellerComment == isSellerComment)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&const DeepCollectionEquality().equals(other._likedBy, _likedBy)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,auctionId,authorId,authorName,content,timestamp,category,status,isSellerComment,isPinned,isEdited,parentCommentId,editedAt,const DeepCollectionEquality().hash(_likedBy),likeCount);

@override
String toString() {
  return 'AuctionComment(id: $id, auctionId: $auctionId, authorId: $authorId, authorName: $authorName, content: $content, timestamp: $timestamp, category: $category, status: $status, isSellerComment: $isSellerComment, isPinned: $isPinned, isEdited: $isEdited, parentCommentId: $parentCommentId, editedAt: $editedAt, likedBy: $likedBy, likeCount: $likeCount)';
}


}

/// @nodoc
abstract mixin class _$AuctionCommentCopyWith<$Res> implements $AuctionCommentCopyWith<$Res> {
  factory _$AuctionCommentCopyWith(_AuctionComment value, $Res Function(_AuctionComment) _then) = __$AuctionCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String auctionId, String authorId, String authorName, String content, DateTime timestamp, CommentCategory category, CommentStatus status, bool isSellerComment, bool isPinned, bool isEdited, String? parentCommentId, DateTime? editedAt, List<String> likedBy, int likeCount
});




}
/// @nodoc
class __$AuctionCommentCopyWithImpl<$Res>
    implements _$AuctionCommentCopyWith<$Res> {
  __$AuctionCommentCopyWithImpl(this._self, this._then);

  final _AuctionComment _self;
  final $Res Function(_AuctionComment) _then;

/// Create a copy of AuctionComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? auctionId = null,Object? authorId = null,Object? authorName = null,Object? content = null,Object? timestamp = null,Object? category = null,Object? status = null,Object? isSellerComment = null,Object? isPinned = null,Object? isEdited = null,Object? parentCommentId = freezed,Object? editedAt = freezed,Object? likedBy = null,Object? likeCount = null,}) {
  return _then(_AuctionComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,auctionId: null == auctionId ? _self.auctionId : auctionId // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CommentCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CommentStatus,isSellerComment: null == isSellerComment ? _self.isSellerComment : isSellerComment // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likedBy: null == likedBy ? _self._likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
