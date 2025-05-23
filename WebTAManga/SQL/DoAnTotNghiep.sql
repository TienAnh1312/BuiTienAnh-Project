USE [WebManga]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admin_logs]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin_logs](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[admin_id] [int] NULL,
	[action] [nvarchar](255) NULL,
	[target_id] [int] NULL,
	[target_table] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
 CONSTRAINT [PK__admin_lo__9E2397E00F4C406B] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[AdminId] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[password] [nvarchar](255) NULL,
	[role] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
	[RoleId] [int] NULL,
	[ManagerId] [int] NULL,
	[Area] [nvarchar](50) NULL,
	[IsDepartmentHead] [bit] NULL,
 CONSTRAINT [PK__admins__43AA41419291874A] PRIMARY KEY CLUSTERED 
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AvatarFrame]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvatarFrame](
	[AvatarFrameId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[ImagePath] [nvarchar](500) NULL,
	[Price] [float] NULL,
	[Create_at] [datetime] NULL,
	[Update_at] [datetime] NULL,
 CONSTRAINT [PK__AvatarFr__3E7DDDA849C6C766] PRIMARY KEY CLUSTERED 
(
	[AvatarFrameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banners]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banners](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](500) NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](1000) NULL,
	[LinkUrl] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Create_at] [datetime] NULL,
	[Update_at] [datetime] NULL,
 CONSTRAINT [PK__Banners__3214EC077EBFC59D] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryRank]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryRank](
	[CategoryRankId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[RankId] [int] NULL,
	[Create_at] [datetime] NULL,
	[Update_at] [datetime] NULL,
 CONSTRAINT [PK__Category__F6129F6A9BC62E70] PRIMARY KEY CLUSTERED 
(
	[CategoryRankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapter_images]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapter_images](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[ChapterId] [int] NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[Page_number] [int] NOT NULL,
	[StoryId] [int] NULL,
	[Create_at] [datetime] NULL,
	[Update_at] [datetime] NULL,
 CONSTRAINT [PK__chapter___DC9AC9559DDFE85B] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapters]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapters](
	[Chapter_id] [int] IDENTITY(1,1) NOT NULL,
	[Story_id] [int] NULL,
	[Chapter_title] [nvarchar](255) NULL,
	[Created_at] [datetime] NULL,
	[IsLocked] [bit] NULL,
	[Coins] [float] NULL,
	[IsUnlocked] [bit] NULL,
	[ChapterCode] [nvarchar](50) NULL,
	[Update_at] [nchar](10) NULL,
 CONSTRAINT [PK__chapters__745EFE8771004EC1] PRIMARY KEY CLUSTERED 
(
	[Chapter_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[StoryId] [int] NULL,
	[content] [nvarchar](max) NULL,
	[Created_at] [datetime] NULL,
	[ParentCommentId] [int] NULL,
	[StickerId] [int] NULL,
	[chapterId] [int] NULL,
 CONSTRAINT [PK__comments__E7957687FA04305E] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExpHistory]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExpHistory](
	[ExpHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ExpAmount] [int] NOT NULL,
	[Reason] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK__ExpHisto__8ACA2CD66071C7CE] PRIMARY KEY CLUSTERED 
(
	[ExpHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favorites]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorites](
	[Favorite_id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[StoryId] [int] NULL,
	[added_at] [datetime] NULL,
 CONSTRAINT [PK__favorite__46ACF4CB92150085] PRIMARY KEY CLUSTERED 
(
	[Favorite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Followed_stories]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Followed_stories](
	[followId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[StoryId] [int] NULL,
	[followed_at] [datetime] NULL,
	[LastReadChapterId] [int] NULL,
 CONSTRAINT [PK__followed__15A69144C7050AB0] PRIMARY KEY CLUSTERED 
(
	[followId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Genre_id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Title] [nvarchar](1000) NULL,
	[Create_at] [datetime] NULL,
	[Update_at] [datetime] NULL,
 CONSTRAINT [PK__genres__18428D42B38D820E] PRIMARY KEY CLUSTERED 
(
	[Genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Level]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Level](
	[LevelId] [int] IDENTITY(1,1) NOT NULL,
	[ExpRequired] [int] NOT NULL,
	[CategoryRankId] [int] NULL,
 CONSTRAINT [PK__Level__09F03C2610170A60] PRIMARY KEY CLUSTERED 
(
	[LevelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagerPermission]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerPermission](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[AdminId] [int] NOT NULL,
	[Module] [varchar](50) NULL,
	[CanView] [bit] NULL,
	[CanEdit] [bit] NULL,
	[CanCreate] [bit] NULL,
	[CanDelete] [bit] NULL,
	[AssignedBy] [int] NOT NULL,
	[AssignedAt] [datetime] NOT NULL,
 CONSTRAINT [PK__ManagerP__EFA6FB2FFC8E26D3] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Message] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[Link] [nvarchar](255) NULL,
	[CommentId] [int] NULL,
 CONSTRAINT [PK__Notifica__20CF2E124DDDFDA5] PRIMARY KEY CLUSTERED 
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasedAvatarFrame]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasedAvatarFrame](
	[PurchasedAvatarFrameId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[AvatarFrameId] [int] NULL,
	[PurchasedAt] [datetime] NOT NULL,
 CONSTRAINT [PK__Purchase__162E4245AF898F93] PRIMARY KEY CLUSTERED 
(
	[PurchasedAvatarFrameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasedChapter]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasedChapter](
	[PurchasedChapterId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ChapterId] [int] NULL,
	[PurchasedAt] [datetime] NULL,
	[ChapterCode] [nvarchar](50) NULL,
 CONSTRAINT [PK__Purchase__D253D2F24EED3440] PRIMARY KEY CLUSTERED 
(
	[PurchasedChapterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rank]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rank](
	[RankId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Create_at] [datetime] NULL,
	[Update_at] [datetime] NULL,
 CONSTRAINT [PK__Rank__B37AF876EF567386] PRIMARY KEY CLUSTERED 
(
	[RankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[rating_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[story_id] [int] NULL,
	[rating] [tinyint] NOT NULL,
	[created_at] [datetime] NULL,
 CONSTRAINT [PK__ratings__D35B278BF3CCAC4C] PRIMARY KEY CLUSTERED 
(
	[rating_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reading_history]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reading_history](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[story_id] [int] NULL,
	[chapter_id] [int] NULL,
	[last_read_at] [datetime] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
 CONSTRAINT [PK__reading___096AA2E9F47ADE32] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RechargeHistory]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RechargeHistory](
	[RechargeId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Amount] [int] NOT NULL,
	[Coins] [float] NOT NULL,
	[Status] [nvarchar](20) NULL,
	[MomoTransactionId] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[CompletedAt] [datetime] NULL,
	[PaymentMethod] [nchar](255) NULL,
 CONSTRAINT [PK__Recharge__C58945F67E82AD07] PRIMARY KEY CLUSTERED 
(
	[RechargeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[Description] [nvarchar](200) NULL,
 CONSTRAINT [PK__Roles__8AFACE1AE8A91B48] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sticker]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sticker](
	[StickerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[ImagePath] [nvarchar](500) NULL,
	[Create_at] [datetime] NULL,
	[Update_at] [datetime] NULL,
 CONSTRAINT [PK__Sticker__49D93489D60D4508] PRIMARY KEY CLUSTERED 
(
	[StickerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stories]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stories](
	[story_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NULL,
	[author] [nvarchar](100) NULL,
	[description] [nvarchar](max) NULL,
	[cover_image] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[IsCompleted] [bit] NOT NULL,
	[LastUpdatedAt] [datetime] NULL,
	[IsHot] [bit] NOT NULL,
	[IsNew] [bit] NOT NULL,
	[storyCode] [nvarchar](50) NULL,
	[view] [int] NULL,
 CONSTRAINT [PK__stories__66339C5649B23FA7] PRIMARY KEY CLUSTERED 
(
	[story_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Story_genres]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Story_genres](
	[story_genre_id] [int] IDENTITY(1,1) NOT NULL,
	[story_id] [int] NULL,
	[genre_id] [int] NULL,
 CONSTRAINT [PK__story_ge__B78B7C18999E6C04] PRIMARY KEY CLUSTERED 
(
	[story_genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Amount] [int] NOT NULL,
	[Coins] [int] NOT NULL,
	[TransactionStatus] [nvarchar](50) NULL,
	[VnpayTransactionId] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK__Transact__55433A6B91C5C929] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/17/2025 11:43:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Password] [nvarchar](255) NULL,
	[Created_at] [datetime] NULL,
	[RankId] [int] NULL,
	[Avatar] [nvarchar](255) NULL,
	[Level] [float] NOT NULL,
	[ExpPoints] [float] NULL,
	[AvatarFrameId] [int] NULL,
	[Coins] [float] NULL,
	[CategoryRankId] [int] NULL,
	[ShakeCount] [int] NULL,
	[VerificationCode] [nvarchar](50) NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[VerificationCodeExpires] [datetime] NULL,
	[VipLevel] [int] NOT NULL,
	[TotalRechargedCoins] [float] NOT NULL,
	[ConfirmPassword] [nvarchar](255) NULL,
	[Updated_at] [datetime] NULL,
 CONSTRAINT [PK__users__B9BE370FED03E79E] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[admin_logs] ON 

INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (1, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:06:33.563' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (2, 1, N'Login', 1, N'Admins', CAST(N'2025-04-18T15:07:33.460' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (3, 1, N'Login', 1, N'Admins', CAST(N'2025-04-18T15:08:01.563' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (4, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:08:06.110' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (5, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:08:44.870' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (6, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:10:15.433' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (7, 1, N'Login', 1, N'Admins', CAST(N'2025-04-18T15:16:36.533' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (8, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:16:43.173' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (9, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:18:18.390' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (10, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:19:52.707' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (11, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:21:37.420' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (12, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:34:13.460' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (13, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:38:19.657' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (14, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:40:25.530' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (15, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:42:09.837' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (16, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:45:01.667' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (17, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:45:35.040' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (18, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:47:32.953' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (19, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:49:08.033' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (20, 1, N'Login', 1, N'Admins', CAST(N'2025-04-18T15:49:13.240' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (21, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:49:18.900' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (22, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T15:51:10.990' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (23, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T16:03:41.460' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (24, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T16:03:49.533' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (25, 3, N'Login', 3, N'Admins', CAST(N'2025-04-18T16:05:48.290' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (26, 1, N'Login', 1, N'Admins', CAST(N'2025-04-19T19:44:13.043' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (27, 1, N'Login', 1, N'Admins', CAST(N'2025-04-19T19:45:36.570' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (28, 3, N'Login', 3, N'Admins', CAST(N'2025-04-19T19:53:08.547' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (29, 1, N'Login', 1, N'Admins', CAST(N'2025-04-19T19:53:16.603' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (30, 1, N'Login', 1, N'Admins', CAST(N'2025-04-19T19:54:30.597' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (31, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T08:36:36.790' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (32, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T08:36:56.993' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (33, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T08:38:51.687' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (34, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T09:16:33.937' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (35, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T09:16:49.450' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (36, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T09:17:34.230' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (37, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T09:22:42.720' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (38, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T09:24:48.887' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (39, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T09:25:17.973' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (40, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T10:00:38.873' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (41, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T13:59:06.237' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (42, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T13:59:44.820' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (43, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T14:00:09.473' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (44, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T14:02:13.297' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (45, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T14:02:55.887' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (46, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T14:29:10.497' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (47, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T14:35:40.567' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (48, 3, N'AssignPermission', 1, N'ManagerPermission', CAST(N'2025-04-21T14:37:20.193' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (49, 3, N'AssignPermission', 2, N'ManagerPermission', CAST(N'2025-04-21T14:38:00.397' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (50, 3, N'AssignPermission', 3, N'ManagerPermission', CAST(N'2025-04-21T14:38:25.750' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (51, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T14:39:02.643' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (52, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T15:00:30.420' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (53, 4, N'Login', 4, N'Admins', CAST(N'2025-04-21T15:02:37.513' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (54, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T15:02:48.530' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (55, 1, N'AssignPermission', 4, N'ManagerPermission', CAST(N'2025-04-21T15:02:57.703' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (56, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T15:06:07.337' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (57, 1, N'AssignPermission', 5, N'ManagerPermission', CAST(N'2025-04-21T15:09:13.883' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (58, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T15:09:53.033' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (59, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T15:49:27.437' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (60, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T16:28:13.717' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (61, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:28:57.843' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (62, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T16:29:24.213' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (63, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:30:06.830' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (64, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T16:33:16.697' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (65, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:33:22.300' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (66, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:37:33.777' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (67, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:45:38.450' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (68, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T16:46:48.310' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (69, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:46:58.567' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (70, 1, N'Login', 1, N'Admins', CAST(N'2025-04-21T16:49:45.830' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (71, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:54:12.257' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (72, 3, N'Login', 3, N'Admins', CAST(N'2025-04-21T16:55:58.613' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (73, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T13:53:28.607' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (74, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T16:04:07.850' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (75, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:10:42.200' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (76, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T16:13:33.933' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (77, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:13:42.080' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (78, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T16:13:48.990' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (79, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:14:06.390' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (80, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:36:50.903' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (81, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T16:42:39.057' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (82, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:43:12.520' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (83, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T16:43:29.647' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (84, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:43:56.797' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (85, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:44:39.997' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (86, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T16:44:45.120' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (87, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:46:39.773' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (88, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T16:55:55.833' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (89, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T17:10:44.713' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (90, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T17:18:36.297' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (91, 3, N'Login', 3, N'Admins', CAST(N'2025-04-22T17:19:06.743' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (92, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T17:20:40.713' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (93, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T18:06:55.817' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (94, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T18:09:00.360' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (95, 1, N'Login', 1, N'Admins', CAST(N'2025-04-22T18:10:27.777' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (96, 1, N'Created admin NhanVien2 with role UserManager', 5, N'Admins', CAST(N'2025-04-22T18:11:39.527' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (97, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T14:02:46.867' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (98, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T14:20:35.117' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (99, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T14:34:52.360' AS DateTime))
GO
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (100, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T14:47:27.217' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (101, 3, N'Login', 3, N'Admins', CAST(N'2025-04-23T14:48:23.760' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (102, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T14:48:28.357' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (103, 1, N'Updated permissions for admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T14:48:34.107' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (104, 1, N'Updated permissions for admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T14:48:43.703' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (105, 1, N'Updated permissions for admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T14:48:47.067' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (106, 3, N'Login', 3, N'Admins', CAST(N'2025-04-23T14:48:57.773' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (107, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T14:49:30.233' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (108, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T14:59:07.773' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (109, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T16:38:29.127' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (110, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T16:40:49.527' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (111, 3, N'Login', 3, N'Admins', CAST(N'2025-04-23T16:41:12.227' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (112, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T16:41:30.863' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (113, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T16:42:01.077' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (114, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T16:42:11.890' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (115, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T16:44:45.880' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (116, 3, N'Login', 3, N'Admins', CAST(N'2025-04-23T16:44:58.020' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (117, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T16:45:21.520' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (118, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T16:47:59.540' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (119, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T18:03:51.333' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (120, 1, N'Login', 1, N'Admins', CAST(N'2025-04-23T18:35:06.253' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (121, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-23T18:36:00.093' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (122, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T09:02:02.477' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (123, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T10:21:55.627' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (124, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T13:45:13.197' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (125, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T13:48:42.787' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (126, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T13:50:46.637' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (127, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T13:51:47.980' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (128, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T13:52:56.367' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (129, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-24T14:09:09.080' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (130, 3, N'Login', 3, N'Admins', CAST(N'2025-04-24T14:09:13.780' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (131, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T14:09:34.043' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (132, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T14:29:09.040' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (133, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T15:08:41.817' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (134, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T15:44:35.210' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (135, 1, N'Cập nhật quyền cho admin Aday1', 4, N'ManagerPermissions', CAST(N'2025-04-24T15:46:44.833' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (136, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T15:51:53.857' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (137, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:16:34.220' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (138, 1, N'Chỉ định Bùi Tiến Anh làm trưởng nhóm với vai trò 2', 3, N'Admins', CAST(N'2025-04-24T16:17:00.787' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (139, 1, N'Thêm admin Aday1 vào nhóm của Bùi Tiến Anh', 4, N'Admins', CAST(N'2025-04-24T16:17:11.083' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (140, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-24T16:17:26.220' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (141, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:17:47.973' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (142, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:18:01.533' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (143, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-24T16:18:10.880' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (144, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:18:15.893' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (145, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:18:27.133' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (146, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-24T16:18:38.500' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (147, 1, N'Cập nhật quyền cho admin Aday1', 4, N'ManagerPermissions', CAST(N'2025-04-24T16:18:49.587' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (148, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:19:32.657' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (149, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:19:39.023' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (150, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:20:23.360' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (151, 1, N'Cập nhật quyền cho admin Aday1', 4, N'ManagerPermissions', CAST(N'2025-04-24T16:20:29.367' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (152, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:20:40.483' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (153, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:20:59.730' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (154, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:21:56.447' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (155, 3, N'Login', 3, N'Admins', CAST(N'2025-04-24T16:22:25.250' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (156, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:22:45.483' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (157, 3, N'Login', 3, N'Admins', CAST(N'2025-04-24T16:27:19.623' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (158, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:27:32.480' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (159, 1, N'Cập nhật quyền cho admin Bùi Tiến Anh', 3, N'ManagerPermissions', CAST(N'2025-04-24T16:28:05.363' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (160, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:28:23.063' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (161, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:28:28.123' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (162, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:49:12.203' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (163, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:54:52.000' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (164, 1, N'Cập nhật quyền cho admin Aday1: Modules [Banners, Ranks]', 4, N'ManagerPermissions', CAST(N'2025-04-24T16:55:07.770' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (165, 1, N'Cập nhật quyền cho admin Aday1: Modules [Banners, Ranks]', 4, N'ManagerPermissions', CAST(N'2025-04-24T16:55:14.593' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (166, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:55:23.280' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (167, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:55:33.523' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (168, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T16:56:07.153' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (169, 3, N'Login', 3, N'Admins', CAST(N'2025-04-24T16:56:32.593' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (170, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T16:56:37.080' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (171, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T17:54:56.663' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (172, 1, N'Cập nhật quyền cho admin Aday1: Modules [Banners, Ranks, Genres]', 4, N'ManagerPermissions', CAST(N'2025-04-24T17:55:17.843' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (173, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T17:55:26.547' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (174, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T17:55:31.130' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (175, 1, N'Cập nhật quyền cho admin Aday1: Modules [Banners, Ranks, Genres]', 4, N'ManagerPermissions', CAST(N'2025-04-24T17:55:39.490' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (176, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T17:55:46.660' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (177, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T17:58:35.580' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (178, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T17:58:46.613' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (179, 1, N'Cập nhật quyền cho admin Aday1: Modules [Banners, Ranks, Genres]', 4, N'ManagerPermissions', CAST(N'2025-04-24T17:59:05.353' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (180, 4, N'Login', 4, N'Admins', CAST(N'2025-04-24T17:59:14.670' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (181, 3, N'Login', 3, N'Admins', CAST(N'2025-04-24T17:59:32.060' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (182, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T18:01:15.610' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (183, 3, N'Login', 3, N'Admins', CAST(N'2025-04-24T18:05:30.753' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (184, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T18:05:34.707' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (185, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T18:06:47.890' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (186, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T18:07:10.917' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (187, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T18:08:05.633' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (188, 1, N'Chỉ định Aday1 làm trưởng nhóm với vai trò 2', 4, N'Admins', CAST(N'2025-04-24T18:08:20.550' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (189, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T18:10:49.730' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (190, 1, N'Login', 1, N'Admins', CAST(N'2025-04-24T18:12:17.120' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (191, 1, N'Login', 1, N'Admins', CAST(N'2025-04-25T14:23:41.467' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (192, 1, N'Login', 1, N'Admins', CAST(N'2025-04-25T14:58:41.657' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (193, 1, N'Cập nhật quyền cho admin Aday1: Modules [Banners, Ranks, Genres]', 4, N'ManagerPermissions', CAST(N'2025-04-25T14:58:52.547' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (194, 4, N'Login', 4, N'Admins', CAST(N'2025-04-25T14:58:58.057' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (195, 1, N'Login', 1, N'Admins', CAST(N'2025-04-25T14:59:07.297' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (196, 1, N'Login', 1, N'Admins', CAST(N'2025-04-25T15:48:52.953' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (197, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T10:34:52.543' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (198, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T14:05:07.053' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (199, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T14:35:06.717' AS DateTime))
GO
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (200, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T14:35:08.237' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (201, 1, N'Viewed Admin Logs (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:21.527' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (202, 1, N'Viewed Admin Logs (Page: 2, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:32.117' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (203, 1, N'Viewed Admin Logs (Page: 3, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:42.433' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (204, 1, N'Viewed Admin Logs (Page: 4, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:43.737' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (205, 1, N'Viewed Admin Logs (Page: 5, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:45.017' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (206, 1, N'Viewed Admin Logs (Page: 6, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:46.553' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (207, 1, N'Viewed Admin Logs (Page: 7, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:47.403' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (208, 1, N'Viewed Admin Logs (Page: 6, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:35:52.387' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (209, 1, N'Viewed Admin Logs (Page: 5, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:36:00.853' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (210, 1, N'Viewed Admin Logs (Page: 4, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:36:01.813' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (211, 1, N'Viewed Admin Logs (Page: 3, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:36:02.183' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (212, 1, N'Viewed Admin Logs (Page: 2, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:36:02.373' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (213, 1, N'Viewed Admin Logs (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:36:04.640' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (216, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T14:41:59.980' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (217, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T14:42:05.267' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (218, 1, N'Viewed Admin Logs (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:42:08.270' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (219, 1, N'Viewed Admin Logs (Page: 2, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:42:10.877' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (220, 1, N'Viewed Admin Logs (Page: 3, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:42:13.100' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (221, 1, N'Viewed Admin Logs (Page: 4, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:42:16.673' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (222, 1, N'Viewed Admin Logs (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T14:42:19.393' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (223, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T14:57:33.163' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (224, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T14:57:36.103' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (225, 1, N'Accessed AssignPermissions for Admin Aday1 (AdminId: 4) (Performed by Admin, Area: )', 4, N'ManagerPermissions', CAST(N'2025-04-28T14:57:38.710' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (226, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T14:57:43.187' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (229, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:04:54.537' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (230, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:04:57.957' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (231, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:10.353' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (232, 1, N'Viewed User Actions (Page: 2, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:14.243' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (233, 1, N'Viewed User Actions (Page: 3, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:15.563' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (234, 1, N'Viewed User Actions (Page: 2, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:17.057' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (235, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:22.300' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (236, 1, N'Viewed User Actions (Page: 3, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:23.913' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (237, 1, N'Viewed User Actions (Page: 4, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:25.170' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (238, 1, N'Viewed User Actions (Page: 5, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:26.517' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (239, 1, N'Viewed User Actions (Page: 6, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:27.300' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (240, 1, N'Viewed User Actions (Page: 7, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:28.167' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (241, 1, N'Viewed User Actions (Page: 8, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:28.993' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (242, 1, N'Viewed User Actions (Page: 9, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:29.900' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (243, 1, N'Viewed User Actions (Page: 10, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:30.570' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (244, 1, N'Viewed User Actions (Page: 11, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:31.500' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (245, 1, N'Viewed User Actions (Page: 12, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:32.190' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (246, 1, N'Viewed User Actions (Page: 13, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:32.850' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (247, 1, N'Viewed User Actions (Page: 15, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:33.467' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (248, 1, N'Viewed User Actions (Page: 17, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:34.207' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (249, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:35.513' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (250, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:05:36.637' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (251, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:05:39.800' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (252, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:05:44.910' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (253, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:05:47.937' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (254, 1, N'Accessed AddMemberToGroup for Manager Aday1 (ManagerId: 4) (Performed by Admin, Area: )', 4, N'Admins', CAST(N'2025-04-28T15:05:53.527' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (255, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:05:59.663' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (256, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:06:01.477' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (257, 1, N'Accessed Create Admin page (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:06:03.383' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (258, 1, N'Created admin NhanVien3 with role ContentManager (Area: ) (Performed by Admin, Area: )', 6, N'Admins', CAST(N'2025-04-28T15:06:14.440' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (259, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:06:14.450' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (260, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:06:26.840' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (261, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:06:41.897' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (262, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:06:45.163' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (263, 1, N'Accessed AddMemberToGroup for Manager Bùi Tiến Anh (ManagerId: 3) (Performed by Admin, Area: )', 3, N'Admins', CAST(N'2025-04-28T15:06:47.690' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (264, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:06:51.913' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (265, 1, N'Accessed AddMemberToGroup for Manager Aday1 (ManagerId: 4) (Performed by Admin, Area: )', 4, N'Admins', CAST(N'2025-04-28T15:06:53.907' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (266, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:06:57.440' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (267, 1, N'Accessed CreateGroup (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:07:01.787' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (268, 1, N'Created group: Assigned NhanVien3 as department head with role ContentManager (Area: ) (Performed by Admin, Area: )', 6, N'Admins', CAST(N'2025-04-28T15:07:05.767' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (269, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:07:07.860' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (270, 1, N'Accessed AddMemberToGroup for Manager NhanVien3 (ManagerId: 6) (Performed by Admin, Area: )', 6, N'Admins', CAST(N'2025-04-28T15:07:10.680' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (271, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:07:12.767' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (272, 1, N'Accessed AddMemberToGroup for Manager Bùi Tiến Anh (ManagerId: 3) (Performed by Admin, Area: )', 3, N'Admins', CAST(N'2025-04-28T15:07:16.413' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (273, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:07:21.000' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (274, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:07:28.970' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (275, 1, N'Viewed User Actions (Page: 2, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:07:40.127' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (276, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:07:40.867' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (277, 1, N'Viewed User Actions (Page: 29, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:08:31.957' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (278, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:08:33.497' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (279, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:09:01.120' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (280, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:09:06.073' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (281, 1, N'Viewed User Actions (Page: 19, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:09:09.540' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (282, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:12:45.873' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (283, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:13:03.390' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (284, 1, N'Accessed AssignPermissions for Admin Aday1 (AdminId: 4) (Performed by Admin, Area: )', 4, N'ManagerPermissions', CAST(N'2025-04-28T15:13:05.350' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (285, 1, N'Accessed AssignPermissions for Admin Aday1 (AdminId: 4) (Performed by Admin, Area: )', 4, N'ManagerPermissions', CAST(N'2025-04-28T15:13:12.693' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (286, 1, N'Updated permissions for admin Aday1: Modules [Banners, Ranks, Genres] (Area: ) (Performed by Admin, Area: )', 4, N'ManagerPermissions', CAST(N'2025-04-28T15:13:26.307' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (287, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:13:26.320' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (288, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:13:28.340' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (289, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:13:32.650' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (290, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:14:47.330' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (291, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:14:47.623' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (292, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:16:20.683' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (293, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:16:21.807' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (294, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:16:25.603' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (295, 1, N'Accessed AssignPermissions for Admin Aday1 (AdminId: 4) (Performed by Admin, Area: )', 4, N'ManagerPermissions', CAST(N'2025-04-28T15:16:27.937' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (296, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:16:31.463' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (297, 1, N'Accessed AssignPermissions for Admin Aday1 (AdminId: 4) (Performed by Admin, Area: )', 4, N'ManagerPermissions', CAST(N'2025-04-28T15:16:36.563' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (298, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:16:42.670' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (299, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:20:11.293' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (300, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:20:18.753' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (301, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:20:27.630' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (302, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:20:37.300' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (303, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:21:15.907' AS DateTime))
GO
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (304, 1, N'Accessed Admin Index (Page: 1, SearchUsername: , SearchEmail: ) (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:21:18.533' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (305, 1, N'Accessed ManageGroups (Performed by Admin, Area: )', NULL, N'Admins', CAST(N'2025-04-28T15:21:20.817' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (306, 1, N'Viewed User Actions (Page: 1, SearchAction: ) (Performed by Admin, Area: )', NULL, N'AdminLogs', CAST(N'2025-04-28T15:21:23.757' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (307, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:28:21.820' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (308, 4, N'Login', 4, N'Admins', CAST(N'2025-04-28T15:30:00.257' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (309, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:30:14.933' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (310, 1, N'Created admin NhanVien4 with role ContentManager', 7, N'Admins', CAST(N'2025-04-28T15:30:59.110' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (311, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:45:37.077' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (312, 1, N'Thêm admin NhanVien4 vào nhóm của Bùi Tiến Anh', 7, N'Admins', CAST(N'2025-04-28T15:45:43.343' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (313, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:46:11.457' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (314, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T15:47:35.593' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (315, 1, N'Thêm admin Admin vào nhóm của Aday1', 1, N'Admins', CAST(N'2025-04-28T15:47:44.210' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (316, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:05:40.073' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (317, 1, N'Created admin NhanVien4 with role ContentManager', 8, N'Admins', CAST(N'2025-04-28T16:06:34.687' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (318, 1, N'Thêm admin NhanVien4 vào nhóm của Bùi Tiến Anh', 8, N'Admins', CAST(N'2025-04-28T16:06:47.247' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (319, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:13:01.753' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (320, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:16:33.670' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (321, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:17:08.970' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (322, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:19:56.837' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (323, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:20:33.133' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (324, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:22:52.703' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (325, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:25:36.070' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (326, 1, N'Created admin NhanVien2 with role ContentManager', 9, N'Admins', CAST(N'2025-04-28T16:28:08.097' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (327, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:35:29.580' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (328, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:36:40.387' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (329, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:40:07.270' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (330, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:53:53.053' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (331, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:54:58.067' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (332, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:57:26.263' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (333, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:58:35.020' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (334, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T16:59:20.037' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (335, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T17:00:51.607' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (336, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T17:06:22.417' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (337, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T17:09:48.387' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (338, 1, N'Login', 1, N'Admins', CAST(N'2025-04-28T19:04:25.473' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (339, 1, N'Login', 1, N'Admins', CAST(N'2025-05-04T18:02:05.357' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (340, 1, N'Login', 1, N'Admins', CAST(N'2025-05-04T18:11:08.650' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (341, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:00:56.047' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (342, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:11:12.797' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (343, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:12:22.067' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (344, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:12:39.093' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (345, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:21:59.677' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (346, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:26:52.107' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (347, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:31:00.307' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (348, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:33:14.317' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (349, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:37:47.493' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (350, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:41:49.020' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (351, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:44:10.837' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (352, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:44:32.107' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (353, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:45:14.627' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (354, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:46:13.683' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (355, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:50:01.340' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (356, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:57:31.627' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (357, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T14:58:50.707' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (358, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:26:09.720' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (359, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:31:05.963' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (360, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:31:37.187' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (361, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:32:26.733' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (362, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:36:39.667' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (363, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:37:03.040' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (364, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:38:04.597' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (365, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:40:10.697' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (366, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:41:43.990' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (367, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:43:42.750' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (368, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:44:17.580' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (369, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:45:51.140' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (370, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:46:59.010' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (371, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:52:43.613' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (372, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:53:59.330' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (373, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:54:25.573' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (374, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T15:58:02.067' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (375, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:00:30.817' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (376, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:01:07.353' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (377, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:02:29.160' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (378, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:03:17.350' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (379, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:05:34.750' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (380, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:07:02.147' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (381, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:10:23.117' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (382, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:11:40.590' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (383, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:13:33.717' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (384, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:14:09.300' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (385, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:22:20.037' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (386, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:22:48.120' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (387, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:24:11.660' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (388, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:25:21.607' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (389, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:37:21.993' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (390, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:38:23.587' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (391, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:38:56.083' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (392, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:39:26.700' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (393, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T16:40:05.577' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (394, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:01:43.830' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (395, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:05:24.237' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (396, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:06:17.343' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (397, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:08:47.540' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (398, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:10:43.873' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (399, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:12:48.950' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (400, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:20:26.820' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (401, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:22:41.853' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (402, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:25:17.643' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (403, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:26:44.037' AS DateTime))
GO
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (404, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:27:56.683' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (405, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:31:03.097' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (406, 1, N'Login', 1, N'Admins', CAST(N'2025-05-05T17:31:41.893' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (407, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T13:51:03.080' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (408, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T13:54:12.677' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (409, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T13:56:26.390' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (410, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T13:56:26.627' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (411, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:00:16.343' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (412, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:01:38.140' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (413, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:01:55.353' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (414, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:03:29.367' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (415, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:04:46.023' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (416, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:06:30.763' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (417, 3, N'Login', 3, N'Admins', CAST(N'2025-05-06T14:06:40.630' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (418, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:08:15.443' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (419, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:09:05.367' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (420, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:10:34.067' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (421, 3, N'Login', 3, N'Admins', CAST(N'2025-05-06T14:12:19.920' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (422, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:14:27.627' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (423, 3, N'Login', 3, N'Admins', CAST(N'2025-05-06T14:14:32.483' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (424, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:14:55.763' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (425, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:22:52.470' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (426, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:27:51.753' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (427, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:28:41.687' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (428, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:37:41.190' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (429, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:43:19.757' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (430, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:44:50.957' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (431, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:46:29.257' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (432, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:49:18.090' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (433, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:51:51.083' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (434, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T14:54:30.637' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (435, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:03:48.007' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (436, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:09:47.890' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (437, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:11:40.250' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (438, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:13:27.357' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (439, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:15:07.047' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (440, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:16:11.547' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (441, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:18:56.467' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (442, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:22:39.537' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (443, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:23:41.703' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (444, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:26:18.853' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (445, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:27:50.360' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (446, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:29:44.647' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (447, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:32:44.633' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (448, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:33:18.003' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (449, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:49:33.623' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (450, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:50:22.747' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (451, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:51:19.480' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (452, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:52:11.983' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (453, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T15:55:38.817' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (454, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:03:16.123' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (455, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:06:11.213' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (456, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:07:01.033' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (457, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:07:41.933' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (458, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:11:59.030' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (459, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:13:34.807' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (460, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:15:21.323' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (461, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:18:14.317' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (462, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:19:55.247' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (463, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:22:25.463' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (464, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:22:59.333' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (465, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:24:42.033' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (466, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:27:08.907' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (467, 1, N'Login', 1, N'Admins', CAST(N'2025-05-06T16:38:28.970' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (468, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:04:19.963' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (469, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:09:57.767' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (470, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:20:15.483' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (471, 3, N'Login', 3, N'Admins', CAST(N'2025-05-07T14:20:22.193' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (472, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:20:33.800' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (473, 3, N'Login', 3, N'Admins', CAST(N'2025-05-07T14:20:58.137' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (474, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:21:02.423' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (475, 4, N'Login', 4, N'Admins', CAST(N'2025-05-07T14:21:20.363' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (476, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:21:32.553' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (477, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:24:28.530' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (478, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:25:15.643' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (479, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:29:49.427' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (480, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:33:26.067' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (481, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:33:51.083' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (482, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:36:35.490' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (483, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T14:57:47.777' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (484, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T15:01:26.293' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (485, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T15:02:24.993' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (486, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T15:26:20.057' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (487, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T15:30:15.250' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (488, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T15:41:57.943' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (489, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T15:44:24.297' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (490, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T15:57:32.990' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (491, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T16:06:21.793' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (492, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T16:07:21.430' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (493, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T16:20:12.277' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (494, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T16:25:15.387' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (495, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T16:26:22.147' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (496, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T16:29:23.193' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (497, 1, N'Login', 1, N'Admins', CAST(N'2025-05-07T18:04:33.153' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (498, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T08:28:59.570' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (499, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T08:29:45.637' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (500, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T08:38:28.093' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (501, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T08:51:02.893' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (502, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T09:02:18.153' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (503, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T12:22:38.110' AS DateTime))
GO
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (504, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T12:37:19.697' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (505, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T13:39:36.300' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (506, 5, N'Login', 5, N'Admins', CAST(N'2025-05-08T13:40:28.077' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (507, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T13:40:46.833' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (508, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T13:49:47.460' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (509, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T13:51:16.500' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (510, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T13:52:25.907' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (511, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T13:56:25.550' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (512, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T13:57:07.650' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (513, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:03:03.190' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (514, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:05:47.760' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (515, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:09:29.587' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (516, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:13:21.770' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (517, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:15:49.270' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (518, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:23:17.247' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (519, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:23:50.630' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (520, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:28:38.463' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (521, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:31:44.317' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (522, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:32:22.517' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (523, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:51:46.027' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (524, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:52:21.163' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (525, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:53:20.963' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (526, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:54:21.020' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (527, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:55:56.907' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (528, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:58:01.937' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (529, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T14:59:53.317' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (530, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:00:56.320' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (531, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:10:10.387' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (532, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:15:56.337' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (533, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:24:01.503' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (534, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:27:12.607' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (535, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:35:55.267' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (536, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:42:20.983' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (537, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:45:52.637' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (538, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:47:41.183' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (539, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:51:57.520' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (540, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T15:59:18.377' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (541, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T16:02:52.213' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (542, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T16:09:09.250' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (543, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T16:15:42.303' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (544, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T16:16:06.097' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (545, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T16:19:14.717' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (546, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T16:22:20.563' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (547, 1, N'Login', 1, N'Admins', CAST(N'2025-05-08T16:23:15.177' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (548, 1, N'Login', 1, N'Admins', CAST(N'2025-05-10T14:54:32.243' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (549, 1, N'Login', 1, N'Admins', CAST(N'2025-05-12T11:17:15.697' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (550, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T08:57:48.773' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (551, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T10:08:43.770' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (552, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T15:36:28.997' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (553, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T16:23:33.460' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (554, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T16:29:10.957' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (555, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T16:32:01.627' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (556, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T16:37:10.253' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (557, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T16:55:37.677' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (558, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T16:59:19.910' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (559, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T17:00:26.010' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (560, 1, N'Login', 1, N'Admins', CAST(N'2025-05-13T17:22:53.097' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (561, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T09:09:20.537' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (562, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T10:01:40.827' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (563, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T10:39:51.933' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (564, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T10:41:41.613' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (565, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T11:01:27.333' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (566, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T14:27:11.203' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (567, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T14:32:21.143' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (568, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:24:08.877' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (569, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:25:32.970' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (570, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:31:03.823' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (571, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:32:31.277' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (572, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:33:42.557' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (573, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:41:57.493' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (574, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:43:38.970' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (575, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:44:56.733' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (576, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:45:47.513' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (577, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:48:01.827' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (578, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:48:27.597' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (579, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:50:59.950' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (580, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:53:19.707' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (581, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:53:57.723' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (582, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T15:55:48.783' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (583, 1, N'Login', 1, N'Admins', CAST(N'2025-05-14T16:02:25.743' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (584, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T08:51:05.860' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (585, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T08:53:02.830' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (586, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T15:47:23.710' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (587, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T15:57:36.047' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (588, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T15:59:53.530' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (589, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:02:26.343' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (590, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:03:03.520' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (591, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:03:23.810' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (592, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:09:45.003' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (593, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:10:32.567' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (594, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:12:41.727' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (595, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:14:47.983' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (596, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:18:35.470' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (597, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:22:12.590' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (598, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:25:23.737' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (599, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:28:13.877' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (600, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:30:44.977' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (601, 1, N'Login', 1, N'Admins', CAST(N'2025-05-15T16:40:07.123' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (602, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T11:04:47.297' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (603, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T11:39:03.830' AS DateTime))
GO
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (604, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T11:41:26.580' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (605, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T11:44:21.743' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (606, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T11:57:12.183' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (607, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T11:58:36.043' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (608, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T13:54:32.750' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (609, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T13:55:50.867' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (610, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T13:57:12.910' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (611, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T14:02:56.887' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (612, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T14:06:25.610' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (613, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T14:10:45.747' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (614, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T14:11:56.807' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (615, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T14:12:47.447' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (616, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T14:33:23.340' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (617, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T14:45:57.163' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (618, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T15:06:49.693' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (619, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T16:15:13.473' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (620, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T16:19:51.607' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (621, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T16:20:29.593' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (622, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T16:24:12.397' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (623, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T16:25:51.933' AS DateTime))
INSERT [dbo].[admin_logs] ([log_id], [admin_id], [action], [target_id], [target_table], [created_at]) VALUES (624, 1, N'Login', 1, N'Admins', CAST(N'2025-05-16T16:58:46.753' AS DateTime))
SET IDENTITY_INSERT [dbo].[admin_logs] OFF
GO
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([AdminId], [username], [email], [password], [role], [created_at], [RoleId], [ManagerId], [Area], [IsDepartmentHead]) VALUES (1, N'Admin', N'admin@gmail.com', N'12345@', NULL, CAST(N'2025-01-20T21:21:43.630' AS DateTime), 1, 4, NULL, NULL)
INSERT [dbo].[Admins] ([AdminId], [username], [email], [password], [role], [created_at], [RoleId], [ManagerId], [Area], [IsDepartmentHead]) VALUES (3, N'Bùi Tiến Anh', N'buitienanh13122003@gmail.com', N'12345@', NULL, CAST(N'2025-01-20T21:22:10.070' AS DateTime), 2, NULL, NULL, 1)
INSERT [dbo].[Admins] ([AdminId], [username], [email], [password], [role], [created_at], [RoleId], [ManagerId], [Area], [IsDepartmentHead]) VALUES (4, N'Aday1', N'btanh13122003@gmail.com', N'12345@', N'moderator', CAST(N'2025-04-21T15:02:24.123' AS DateTime), 2, 3, NULL, 1)
INSERT [dbo].[Admins] ([AdminId], [username], [email], [password], [role], [created_at], [RoleId], [ManagerId], [Area], [IsDepartmentHead]) VALUES (5, N'NhanVien4', N'Nhanvien4@gmail.com', N'12345@', NULL, CAST(N'2025-04-22T18:11:39.000' AS DateTime), 3, NULL, NULL, NULL)
INSERT [dbo].[Admins] ([AdminId], [username], [email], [password], [role], [created_at], [RoleId], [ManagerId], [Area], [IsDepartmentHead]) VALUES (6, N'NhanVien3', N'Nhanvien3@gmail.com', N'$2a$11$5HEu1OlDxmhCLBziCtmimeDYcqZ0E.hC.aRCqRlnPI/K.mDLMRb5u', N'moderator', CAST(N'2025-04-28T15:06:14.410' AS DateTime), 2, NULL, NULL, 1)
INSERT [dbo].[Admins] ([AdminId], [username], [email], [password], [role], [created_at], [RoleId], [ManagerId], [Area], [IsDepartmentHead]) VALUES (8, N'NhanVien5', N'Nhanvien5@gmail.com', N'12345@', NULL, CAST(N'2025-04-28T16:06:34.670' AS DateTime), 2, NULL, NULL, NULL)
INSERT [dbo].[Admins] ([AdminId], [username], [email], [password], [role], [created_at], [RoleId], [ManagerId], [Area], [IsDepartmentHead]) VALUES (9, N'NhanVien2', N'Nhanvien2@gmail.com', N'$2a$11$iCX3k94OOcQ7CSnMaDuxWeHpVw7KSs5pojOGL5bK5rrYu31fTFrAm', N'moderator', CAST(N'2025-04-28T16:28:08.080' AS DateTime), 2, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[AvatarFrame] ON 

INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (6, N'Khung Âm Dương', N'images/admins/avatarFrames/0c0d0c07-494a-4aeb-b520-17969f7b419b.png', 10000, NULL, NULL)
INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (8, N'Khung Đèn Lồng Thế Gian', N'images/admins/avatarFrames/2bf4c532-0dd4-4a38-8a3c-8f5c00417787.png', 12000, NULL, NULL)
INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (9, N'Khung Ý Chí Chiến Đấu', N'images/admins/avatarFrames/0caba127-ea70-449d-9763-ff611014f793.png', 10000, NULL, NULL)
INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (10, N'Khung Thị Trấn Nước', N'images/admins/avatarFrames/518e695e-97df-49d6-ab51-b2034286224f.png', 15000, NULL, NULL)
INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (11, N'Khung Cầu Tuyết Trên Tre', N'images/admins/avatarFrames/5ef6bdf9-7517-42b5-8ef5-f2c9f3ca10f8.png', 10000, NULL, NULL)
INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (12, N'Khung Uber Boss – Phiên tòa xét xử Archdemon', N'images/admins/avatarFrames/f580426e-407a-4044-86cb-225cfea2660f.png', 20000, NULL, NULL)
INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (13, N'Khung Rắn Nuốt Kiếm', N'images/admins/avatarFrames/216089ef-0999-4399-9f1a-edc34f153054.gif', 50000, NULL, NULL)
INSERT [dbo].[AvatarFrame] ([AvatarFrameId], [Name], [ImagePath], [Price], [Create_at], [Update_at]) VALUES (14, N'Khung Người Quyến Rũ', N'images/admins/avatarFrames/d7629445-5b85-4936-8200-5a7c21c6177e.png', 200, NULL, NULL)
SET IDENTITY_INSERT [dbo].[AvatarFrame] OFF
GO
SET IDENTITY_INSERT [dbo].[Banners] ON 

INSERT [dbo].[Banners] ([Id], [ImageUrl], [Title], [Description], [LinkUrl], [IsActive], [DisplayOrder], [Create_at], [Update_at]) VALUES (9, NULL, N'Banner1', N'Banner1', N'images/admins/banner/2eafcbb5-9861-45e5-8907-e357eaa88d3d.jfif', 1, 1, NULL, NULL)
INSERT [dbo].[Banners] ([Id], [ImageUrl], [Title], [Description], [LinkUrl], [IsActive], [DisplayOrder], [Create_at], [Update_at]) VALUES (10, N'Banner 2', N'Banner 2', N'Banner 2', N'images/admins/banner/back3.jfif', 1, 2, NULL, NULL)
INSERT [dbo].[Banners] ([Id], [ImageUrl], [Title], [Description], [LinkUrl], [IsActive], [DisplayOrder], [Create_at], [Update_at]) VALUES (11, N'Banner 3', N'Banner 3', N'Banner 3', N'images/admins/banner/banner5.jfif', 1, 3, NULL, NULL)
INSERT [dbo].[Banners] ([Id], [ImageUrl], [Title], [Description], [LinkUrl], [IsActive], [DisplayOrder], [Create_at], [Update_at]) VALUES (15, NULL, N'Banner6', N'Banner6', N'images/admins/banner/e15b767b-926f-4372-97bc-e04eda1f651e.jfif', 1, 4, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Banners] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoryRank] ON 

INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (3, N'Trúc Cơ', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (4, N'Kết Đan', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (5, N'Nguyên Anh', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (6, N'Hóa Thần', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (7, N'Luyện Hư', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (8, N'Đại Thừa ', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (9, N'Độ Kiếp', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (10, N'Tiên Nhân', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (17, N'Tân Binh', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (18, N'Học Viên Hiệp Sĩ', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (19, N'Hiệp Sĩ Tập Sự', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (20, N'Hiệp Sĩ', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (21, N'Hiệp Sĩ Cao Cấp', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (22, N'Kỵ Sĩ Hoàng Gia', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (23, N'Thánh Kỵ Sỹ', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (24, N'Kiếm Thánh', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (25, N'Đại Hiệp Sĩ', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (26, N'Huyền Thoại Hiệp Sĩ', 2, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (27, N'Pháp Sư Tập Sự', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (28, N'Pháp Sư Tân Binh', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (29, N'Pháp Sư Trung Cấp', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (30, N'Pháp Sư Cao Cấp', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (31, N'Pháp Sư Tinh Nhuệ ', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (32, N'Đại Pháp Sư', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (33, N'Pháp Sư Tối Thượng', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (34, N'Pháp Thánh', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (35, N'Pháp Thần', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (36, N'Chúa Tể Ma Pháp ', 3, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (40, N'Luyện Khí', 1, NULL, NULL)
INSERT [dbo].[CategoryRank] ([CategoryRankId], [Name], [RankId], [Create_at], [Update_at]) VALUES (41, N'Phàm Nhân', 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CategoryRank] OFF
GO
SET IDENTITY_INSERT [dbo].[Chapter_images] ON 

INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5548, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_1.jpeg', 1, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5549, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_2.jpeg', 2, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5550, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_3.jpeg', 3, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5551, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_4.jpeg', 4, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5552, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_5.jpeg', 5, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5553, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_6.jpeg', 6, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5554, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_7.jpeg', 7, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5555, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_8.jpeg', 8, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5556, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_9.jpeg', 9, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5557, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_10.jpeg', 10, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5558, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_11.jpeg', 11, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5559, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_12.jpeg', 12, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5560, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_13.jpeg', 13, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5561, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_14.jpeg', 14, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5562, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_15.jpeg', 15, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5563, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_16.jpeg', 16, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5564, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_17.jpeg', 17, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5565, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_18.jpeg', 18, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5566, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_19.jpeg', 19, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5567, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_20.jpeg', 20, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5569, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_22.jpeg', 22, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5570, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_23.jpeg', 23, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5571, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_24.jpeg', 24, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5572, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_25.jpeg', 25, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5573, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_26.jpeg', 26, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5574, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_27.jpeg', 27, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5575, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_28.jpeg', 28, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5576, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_29.jpeg', 29, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5577, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_30.jpeg', 30, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5578, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_31.jpeg', 31, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5579, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_32.jpeg', 32, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5580, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_33.jpeg', 33, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5581, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_34.jpeg', 34, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5582, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_35.jpeg', 35, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5583, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_36.jpeg', 36, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5584, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_37.jpeg', 37, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5585, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_38.jpeg', 38, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5586, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_39.jpeg', 39, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5587, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_40.jpeg', 40, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5588, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_41.jpeg', 41, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5589, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_42.jpeg', 42, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5590, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_43.jpeg', 43, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5591, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_44.jpeg', 44, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5592, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_45.jpeg', 45, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5593, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_46.jpeg', 46, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5594, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_47.jpeg', 47, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5595, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_48.jpeg', 48, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5596, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_49.jpeg', 49, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (5597, 103, N'images/admins/stories/Nguyên Lai Ta Là Tu Tiên Đại Lão(ST4)/Chương 1(ST4_C1)/Page_50.jpeg', 50, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6598, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_1.jpeg', 1, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6599, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_2.jpeg', 2, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6600, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_3.jpeg', 3, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6601, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_4.jpeg', 4, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6602, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_5.jpeg', 5, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6603, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_6.jpeg', 6, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6604, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_7.jpeg', 7, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6605, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_8.jpeg', 8, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6606, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_9.jpeg', 9, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6607, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_10.jpeg', 10, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6608, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_11.jpeg', 11, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6609, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_12.jpeg', 12, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6610, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_13.jpeg', 13, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6611, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_14.jpeg', 14, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6612, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_15.jpeg', 15, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6613, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_16.jpeg', 16, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6614, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_17.jpeg', 17, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6615, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_18.jpeg', 18, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6616, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_19.jpeg', 19, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6617, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_20.jpeg', 20, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6618, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_21.jpeg', 21, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6619, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_22.jpeg', 22, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6620, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_23.jpeg', 23, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6621, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_24.jpeg', 24, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6622, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_25.jpeg', 25, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6623, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_26.jpeg', 26, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6624, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_27.jpeg', 27, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6625, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_28.jpeg', 28, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6626, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_29.jpeg', 29, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6627, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_30.jpeg', 30, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6628, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_31.jpeg', 31, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6629, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_32.jpeg', 32, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6630, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_33.jpeg', 33, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6631, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_34.jpeg', 34, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6632, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_35.jpeg', 35, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6633, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_36.jpeg', 36, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6634, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_37.jpeg', 37, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6635, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_38.jpeg', 38, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6636, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_39.jpeg', 39, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6637, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_40.jpeg', 40, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6638, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_41.jpeg', 41, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6639, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_42.jpeg', 42, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6640, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_43.jpeg', 43, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6641, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_44.jpeg', 44, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6642, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_45.jpeg', 45, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6643, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_46.jpeg', 46, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6644, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_47.jpeg', 47, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6645, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_48.jpeg', 48, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6646, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_49.jpeg', 49, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6647, 118, N'images/admins/stories/Chưởng Môn Khiêm Tốn Chút(ST2)/Chương 3(ST2_C3)/Page_50.jpeg', 50, NULL, NULL, NULL)
GO
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6648, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_1.jpeg', 1, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6649, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_2.jpeg', 2, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6650, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_3.jpeg', 3, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6651, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_4.jpeg', 4, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6652, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_5.jpeg', 5, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6653, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_6.jpeg', 6, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6654, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_7.jpeg', 7, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6655, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_8.jpeg', 8, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6656, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_9.jpeg', 9, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6657, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_10.jpeg', 10, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6658, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_11.jpeg', 11, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6659, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_12.jpeg', 12, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6660, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_13.jpeg', 13, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6661, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_14.jpeg', 14, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6662, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_15.jpeg', 15, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6663, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_16.jpeg', 16, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6664, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_17.jpeg', 17, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6665, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_18.jpeg', 18, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6666, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_19.jpeg', 19, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6667, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_20.jpeg', 20, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6668, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_21.jpeg', 21, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6669, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_22.jpeg', 22, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6670, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_23.jpeg', 23, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6671, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_24.jpeg', 24, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6672, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_25.jpeg', 25, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6673, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_26.jpeg', 26, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6674, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_27.jpeg', 27, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6675, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_28.jpeg', 28, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6676, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_29.jpeg', 29, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6677, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_30.jpeg', 30, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6678, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_31.jpeg', 31, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6679, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_32.jpeg', 32, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6680, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_33.jpeg', 33, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6681, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_34.jpeg', 34, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6682, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_35.jpeg', 35, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6683, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_36.jpeg', 36, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6684, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_37.jpeg', 37, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6685, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_38.jpeg', 38, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6686, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_39.jpeg', 39, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6687, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_40.jpeg', 40, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6688, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_41.jpeg', 41, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6689, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_42.jpeg', 42, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6690, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_43.jpeg', 43, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6691, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_44.jpeg', 44, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6692, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_45.jpeg', 45, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6693, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_46.jpeg', 46, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6694, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_47.jpeg', 47, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6695, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_48.jpeg', 48, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6696, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_49.jpeg', 49, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6697, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_50.jpeg', 50, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6698, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_51.jpeg', 51, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6699, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_52.jpeg', 52, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6700, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_53.jpeg', 53, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6701, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_54.jpeg', 54, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6702, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_55.jpeg', 55, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6703, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_56.jpeg', 56, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6704, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_57.jpeg', 57, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6705, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_58.jpeg', 58, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6706, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_59.jpeg', 59, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6707, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_60.jpeg', 60, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6708, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_61.jpeg', 61, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6709, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_62.jpeg', 62, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6710, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_63.jpeg', 63, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6711, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_64.jpeg', 64, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6712, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_65.jpeg', 65, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6713, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_66.jpeg', 66, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6714, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_67.jpeg', 67, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6715, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_68.jpeg', 68, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6716, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_69.jpeg', 69, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6717, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_70.jpeg', 70, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6718, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_71.jpeg', 71, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6719, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_72.jpeg', 72, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6720, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_73.jpeg', 73, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6721, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_74.jpeg', 74, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6722, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_75.jpeg', 75, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6723, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_76.jpeg', 76, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6724, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_77.jpeg', 77, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6725, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_78.jpeg', 78, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6726, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_79.jpeg', 79, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6727, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_80.jpeg', 80, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6728, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_81.jpeg', 81, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6729, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_82.jpeg', 82, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6730, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_83.jpeg', 83, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6731, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_84.jpeg', 84, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6732, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_85.jpeg', 85, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6733, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_86.jpeg', 86, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6734, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_87.jpeg', 87, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6735, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_88.jpeg', 88, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6736, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_89.jpeg', 89, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6737, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_90.jpeg', 90, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6738, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_91.jpeg', 91, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6739, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_92.jpeg', 92, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6740, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_93.jpeg', 93, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6741, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_94.jpeg', 94, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6742, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_95.jpeg', 95, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6743, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_96.jpeg', 96, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6744, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_97.jpeg', 97, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6745, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_98.jpeg', 98, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6746, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_99.jpeg', 99, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6747, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_100.jpeg', 100, NULL, NULL, NULL)
GO
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6748, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_101.jpeg', 101, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6749, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_102.jpeg', 102, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6750, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_103.jpeg', 103, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6751, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_104.jpeg', 104, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6752, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_105.jpeg', 105, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6753, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_106.jpeg', 106, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6754, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_107.jpeg', 107, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6755, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_108.jpeg', 108, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6756, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_109.jpeg', 109, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6757, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_110.jpeg', 110, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6758, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_111.jpeg', 111, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6759, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_112.jpeg', 112, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6760, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_113.jpeg', 113, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6761, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_114.jpeg', 114, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6762, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_115.jpeg', 115, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6763, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_116.jpeg', 116, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6764, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_117.jpeg', 117, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6765, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_118.jpeg', 118, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6766, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_119.jpeg', 119, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6767, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_120.jpeg', 120, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6768, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_121.jpeg', 121, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6769, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_122.jpeg', 122, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6770, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_123.jpeg', 123, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6771, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_124.jpeg', 124, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6772, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_125.jpeg', 125, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6773, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_126.jpeg', 126, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6774, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_127.jpeg', 127, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6775, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_128.jpeg', 128, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6776, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_129.jpeg', 129, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6777, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_130.jpeg', 130, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6778, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_131.jpeg', 131, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6779, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_132.jpeg', 132, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6780, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_133.jpeg', 133, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6781, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_134.jpeg', 134, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6782, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_135.jpeg', 135, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6783, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_136.jpeg', 136, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6784, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_137.jpeg', 137, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6785, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_138.jpeg', 138, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6786, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_139.jpeg', 139, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6787, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_140.jpeg', 140, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6788, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_141.jpeg', 141, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6789, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_142.jpeg', 142, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6790, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_143.jpeg', 143, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6791, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_144.jpeg', 144, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6792, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_145.jpeg', 145, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6793, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_146.jpeg', 146, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6794, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_147.jpeg', 147, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6795, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_148.jpeg', 148, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6796, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_149.jpeg', 149, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6797, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_150.jpeg', 150, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6798, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_151.jpeg', 151, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6799, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_152.jpeg', 152, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6800, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_153.jpeg', 153, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6801, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_154.jpeg', 154, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6802, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_155.jpeg', 155, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6803, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_156.jpeg', 156, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6804, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_157.jpeg', 157, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6805, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_158.jpeg', 158, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6806, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_159.jpeg', 159, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6807, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_160.jpeg', 160, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6808, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_161.jpeg', 161, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6809, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_162.jpeg', 162, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6810, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_163.jpeg', 163, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6811, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_164.jpeg', 164, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6812, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_165.jpeg', 165, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6813, 119, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 1(ST1_C1)/Page_166.jpeg', 166, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6814, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_1.jpeg', 1, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6815, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_2.jpeg', 2, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6816, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_3.jpeg', 3, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6817, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_4.jpeg', 4, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6818, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_5.jpeg', 5, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6819, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_6.jpeg', 6, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6820, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_7.jpeg', 7, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6821, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_8.jpeg', 8, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6822, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_9.jpeg', 9, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6823, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_10.jpeg', 10, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6824, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_11.jpeg', 11, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6825, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_12.jpeg', 12, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6826, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_13.jpeg', 13, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6827, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_14.jpeg', 14, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6828, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_15.jpeg', 15, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6829, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_16.jpeg', 16, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6830, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_17.jpeg', 17, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6831, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_18.jpeg', 18, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6832, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_19.jpeg', 19, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6833, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_20.jpeg', 20, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6834, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_21.jpeg', 21, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6835, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_22.jpeg', 22, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6836, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_23.jpeg', 23, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6837, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_24.jpeg', 24, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6838, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_25.jpeg', 25, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6839, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_26.jpeg', 26, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6840, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_27.jpeg', 27, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6841, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_28.jpeg', 28, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6842, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_29.jpeg', 29, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6843, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_30.jpeg', 30, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6844, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_31.jpeg', 31, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6845, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_32.jpeg', 32, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6846, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_33.jpeg', 33, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6847, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_34.jpeg', 34, NULL, NULL, NULL)
GO
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6848, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_35.jpeg', 35, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6849, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_36.jpeg', 36, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6850, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_37.jpeg', 37, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6851, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_38.jpeg', 38, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6852, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_39.jpeg', 39, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6853, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_40.jpeg', 40, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6854, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_41.jpeg', 41, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6855, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_42.jpeg', 42, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6856, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_43.jpeg', 43, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6857, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_44.jpeg', 44, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6858, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_45.jpeg', 45, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6859, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_46.jpeg', 46, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6860, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_47.jpeg', 47, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6861, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_48.jpeg', 48, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6862, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_49.jpeg', 49, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6863, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_50.jpeg', 50, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6864, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_51.jpeg', 51, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6865, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_52.jpeg', 52, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6866, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_53.jpeg', 53, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6867, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_54.jpeg', 54, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6868, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_55.jpeg', 55, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6869, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_56.jpeg', 56, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6870, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_57.jpeg', 57, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6871, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_58.jpeg', 58, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6872, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_59.jpeg', 59, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6873, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_60.jpeg', 60, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6874, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_61.jpeg', 61, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6875, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_62.jpeg', 62, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6876, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_63.jpeg', 63, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6877, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_64.jpeg', 64, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6878, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_65.jpeg', 65, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6879, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_66.jpeg', 66, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6880, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_67.jpeg', 67, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6881, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_68.jpeg', 68, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6882, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_69.jpeg', 69, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6883, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_70.jpeg', 70, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6884, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_71.jpeg', 71, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6885, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_72.jpeg', 72, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6886, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_73.jpeg', 73, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6887, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_74.jpeg', 74, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6888, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_75.jpeg', 75, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6889, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_76.jpeg', 76, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6890, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_77.jpeg', 77, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6891, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_78.jpeg', 78, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6892, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_79.jpeg', 79, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6893, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_80.jpeg', 80, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6894, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_81.jpeg', 81, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6895, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_82.jpeg', 82, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6896, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_83.jpeg', 83, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6897, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_84.jpeg', 84, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6898, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_85.jpeg', 85, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6899, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_86.jpeg', 86, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6900, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_87.jpeg', 87, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6901, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_88.jpeg', 88, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6902, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_89.jpeg', 89, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6903, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_90.jpeg', 90, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6904, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_91.jpeg', 91, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6905, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_92.jpeg', 92, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6906, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_93.jpeg', 93, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6907, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_94.jpeg', 94, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6908, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_95.jpeg', 95, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6909, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_96.jpeg', 96, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6910, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_97.jpeg', 97, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6911, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_98.jpeg', 98, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6912, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_99.jpeg', 99, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6913, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_100.jpeg', 100, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6914, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_101.jpeg', 101, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6915, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_102.jpeg', 102, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6916, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_103.jpeg', 103, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6917, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_104.jpeg', 104, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6918, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_105.jpeg', 105, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6919, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_106.jpeg', 106, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6920, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_107.jpeg', 107, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6921, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_108.jpeg', 108, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6922, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_109.jpeg', 109, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6923, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_110.jpeg', 110, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6924, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_111.jpeg', 111, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6925, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_112.jpeg', 112, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6926, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_113.jpeg', 113, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6927, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_114.jpeg', 114, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6928, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_115.jpeg', 115, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6929, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_116.jpeg', 116, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6930, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_117.jpeg', 117, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6931, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_118.jpeg', 118, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6932, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_119.jpeg', 119, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6933, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_120.jpeg', 120, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6934, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_121.jpeg', 121, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6935, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_122.jpeg', 122, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6936, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_123.jpeg', 123, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6937, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_124.jpeg', 124, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6938, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_125.jpeg', 125, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6939, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_126.jpeg', 126, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6940, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_127.jpeg', 127, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6941, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_128.jpeg', 128, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6942, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_129.jpeg', 129, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6943, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_130.jpeg', 130, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6944, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_131.jpeg', 131, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6945, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_132.jpeg', 132, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6946, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_133.jpeg', 133, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6947, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_134.jpeg', 134, NULL, NULL, NULL)
GO
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6948, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_135.jpeg', 135, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6949, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_136.jpeg', 136, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6950, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_137.jpeg', 137, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6951, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_138.jpeg', 138, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6952, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_139.jpeg', 139, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6953, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_140.jpeg', 140, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6954, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_141.jpeg', 141, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6955, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_142.jpeg', 142, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6956, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_143.jpeg', 143, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6957, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_144.jpeg', 144, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6958, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_145.jpeg', 145, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6959, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_146.jpeg', 146, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6960, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_147.jpeg', 147, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6961, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_148.jpeg', 148, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6962, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_149.jpeg', 149, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6963, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_150.jpeg', 150, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6964, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_151.jpeg', 151, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6965, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_152.jpeg', 152, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6966, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_153.jpeg', 153, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6967, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_154.jpeg', 154, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6968, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_155.jpeg', 155, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6969, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_156.jpeg', 156, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6970, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_157.jpeg', 157, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6971, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_158.jpeg', 158, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6972, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_159.jpeg', 159, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6973, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_160.jpeg', 160, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6974, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_161.jpeg', 161, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6975, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_162.jpeg', 162, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6976, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_163.jpeg', 163, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6977, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_164.jpeg', 164, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6978, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_165.jpeg', 165, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6979, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_166.jpeg', 166, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6980, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_167.jpeg', 167, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6981, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_168.jpeg', 168, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6982, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_169.jpeg', 169, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6983, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_170.jpeg', 170, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6984, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_171.jpeg', 171, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6985, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_172.jpeg', 172, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6986, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_173.jpeg', 173, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6987, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_174.jpeg', 174, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6988, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_175.jpeg', 175, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6989, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_176.jpeg', 176, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6990, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_177.jpeg', 177, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6991, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_178.jpeg', 178, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6992, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_179.jpeg', 179, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6993, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_180.jpeg', 180, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6994, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_181.jpeg', 181, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6995, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_182.jpeg', 182, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6996, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_183.jpeg', 183, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6997, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_184.jpeg', 184, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6998, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_185.jpeg', 185, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (6999, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_186.jpeg', 186, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7000, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_187.jpeg', 187, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7001, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_188.jpeg', 188, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7002, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_189.jpeg', 189, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7003, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_190.jpeg', 190, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7004, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_191.jpeg', 191, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7005, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_192.jpeg', 192, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7006, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_193.jpeg', 193, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7007, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_194.jpeg', 194, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7008, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_195.jpeg', 195, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7009, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_196.jpeg', 196, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7010, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_197.jpeg', 197, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7011, 120, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 2(ST1_C2)/Page_198.jpeg', 198, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7012, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_1.jpeg', 1, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7013, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_2.jpeg', 2, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7014, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_3.jpeg', 3, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7015, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_4.jpeg', 4, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7016, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_5.jpeg', 5, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7017, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_6.jpeg', 6, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7018, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_7.jpeg', 7, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7019, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_8.jpeg', 8, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7020, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_9.jpeg', 9, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7021, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_10.jpeg', 10, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7022, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_11.jpeg', 11, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7023, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_12.jpeg', 12, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7024, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_13.jpeg', 13, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7025, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_14.jpeg', 14, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7026, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_15.jpeg', 15, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7027, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_16.jpeg', 16, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7028, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_17.jpeg', 17, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7029, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_18.jpeg', 18, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7030, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_19.jpeg', 19, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7031, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_20.jpeg', 20, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7032, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_21.jpeg', 21, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7033, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_22.jpeg', 22, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7034, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_23.jpeg', 23, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7035, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_24.jpeg', 24, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7036, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_25.jpeg', 25, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7037, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_26.jpeg', 26, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7038, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_27.jpeg', 27, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7039, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_28.jpeg', 28, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7040, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_29.jpeg', 29, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7041, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_30.jpeg', 30, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7042, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_31.jpeg', 31, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7043, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_32.jpeg', 32, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7044, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_33.jpeg', 33, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7045, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_34.jpeg', 34, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7046, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_35.jpeg', 35, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7047, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_36.jpeg', 36, NULL, NULL, NULL)
GO
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7048, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_37.jpeg', 37, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7049, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_38.jpeg', 38, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7050, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_39.jpeg', 39, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7051, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_40.jpeg', 40, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7052, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_41.jpeg', 41, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7053, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_42.jpeg', 42, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7054, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_43.jpeg', 43, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7055, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_44.jpeg', 44, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7056, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_45.jpeg', 45, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7057, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_46.jpeg', 46, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7058, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_47.jpeg', 47, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7059, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_48.jpeg', 48, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7060, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_49.jpeg', 49, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7061, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_50.jpeg', 50, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7062, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_51.jpeg', 51, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7063, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_52.jpeg', 52, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7064, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_53.jpeg', 53, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7065, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_54.jpeg', 54, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7066, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_55.jpeg', 55, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7067, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_56.jpeg', 56, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7068, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_57.jpeg', 57, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7069, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_58.jpeg', 58, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7070, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_59.jpeg', 59, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7071, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_60.jpeg', 60, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7072, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_61.jpeg', 61, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7073, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_62.jpeg', 62, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7074, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_63.jpeg', 63, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7075, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_64.jpeg', 64, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7076, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_65.jpeg', 65, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7077, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_66.jpeg', 66, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7078, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_67.jpeg', 67, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7079, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_68.jpeg', 68, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7080, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_69.jpeg', 69, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7081, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_70.jpeg', 70, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7082, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_71.jpeg', 71, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7083, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_72.jpeg', 72, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7084, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_73.jpeg', 73, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7085, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_74.jpeg', 74, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7086, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_75.jpeg', 75, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7087, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_76.jpeg', 76, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7088, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_77.jpeg', 77, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7089, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_78.jpeg', 78, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7090, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_79.jpeg', 79, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7091, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_80.jpeg', 80, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7092, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_81.jpeg', 81, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7093, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_82.jpeg', 82, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7094, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_83.jpeg', 83, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7095, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_84.jpeg', 84, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7096, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_85.jpeg', 85, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7097, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_86.jpeg', 86, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7098, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_87.jpeg', 87, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7099, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_88.jpeg', 88, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7100, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_89.jpeg', 89, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7101, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_90.jpeg', 90, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7102, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_91.jpeg', 91, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7103, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_92.jpeg', 92, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7104, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_93.jpeg', 93, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7105, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_94.jpeg', 94, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7106, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_95.jpeg', 95, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7107, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_96.jpeg', 96, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7108, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_97.jpeg', 97, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7109, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_98.jpeg', 98, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7110, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_99.jpeg', 99, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7111, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_100.jpeg', 100, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7112, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_101.jpeg', 101, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7113, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_102.jpeg', 102, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7114, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_103.jpeg', 103, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7115, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_104.jpeg', 104, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7116, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_105.jpeg', 105, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7117, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_106.jpeg', 106, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7118, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_107.jpeg', 107, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7119, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_108.jpeg', 108, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7120, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_109.jpeg', 109, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7121, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_110.jpeg', 110, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7122, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_111.jpeg', 111, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7123, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_112.jpeg', 112, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7124, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_113.jpeg', 113, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7125, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_114.jpeg', 114, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7126, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_115.jpeg', 115, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7127, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_116.jpeg', 116, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7128, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_117.jpeg', 117, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7129, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_118.jpeg', 118, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7130, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_119.jpeg', 119, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7131, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_120.jpeg', 120, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7132, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_121.jpeg', 121, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7133, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_122.jpeg', 122, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7134, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_123.jpeg', 123, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7135, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_124.jpeg', 124, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7136, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_125.jpeg', 125, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7137, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_126.jpeg', 126, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7138, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_127.jpeg', 127, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7139, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_128.jpeg', 128, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7140, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_129.jpeg', 129, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7141, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_130.jpeg', 130, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7142, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_131.jpeg', 131, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7143, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_132.jpeg', 132, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7144, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_133.jpeg', 133, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7145, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_134.jpeg', 134, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7146, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_135.jpeg', 135, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7147, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_136.jpeg', 136, NULL, NULL, NULL)
GO
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7148, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_137.jpeg', 137, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7149, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_138.jpeg', 138, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7150, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_139.jpeg', 139, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7151, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_140.jpeg', 140, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7152, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_141.jpeg', 141, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7153, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_142.jpeg', 142, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7154, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_143.jpeg', 143, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7155, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_144.jpeg', 144, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7156, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_145.jpeg', 145, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7157, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_146.jpeg', 146, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7158, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_147.jpeg', 147, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7159, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_148.jpeg', 148, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7160, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_149.jpeg', 149, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7161, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_150.jpeg', 150, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7162, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_151.jpeg', 151, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7163, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_152.jpeg', 152, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7164, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_153.jpeg', 153, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7165, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_154.jpeg', 154, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7166, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_155.jpeg', 155, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7167, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_156.jpeg', 156, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7168, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_157.jpeg', 157, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7169, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_158.jpeg', 158, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7170, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_159.jpeg', 159, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7171, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_160.jpeg', 160, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7172, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_161.jpeg', 161, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7173, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_162.jpeg', 162, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7174, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_163.jpeg', 163, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7175, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_164.jpeg', 164, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7176, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_165.jpeg', 165, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7177, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_166.jpeg', 166, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7178, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_167.jpeg', 167, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7179, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_168.jpeg', 168, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7180, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_169.jpeg', 169, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7181, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_170.jpeg', 170, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7182, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_171.jpeg', 171, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7183, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_172.jpeg', 172, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7184, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_173.jpeg', 173, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7185, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_174.jpeg', 174, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7186, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_175.jpeg', 175, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7187, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_176.jpeg', 176, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7188, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_177.jpeg', 177, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7189, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_178.jpeg', 178, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7190, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_179.jpeg', 179, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7191, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_180.jpeg', 180, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7192, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_181.jpeg', 181, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7193, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_182.jpeg', 182, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7194, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_183.jpeg', 183, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7195, 121, N'images/admins/stories/Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100(ST1)/Chương 3(ST1_C3)/Page_184.jpeg', 184, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7196, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_1.jpeg', 1, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7197, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_2.jpeg', 2, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7198, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_3.jpeg', 3, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7199, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_4.jpeg', 4, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7200, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_5.jpeg', 5, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7201, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_6.jpeg', 6, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7202, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_7.jpeg', 7, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7203, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_8.jpeg', 8, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7204, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_9.jpeg', 9, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7205, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_10.jpeg', 10, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7206, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_11.jpeg', 11, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7207, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_12.jpeg', 12, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7208, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_13.jpeg', 13, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7209, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_14.jpeg', 14, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7210, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_15.jpeg', 15, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7211, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_16.jpeg', 16, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7212, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_17.jpeg', 17, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7213, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_18.jpeg', 18, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7214, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_19.jpeg', 19, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7215, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_20.jpeg', 20, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7216, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_21.jpeg', 21, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7217, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_22.jpeg', 22, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7218, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_23.jpeg', 23, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7219, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_24.jpeg', 24, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7220, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_25.jpeg', 25, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7221, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_26.jpeg', 26, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7222, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_27.jpeg', 27, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7223, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_28.jpeg', 28, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7224, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_29.jpeg', 29, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7225, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_30.jpeg', 30, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7226, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_31.jpeg', 31, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7227, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_32.jpeg', 32, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7228, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_33.jpeg', 33, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7229, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_34.jpeg', 34, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7230, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_35.jpeg', 35, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7231, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_36.jpeg', 36, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7232, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_37.jpeg', 37, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7233, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_38.jpeg', 38, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7234, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_39.jpeg', 39, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7235, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_40.jpeg', 40, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7236, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_41.jpeg', 41, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7237, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_42.jpeg', 42, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7238, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_43.jpeg', 43, NULL, NULL, NULL)
INSERT [dbo].[Chapter_images] ([ImageId], [ChapterId], [ImageUrl], [Page_number], [StoryId], [Create_at], [Update_at]) VALUES (7239, 1104, N'images/admins/stories/Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần(ST6)/Chương 1(ST6_C1)/Page_44.jpeg', 44, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Chapter_images] OFF
GO
SET IDENTITY_INSERT [dbo].[Chapters] ON 

INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (74, 12, N'Chương 1', CAST(N'2025-03-19T19:00:43.927' AS DateTime), 1, 200, 1, N'_C1', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (75, 12, N'Chương 2', CAST(N'2025-03-19T19:00:43.927' AS DateTime), 1, 200, 0, N'_C2', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (79, 3, N'Chương 2', CAST(N'2025-03-24T14:31:46.603' AS DateTime), 1, 100, 1, N'ST3_C2', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (80, 3, N'Chương 3', CAST(N'2025-03-24T14:31:46.603' AS DateTime), 1, 100, 1, N'ST3_C3', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (81, 3, N'Chương 4', CAST(N'2025-03-24T14:31:46.603' AS DateTime), 1, 0, 1, N'ST3_C4', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (82, 3, N'Chương 5', CAST(N'2025-03-24T14:31:46.603' AS DateTime), 1, 100, 1, N'ST3_C5', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (83, 3, N'Chương 6', CAST(N'2025-03-24T14:31:56.917' AS DateTime), 1, 100, 1, N'ST3_C6', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (100, 3, N'Chương 7', CAST(N'2025-04-08T17:09:57.107' AS DateTime), 0, 0, 1, N'ST3_C7', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (103, 14, N'Chương 1', CAST(N'2025-04-15T15:05:13.890' AS DateTime), 1, 100, 1, N'ST4_C1', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (105, 14, N'Chương 3', CAST(N'2025-04-15T15:05:13.890' AS DateTime), 1, 100, 0, N'ST4_C3', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (106, 14, N'Chương 4', CAST(N'2025-04-15T15:05:13.890' AS DateTime), 1, 100, 0, N'ST4_C4', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (107, 14, N'Chương 5', CAST(N'2025-04-15T15:05:13.890' AS DateTime), 1, 100, 0, N'ST4_C5', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (108, 14, N'Chương 2', CAST(N'2025-04-15T15:08:23.660' AS DateTime), 0, 0, 0, N'ST4_C2', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (109, 14, N'Chương 6', CAST(N'2025-04-15T15:08:23.660' AS DateTime), 0, 0, 0, N'ST4_C6', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (113, 13, N'Chương 1', CAST(N'2025-04-15T22:09:47.463' AS DateTime), 1, 100, 1, N'_C1', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (114, 13, N'Chương 2', CAST(N'2025-04-15T22:09:47.463' AS DateTime), 1, 100, 0, N'_C2', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (115, 13, N'Chương 3', CAST(N'2025-04-15T22:09:47.463' AS DateTime), 1, 100, 0, N'_C3', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (116, 2, N'Chương 1', CAST(N'2025-04-15T22:10:16.510' AS DateTime), 1, 100, 1, N'ST2_C1', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (117, 2, N'Chương 2', CAST(N'2025-04-15T22:10:16.510' AS DateTime), 1, 100, 0, N'ST2_C2', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (118, 2, N'Chương 3', CAST(N'2025-04-15T22:10:16.510' AS DateTime), 1, 100, 0, N'ST2_C3', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (119, 15, N'Chương 1', CAST(N'2025-04-15T22:10:30.463' AS DateTime), 1, 100, 1, N'ST1_C1', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (120, 15, N'Chương 2', CAST(N'2025-04-15T22:10:30.463' AS DateTime), 1, 100, 1, N'ST1_C2', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (121, 15, N'Chương 3', CAST(N'2025-04-15T22:10:30.463' AS DateTime), 1, 100, 0, N'ST1_C3', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (122, 6, N'Chương 1', CAST(N'2025-04-15T22:10:52.603' AS DateTime), 1, 100, 1, N'_C1', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (123, 6, N'Chương 2', CAST(N'2025-04-15T22:10:52.603' AS DateTime), 1, 100, 1, N'_C2', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (124, 6, N'Chương 3', CAST(N'2025-04-15T22:10:52.603' AS DateTime), 1, 100, 0, N'_C3', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (1103, 6, N'Chương 4', CAST(N'2025-04-22T16:56:15.673' AS DateTime), 0, 0, 1, N'_C4', NULL)
INSERT [dbo].[Chapters] ([Chapter_id], [Story_id], [Chapter_title], [Created_at], [IsLocked], [Coins], [IsUnlocked], [ChapterCode], [Update_at]) VALUES (1104, 17, N'Chương 1', CAST(N'2025-05-16T14:24:57.960' AS DateTime), 1, 100, 0, N'ST6_C1', NULL)
SET IDENTITY_INSERT [dbo].[Chapters] OFF
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (176, 5, 2, N'Gửi cho các bạn sắp đọc truyện này:
- lúc đầu thì tưởng nó là siêu phẩm nhưng không. Truyện xây dựng nhân vật chậm và cái cần thì ko làm còn cái ko cần cứ kéo lê thê ko chịu skip. Cứ làm ra main quý cái sơn trại ai đụng tới là trụng . Biết là vậy rồi thì chuyển biến gì khác 1 cái chứ gì mà làm xong vậy rồi cái lại làm tiếp nữa. Cứ lê thê lan man. Cảnh giới thì ko rõ cứ đụng ai có vài chiêu đó là cứ trụng ... thôi ai rãnh xem tầm 50 chap sẽ hiểuemo', CAST(N'2025-03-04T15:58:17.970' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (177, 6, 3, N'Huynh đệ nào đi qua có thể cho tại hạ xin review của bộ này đc ko. Tại hạ đọc 20 chap đầu r thấy main lên núi làm sơn tặc xong diễn biến tiếp như nào để tại hạ lấy động lực đọc', CAST(N'2025-03-04T16:06:33.310' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (178, 5, 3, N'@Lylah Cứ đọc đi tìm app mà đọc 
Bên này trộm lâu lắm 
Cũng hơn 100 chap r', CAST(N'2025-03-04T16:08:18.123' AS DateTime), 177, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (179, 6, 3, N'@Aday Đa tạ sư huynh đã chỉ giáo', CAST(N'2025-03-04T16:09:04.357' AS DateTime), 177, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (180, 7, 3, N'Hay không các đạo hữu', CAST(N'2025-03-04T16:25:33.373' AS DateTime), NULL, 2, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (181, 7, 13, N'Mặc dù truyện khởi đầu hay nhưng diễn biến sau này khá dễ đoán, tác giả throw một đống thứ không liên quan vào phần sau của truyện và end harem khá dễ đoán. Nói chung cũng ổn ko quá chán 7.5/10. Nếu manhwa có thầu hết bộ này và chau chuốt nội dung một tí thì sẽ ok hơn', CAST(N'2025-03-04T16:26:37.870' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (182, 7, 12, N'Theo dõi bộ này mấy năm rồi, từ khi đi học đến đi làm vẫn còn=)), trên ytb ra tới chương 800 mấy ấy nghe bảo end ss1 rồi, nchung cốt truyện liên kết, cấu trúc xây dựng nhân vật đều trên trung bình ổn hơn nhiều bộ hiện nay, nữ chính có não luôn biết chừa đường lui cho mình, nhiều cảm xúc lắm mà khuyên mọi ng nên đọc nha', CAST(N'2025-03-04T16:27:18.610' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (183, 7, 6, N'Nói sao nhỉ, đọc không hay bằng bản novel. Cut nhiều quá nên thành ra làm một đống sạn. Tác giả build quá trời nhân vật, giải thích từng album, cách build tâm lý main,... Rồi lên rruyeenj tranh bị cắt hết', CAST(N'2025-03-04T16:27:49.807' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (184, 7, 6, N'có bộ nào cx thiên về âm nhạc giống vầy hong mn? mình đọc bộ thiên tài âm nhạc rồi, ko bít còn bộ nào cx về âm nhạc như này ko', CAST(N'2025-03-04T16:28:11.857' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (186, 8, 2, N'@Aday ui bác e cũng đang định đọc', CAST(N'2025-03-04T16:30:09.703' AS DateTime), 176, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (187, 8, 13, N'@Xuin Art đẹp k ạ', CAST(N'2025-03-04T16:32:34.410' AS DateTime), 181, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (190, 8, 6, N'@Xuin Có link novel k ạ', CAST(N'2025-03-04T16:34:15.713' AS DateTime), 183, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (213, 5, 12, N'Đọc giải trí thì được', CAST(N'2025-03-05T14:57:54.150' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (216, 5, 3, N'@Xuin đọc cx á', CAST(N'2025-03-05T14:58:55.213' AS DateTime), 180, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (217, 5, 6, N'Truyện cx được ', CAST(N'2025-03-05T14:59:22.663' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (219, 6, 14, N'truyện hay không các đạo hữu', CAST(N'2025-03-06T14:27:04.220' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (220, 6, 14, N'à đọc rồi hay nha mn', CAST(N'2025-03-06T14:27:26.437' AS DateTime), 219, 1, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (221, 20, 14, N'Truyện kịch Raw chưa
', CAST(N'2025-03-10T17:35:44.817' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (224, 19, 14, N'@Lybys chưa bro', CAST(N'2025-03-10T17:41:06.353' AS DateTime), 221, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (225, 19, 2, N'hello', CAST(N'2025-03-10T18:01:11.343' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (226, 20, 2, N'@Lybys112 tan nát con tim', CAST(N'2025-03-10T18:01:34.933' AS DateTime), 225, 2, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (227, 20, 14, N'@Lybys112 bb', CAST(N'2025-03-11T15:01:13.903' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (228, 19, 14, N'@Lybys gg', CAST(N'2025-03-20T10:43:13.527' AS DateTime), 227, 3, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (238, 6, 14, N'ggg', CAST(N'2025-04-15T15:09:17.180' AS DateTime), NULL, 4, 103)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (1238, 6, 6, N'Hello', CAST(N'2025-04-25T15:33:45.453' AS DateTime), NULL, 2, 122)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (1239, 6, 6, N'Hello
', CAST(N'2025-04-25T15:38:42.780' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Comments] ([CommentId], [UserId], [StoryId], [content], [Created_at], [ParentCommentId], [StickerId], [chapterId]) VALUES (1240, 19, 6, N'@Lylah ok', CAST(N'2025-04-25T15:38:54.340' AS DateTime), 1239, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[ExpHistory] ON 

INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (1, 1, 91, N'Rung cây lì xì Tết', CAST(N'2025-02-28T14:23:49.010' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (2, 1, 90, N'Rung cây lì xì Tết', CAST(N'2025-02-28T14:23:53.493' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (3, 1, 28, N'Rung cây lì xì Tết', CAST(N'2025-02-28T14:23:53.610' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (4, 2, 77, N'Rung cây lì xì Tết', CAST(N'2025-02-28T14:25:42.603' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (5, 2, 80, N'Rung cây lì xì Tết', CAST(N'2025-02-28T14:25:43.550' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (6, 2, 24, N'Rung cây lì xì Tết', CAST(N'2025-02-28T14:25:44.297' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (7, 1, 30, N'Hoàn thành nhiệm vụ: Bình lu?n 1 l?n', CAST(N'2025-02-28T17:08:39.057' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (8, 1, 20, N'Hoàn thành nhiệm vụ: Theo dõi 1 truy?n', CAST(N'2025-02-28T17:08:48.733' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (9, 1, 50, N'Hoàn thành nhiệm vụ: Ð?c 1 chuong truy?n', CAST(N'2025-02-28T17:08:49.573' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (10, 1, 53, N'Rung cây lì xì Tết', CAST(N'2025-02-28T17:08:50.670' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (11, 1, 75, N'Rung cây lì xì Tết', CAST(N'2025-02-28T17:08:51.143' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (12, 1, 34, N'Rung cây lì xì Tết', CAST(N'2025-02-28T17:08:51.683' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (13, 2, 50, N'Hoàn thành nhiệm vụ: Ð?c 1 chuong truy?n', CAST(N'2025-02-28T17:16:20.280' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (14, 2, 86, N'Rung cây lì xì Tết', CAST(N'2025-02-28T17:17:07.380' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (15, 4, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-02-28T18:11:03.367' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (16, 4, 31, N'Rung cây lì xì Tết', CAST(N'2025-02-28T18:14:54.387' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (17, 4, 78, N'Rung cây lì xì Tết', CAST(N'2025-02-28T18:15:02.283' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (18, 4, 92, N'Rung cây lì xì Tết', CAST(N'2025-02-28T18:15:25.013' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (19, 4, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-01T19:30:17.313' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (20, 4, 55, N'Rung cây lì xì Tết', CAST(N'2025-03-01T19:30:20.567' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (21, 4, 33, N'Rung cây lì xì Tết', CAST(N'2025-03-01T19:30:21.563' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (22, 4, 59, N'Rung cây lì xì Tết', CAST(N'2025-03-01T19:30:22.287' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (23, 1, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-02T17:13:38.003' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (24, 1, 21, N'Rung cây lì xì Tết', CAST(N'2025-03-02T17:13:39.650' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (25, 1, 99, N'Rung cây lì xì Tết', CAST(N'2025-03-02T17:13:40.403' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (26, 1, 48, N'Rung cây lì xì Tết', CAST(N'2025-03-02T17:13:41.080' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (27, 1, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-03T10:54:22.170' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (28, 1, 81, N'Rung cây lì xì Tết', CAST(N'2025-03-03T10:54:23.020' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (29, 1, 89, N'Rung cây lì xì Tết', CAST(N'2025-03-03T10:54:23.160' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (30, 1, 72, N'Rung cây lì xì Tết', CAST(N'2025-03-03T10:54:23.320' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (31, 5, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-03T15:00:23.740' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (32, 5, 44, N'Rung cây lì xì Tết', CAST(N'2025-03-03T15:00:24.660' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (33, 5, 70, N'Rung cây lì xì Tết', CAST(N'2025-03-03T15:00:25.087' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (34, 5, 54, N'Rung cây lì xì Tết', CAST(N'2025-03-03T15:00:25.387' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (35, 5, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-04T15:40:34.983' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (36, 5, 34, N'Rung cây lì xì Tết', CAST(N'2025-03-04T15:40:37.537' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (37, 5, 51, N'Rung cây lì xì Tết', CAST(N'2025-03-04T15:40:37.737' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (38, 5, 59, N'Rung cây lì xì Tết', CAST(N'2025-03-04T15:40:37.903' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (39, 6, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-04T19:19:50.443' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (40, 6, 38, N'Rung cây lì xì Tết', CAST(N'2025-03-04T19:19:51.047' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (41, 6, 69, N'Rung cây lì xì Tết', CAST(N'2025-03-04T19:19:51.180' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (42, 6, 66, N'Rung cây lì xì Tết', CAST(N'2025-03-04T19:19:51.327' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (43, 6, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-05T17:07:34.080' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (44, 6, 97, N'Rung cây lì xì Tết', CAST(N'2025-03-05T17:07:35.043' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (45, 6, 44, N'Rung cây lì xì Tết', CAST(N'2025-03-05T17:07:35.193' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (46, 6, 99, N'Rung cây lì xì Tết', CAST(N'2025-03-05T17:07:35.350' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (47, 6, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-06T14:40:50.627' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (48, 6, 69, N'Rung cây lì xì Tết', CAST(N'2025-03-06T14:40:51.450' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (49, 6, 92, N'Rung cây lì xì Tết', CAST(N'2025-03-06T14:40:51.587' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (50, 6, 89, N'Rung cây lì xì Tết', CAST(N'2025-03-06T14:40:51.740' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (51, 19, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-07T13:55:37.970' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (52, 19, 47, N'Rung cây lì xì Tết', CAST(N'2025-03-07T13:55:38.847' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (53, 19, 63, N'Rung cây lì xì Tết', CAST(N'2025-03-07T13:55:39.033' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (54, 19, 47, N'Rung cây lì xì Tết', CAST(N'2025-03-07T13:55:39.223' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (55, 20, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-07T17:50:31.440' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (56, 20, 22, N'Rung cây lì xì Tết', CAST(N'2025-03-07T17:50:32.123' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (57, 20, 95, N'Rung cây lì xì Tết', CAST(N'2025-03-07T17:50:32.910' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (58, 20, 36, N'Rung cây lì xì Tết', CAST(N'2025-03-07T17:50:33.537' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (59, 20, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-10T16:43:46.593' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (60, 20, 70, N'Rung cây lì xì Tết', CAST(N'2025-03-10T16:43:47.563' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (61, 20, 61, N'Rung cây lì xì Tết', CAST(N'2025-03-10T16:43:47.727' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (62, 20, 36, N'Rung cây lì xì Tết', CAST(N'2025-03-10T16:43:47.883' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (63, 20, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-11T14:57:01.360' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (64, 20, 66, N'Rung cây lì xì Tết', CAST(N'2025-03-11T14:57:02.033' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (65, 20, 43, N'Rung cây lì xì Tết', CAST(N'2025-03-11T14:57:02.293' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (66, 20, 69, N'Rung cây lì xì Tết', CAST(N'2025-03-11T14:57:02.487' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (67, 20, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-14T20:41:03.483' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (68, 20, 77, N'Rung cây lì xì Tết', CAST(N'2025-03-14T20:41:06.003' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (69, 20, 53, N'Rung cây lì xì Tết', CAST(N'2025-03-14T20:41:06.490' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (70, 20, 90, N'Rung cây lì xì Tết', CAST(N'2025-03-14T20:41:07.203' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (71, 19, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-20T10:14:06.057' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (72, 19, 71, N'Rung cây lì xì Tết', CAST(N'2025-03-20T10:14:07.890' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (73, 19, 44, N'Rung cây lì xì Tết', CAST(N'2025-03-20T10:14:08.040' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (74, 19, 41, N'Rung cây lì xì Tết', CAST(N'2025-03-20T10:14:08.217' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (75, 19, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-03-30T09:11:56.307' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (76, 19, 46, N'Rung cây lì xì Tết', CAST(N'2025-03-30T09:11:57.133' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (77, 19, 45, N'Rung cây lì xì Tết', CAST(N'2025-03-30T09:11:57.320' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (78, 19, 71, N'Rung cây lì xì Tết', CAST(N'2025-03-30T09:11:57.493' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (79, 6, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-04-25T15:32:49.697' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (80, 6, 88, N'Rung cây lì xì Tết', CAST(N'2025-04-25T15:32:56.073' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (81, 6, 92, N'Rung cây lì xì Tết', CAST(N'2025-04-25T15:32:56.250' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (82, 6, 29, N'Rung cây lì xì Tết', CAST(N'2025-04-25T15:32:56.393' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (83, 6, 10, N'Hoàn thành nhiệm vụ: Đăng nhập hàng ngày', CAST(N'2025-05-05T15:01:28.857' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (84, 6, 92, N'Rung cây lì xì Tết', CAST(N'2025-05-05T15:01:30.447' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (85, 6, 99, N'Rung cây lì xì Tết', CAST(N'2025-05-05T15:01:30.727' AS DateTime))
INSERT [dbo].[ExpHistory] ([ExpHistoryId], [UserId], [ExpAmount], [Reason], [CreatedAt]) VALUES (86, 6, 82, N'Rung cây lì xì Tết', CAST(N'2025-05-05T15:01:31.083' AS DateTime))
SET IDENTITY_INSERT [dbo].[ExpHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Favorites] ON 

INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (19, 5, 12, CAST(N'2025-03-04T09:52:32.813' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (20, 6, 2, CAST(N'2025-03-04T19:19:00.810' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (22, 19, 15, CAST(N'2025-03-22T20:23:22.100' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (23, 19, 14, CAST(N'2025-03-22T20:23:32.973' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (24, 19, 6, CAST(N'2025-03-22T20:23:52.743' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (27, 19, 3, CAST(N'2025-03-24T18:08:35.267' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (30, 6, 3, CAST(N'2025-04-15T15:14:38.853' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (1030, 6, 17, CAST(N'2025-05-16T15:31:04.273' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (1031, 6, 15, CAST(N'2025-05-16T15:31:11.503' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (1032, 6, 13, CAST(N'2025-05-16T15:31:14.823' AS DateTime))
INSERT [dbo].[Favorites] ([Favorite_id], [UserId], [StoryId], [added_at]) VALUES (1033, 6, 12, CAST(N'2025-05-16T15:46:23.560' AS DateTime))
SET IDENTITY_INSERT [dbo].[Favorites] OFF
GO
SET IDENTITY_INSERT [dbo].[Followed_stories] ON 

INSERT [dbo].[Followed_stories] ([followId], [UserId], [StoryId], [followed_at], [LastReadChapterId]) VALUES (19, 6, 3, CAST(N'2025-04-15T15:14:37.400' AS DateTime), 79)
INSERT [dbo].[Followed_stories] ([followId], [UserId], [StoryId], [followed_at], [LastReadChapterId]) VALUES (1018, 6, 2, CAST(N'2025-05-16T15:54:15.587' AS DateTime), 116)
INSERT [dbo].[Followed_stories] ([followId], [UserId], [StoryId], [followed_at], [LastReadChapterId]) VALUES (1019, 6, 12, CAST(N'2025-05-16T15:54:23.173' AS DateTime), 74)
INSERT [dbo].[Followed_stories] ([followId], [UserId], [StoryId], [followed_at], [LastReadChapterId]) VALUES (1020, 6, 13, CAST(N'2025-05-16T15:54:29.567' AS DateTime), 113)
INSERT [dbo].[Followed_stories] ([followId], [UserId], [StoryId], [followed_at], [LastReadChapterId]) VALUES (1021, 6, 6, CAST(N'2025-05-16T15:54:39.340' AS DateTime), 122)
INSERT [dbo].[Followed_stories] ([followId], [UserId], [StoryId], [followed_at], [LastReadChapterId]) VALUES (1022, 6, 15, CAST(N'2025-05-16T15:54:54.770' AS DateTime), 120)
SET IDENTITY_INSERT [dbo].[Followed_stories] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (4, N'Manga', N'Truyện tranh của Nhật Bản', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (5, N'Manhua', N'Truyện tranh của Trung Quốc', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (6, N'School Life', N'Trong thể loại này, ngữ cảnh diễn biến câu chuyện chủ yếu ở trường học', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (7, N'Isekai', N'Isekai, đôi khi còn được gọi là xuyên không hay chuyển sinh, là một tiểu thể loại light novel, manga, anime và video game kỳ ảo của Nhật Bản, xoay quanh một người bình thường được đưa đến hoặc bị mắc kẹt trong một vũ trụ song song.', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (8, N'Action', N'Thể loại này thường có nội dung về đánh nhau, bạo lực, hỗn loạn, với diễn biến nhanh', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (9, N'Detective', N'Thể loại điều tra, trinh thám.', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (10, N'Huyền Huyễn', N'Truyện có yếu tố phép thuật, kỳ ảo… được đặt trong bối cảnh siêu tưởng (tiên giới, ma giới…)', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (11, N'Martial Arts', N'Giống với tên gọi, bất cứ gì liên quan đến võ thuật trong truyện từ các trận đánh nhau, tự vệ đến các môn võ thuật như akido, karate, judo hay taekwondo, kendo, các cách né tránh', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (12, N'Sci-fi', N'Bao gồm những chuyện khoa học viễn tưởng, đa phần chúng xoay quanh nhiều hiện tượng mà liên quan tới khoa học, công nghệ, tuy vậy thường thì những câu chuyện đó không gắn bó chặt chẽ với các thành tựu khoa học hiện thời, mà là do con người tưởng tượng ra', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (13, N'Supernatural', N'Thể hiện những sức mạnh đáng kinh ngạc và không thể giải thích được, chúng thường đi kèm với những sự kiện trái ngược hoặc thách thức với những định luật vật lý', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (14, N'Adventure', N'Thể loại phiêu lưu, mạo hiểm, thường là hành trình của các nhân vật', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (15, N'Doujinshi', N'Thể loại truyện phóng tác do fan hay có thể cả những Mangaka khác với tác giả truyện gốc. Tác giả vẽ Doujinshi thường dựa trên những nhân vật gốc để viết ra những câu chuyện theo sở thích của mình', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (16, N'Military', N'Truyện Quân Sự', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (17, N'Seinen', N'Thể loại của manga thường nhằm vào những đối tượng nam 18 đến 30 tuổi, nhưng người xem có thể lớn tuổi hơn, với một vài bộ truyện nhắm đến các doanh nhân nam quá 40. Thể loại này có nhiều phong cách riêng biệt , nhưng thể loại này có những nét riêng biệt, thường được phân vào những phong cách nghệ thuật rộng hơn và phong phú hơn về chủ đề, có các loại từ mới mẻ tiên tiến đến khiêu dâm', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (18, N'Tragedy', N'Thể loại chứa đựng những sự kiện mà dẫn đến kết cục là những mất mát hay sự rủi ro to lớn', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (19, N'Anime', N'Truyện đã được chuyển thể thành film Anime', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (20, N'Drama', N'Thể loại mang đến cho người xem những cảm xúc khác nhau: buồn bã, căng thẳng thậm chí là bi phẫn', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (21, N'Josei', N'Thể loại của manga hay anime được sáng tác chủ yếu bởi phụ nữ cho những độc giả nữ từ 18 đến 30. Josei manga có thể miêu tả những lãng mạn thực tế , nhưng trái ngược với hầu hết các kiểu lãng mạn lí tưởng của Shoujo manga với cốt truyện rõ ràng, chín chắn', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (22, N'Mystery', N'Thể loại thường xuất hiện những điều bí ấn không thể lí giải được và sau đó là những nỗ lực của nhân vật chính nhằm tìm ra câu trả lời thỏa đáng', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (23, N'Shoujo', N'Đối tượng hướng tới của thể loại này là phái nữ. Nội dung của những bộ manga này thường liên quan đến tình cảm lãng mạn, chú trọng đầu tư cho nhân vật (tính cách,...)', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (24, N'Trọng Sinh', N'Trọng sinh là thể loại mà nhân vật chính vì một lý do nào đó chết đi rồi đầu thai vào kiếp khác nhưng vẫn giữ lại được kí ức của mình ở kiếp trước.', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (25, N'Chuyển Sinh', N'Thể loại này là những câu chuyện về người ở một thế giới này xuyên đến một thế giới khác, có thể là thế giới mang phong cách trung cổ với kiếm sĩ và ma thuật, hay thế giới trong game, hoặc có thể là bạn chết ở nơi này và được chuyển sinh đến nơi khác', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (26, N'Fantasy', N'Thể loại xuất phát từ trí tưởng tượng phong phú, từ pháp thuật đến thế giới trong mơ thậm chí là những câu chuyện thần tiên', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (27, N'Mafia', NULL, NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (28, N'Shoujo Ai', N'Thể loại quan hệ hoặc liên quan tới đồng tính nữ, thể hiện trong các mối quan hệ trên mức bình thường giữa các nhân vật nữ trong các manga, anime', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (29, N'Truyện Màu', N'Tổng hợp truyện tranh màu, rõ, đẹp', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (30, N'Cổ Đại', N'Truyện có nội dung xảy ra ở thời cổ đại, phong kiến.', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (31, N'Gender Bender', N'Là một thể loại trong đó giới tính của nhân vật bị lẫn lộn: nam hoá thành nữ, nữ hóa thành nam...', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (32, N'Magic', N'Thể loại giả tưởng có tồn tại những sức mạnh siêu nhiên như thần chú, gây phép, vòng tròn ma thuật... ', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (33, N'One shot', N'Những truyện ngắn, thường là 1 chương', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (34, N'Shounen', N'Đối tượng hướng tới của thể loại này là phái nam. Nội dung của những bộ manga này thường liên quan đến đánh nhau và/hoặc bạo lực (ở mức bình thường, không thái quá)', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (35, N'Webtoon', N'Là truyện tranh được đăng dài kỳ trên internet của Hàn Quốc chứ không xuất bản theo cách thông thường', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (36, N'Comedy', N'Thể loại có nội dung trong sáng và cảm động, thường có các tình tiết gây cười, các xung đột nhẹ nhàng', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (37, N'Harem', N'Thể loại truyện tình cảm, lãng mạn mà trong đó, nhiều nhân vật nữ thích một nam nhân vật chính', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (38, N'Psychological', N'Thể loại liên quan đến những vấn đề về tâm lý của nhân vật ( tâm thần bất ổn, điên cuồng ...)', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (39, N'Shounen Ai', N'Thể loại có nội dung về tình yêu giữa những chàng trai trẻ, mang tính chất lãng mạn nhưng ko đề cập đến quan hệ tình dục', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (40, N'Xuyên Không', N'Xuyên Không, Xuyên Việt là thể loại nhân vật chính vì một lý do nào đó mà bị đưa đến sinh sống ở một không gian hay một khoảng thời gian khác. Nhân vật chính có thể trực tiếp xuyên qua bằng thân xác mình hoặc sống lại bằng thân xác người khác.', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (41, N'Manhwa', N'Truyện tranh Hàn Quốc, đọc từ trái sang phải', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (42, N'Comic', N'Truyện tranh Châu Âu và Châu Mĩ', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (43, N'Historical', N'Thể loại có liên quan đến thời xa xưa, lịch sử.', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (44, N'Romance', N'Thường là những câu chuyện về tình yêu, tình cảm lãng mạn. Ớ đây chúng ta sẽ lấy ví dụ như tình yêu giữa một người con trai và con gái, bên cạnh đó đặc điểm thể loại này là kích thích trí tưởng tượng của bạn về tình yêu', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (45, N'Slice of life', N'Nói về cuộc sống đời thường', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (46, N'Demons', N'Demons', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (47, N'Horror', N'Horror là: rùng rợn, nghe cái tên là bạn đã hiểu thể loại này có nội dung thế nào. Nó làm cho bạn kinh hãi, khiếp sợ, ghê tởm, run rẩy, có thể gây sock - một thể loại không dành cho người yếu tim', NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (48, N'Ngôn tình', NULL, NULL, NULL)
INSERT [dbo].[Genres] ([Genre_id], [Name], [Title], [Create_at], [Update_at]) VALUES (49, N'Thể Thao', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[Level] ON 

INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (4, 3000, 4)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (5, 6000, 5)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (6, 10000, 6)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (7, 20000, 7)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (8, 30000, 8)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (9, 45000, 9)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (10, 60000, 10)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (13, 0, 17)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (14, 100, 18)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (15, 1000, 19)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (16, 3000, 20)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (17, 6000, 21)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (18, 10000, 22)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (19, 20000, 23)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (20, 30000, 24)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (21, 45000, 25)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (22, 60000, 26)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (24, 100, 28)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (25, 1000, 29)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (26, 3000, 30)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (27, 6000, 31)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (28, 10000, 32)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (29, 20000, 33)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (30, 30000, 34)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (31, 45000, 35)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (32, 60000, 36)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (34, 0, 27)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (42, 100, 40)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (47, 0, 41)
INSERT [dbo].[Level] ([LevelId], [ExpRequired], [CategoryRankId]) VALUES (51, 1000, 3)
SET IDENTITY_INSERT [dbo].[Level] OFF
GO
SET IDENTITY_INSERT [dbo].[ManagerPermission] ON 

INSERT [dbo].[ManagerPermission] ([PermissionId], [AdminId], [Module], [CanView], [CanEdit], [CanCreate], [CanDelete], [AssignedBy], [AssignedAt]) VALUES (19, 3, N'Banners', 0, 0, 0, 0, 1, CAST(N'2025-04-24T16:18:10.877' AS DateTime))
INSERT [dbo].[ManagerPermission] ([PermissionId], [AdminId], [Module], [CanView], [CanEdit], [CanCreate], [CanDelete], [AssignedBy], [AssignedAt]) VALUES (20, 4, N'Banners', 1, 0, 1, 0, 1, CAST(N'2025-04-24T16:20:29.350' AS DateTime))
INSERT [dbo].[ManagerPermission] ([PermissionId], [AdminId], [Module], [CanView], [CanEdit], [CanCreate], [CanDelete], [AssignedBy], [AssignedAt]) VALUES (21, 4, N'Ranks', 1, 0, 0, 0, 1, CAST(N'2025-04-24T16:55:07.770' AS DateTime))
INSERT [dbo].[ManagerPermission] ([PermissionId], [AdminId], [Module], [CanView], [CanEdit], [CanCreate], [CanDelete], [AssignedBy], [AssignedAt]) VALUES (22, 4, N'Genres', 1, 1, 1, 1, 1, CAST(N'2025-04-24T17:55:17.843' AS DateTime))
SET IDENTITY_INSERT [dbo].[ManagerPermission] OFF
GO
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([NotificationId], [UserId], [Message], [CreatedAt], [IsRead], [Link], [CommentId]) VALUES (3, 20, N'Lybys112 đã trả lời bình luận của bạn.', CAST(N'2025-03-10T17:41:06.640' AS DateTime), 0, N'/Home/Details/14?commentPage=1#comment-221', 224)
INSERT [dbo].[Notification] ([NotificationId], [UserId], [Message], [CreatedAt], [IsRead], [Link], [CommentId]) VALUES (4, 20, N'Lybys112 đã nhắc đến bạn trong một câu trả lời.', CAST(N'2025-03-10T17:41:06.660' AS DateTime), 0, N'/Home/Details/14?commentPage=1#comment-224', 224)
INSERT [dbo].[Notification] ([NotificationId], [UserId], [Message], [CreatedAt], [IsRead], [Link], [CommentId]) VALUES (5, 19, N'Lybys đã nhắc đến bạn trong một câu trả lời.', CAST(N'2025-03-10T18:01:34.973' AS DateTime), 0, N'/Home/Details/2?commentPage=1#comment-226', 226)
INSERT [dbo].[Notification] ([NotificationId], [UserId], [Message], [CreatedAt], [IsRead], [Link], [CommentId]) VALUES (6, 19, N'Lybys đã nhắc đến bạn trong một bình luận.', CAST(N'2025-03-11T15:01:13.930' AS DateTime), 0, N'/Home/Details/14?commentPage=1#comment-227', 227)
INSERT [dbo].[Notification] ([NotificationId], [UserId], [Message], [CreatedAt], [IsRead], [Link], [CommentId]) VALUES (7, 20, N'Lybys112 đã nhắc đến bạn trong một câu trả lời.', CAST(N'2025-03-20T10:43:13.667' AS DateTime), 0, N'/Home/Details/14?commentPage=1#comment-228', 228)
INSERT [dbo].[Notification] ([NotificationId], [UserId], [Message], [CreatedAt], [IsRead], [Link], [CommentId]) VALUES (14, 6, N'Lybys112 đã nhắc đến bạn trong một câu trả lời.', CAST(N'2025-04-25T15:38:54.360' AS DateTime), 0, N'/Home/Details/6?commentPage=1#comment-1240', 1240)
SET IDENTITY_INSERT [dbo].[Notification] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchasedAvatarFrame] ON 

INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1, 1, 14, CAST(N'2025-03-02T17:41:05.550' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (2, 2, 14, CAST(N'2025-03-02T17:41:41.253' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (3, 5, 13, CAST(N'2025-03-03T15:02:10.770' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (4, 19, 14, CAST(N'2025-03-07T17:10:22.157' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (5, 21, 14, CAST(N'2025-03-17T23:06:51.153' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (14, 6, 14, CAST(N'2025-04-15T15:17:33.607' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1014, 6, 12, CAST(N'2025-05-16T14:42:51.313' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1015, 6, 6, CAST(N'2025-05-16T14:59:51.930' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1016, 6, 8, CAST(N'2025-05-16T15:00:00.570' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1017, 6, 9, CAST(N'2025-05-16T15:00:11.303' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1018, 6, 10, CAST(N'2025-05-16T15:00:15.370' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1019, 6, 11, CAST(N'2025-05-16T15:00:18.640' AS DateTime))
INSERT [dbo].[PurchasedAvatarFrame] ([PurchasedAvatarFrameId], [UserId], [AvatarFrameId], [PurchasedAt]) VALUES (1020, 6, 13, CAST(N'2025-05-16T15:00:22.117' AS DateTime))
SET IDENTITY_INSERT [dbo].[PurchasedAvatarFrame] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchasedChapter] ON 

INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (37, 19, NULL, CAST(N'2025-03-19T15:21:54.750' AS DateTime), N'ST1_1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (38, 19, NULL, CAST(N'2025-03-19T18:41:00.703' AS DateTime), N'SH2_1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (39, 19, NULL, CAST(N'2025-03-20T14:08:10.783' AS DateTime), N'ST2_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (40, 19, NULL, CAST(N'2025-03-20T14:08:56.110' AS DateTime), N'ST2_C2')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (41, 19, NULL, CAST(N'2025-03-20T14:09:22.593' AS DateTime), N'ST2_C4')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (42, 19, NULL, CAST(N'2025-03-21T22:43:24.500' AS DateTime), N'ST2_C3')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (43, 19, NULL, CAST(N'2025-03-21T23:17:37.897' AS DateTime), N'ST1_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (44, 19, NULL, CAST(N'2025-03-21T23:18:17.143' AS DateTime), N'ST2_C6')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (45, 19, NULL, CAST(N'2025-03-21T23:18:43.603' AS DateTime), N'ST2_C7')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (46, 20, NULL, CAST(N'2025-03-21T23:19:21.653' AS DateTime), N'ST2_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (47, 20, NULL, CAST(N'2025-03-21T23:19:24.440' AS DateTime), N'ST2_C2')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (48, 20, NULL, CAST(N'2025-03-21T23:19:26.920' AS DateTime), N'ST2_C3')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (49, 19, NULL, CAST(N'2025-03-22T18:41:51.240' AS DateTime), N'ST3_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (50, 19, NULL, CAST(N'2025-03-25T15:37:51.437' AS DateTime), N'ST2_C8')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (51, 6, NULL, CAST(N'2025-04-05T21:30:27.763' AS DateTime), N'ST2_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (52, 6, NULL, CAST(N'2025-04-08T17:02:15.367' AS DateTime), N'ST2_C2')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (53, 19, NULL, CAST(N'2025-04-08T17:07:52.517' AS DateTime), N'ST3_C2')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (54, 19, NULL, CAST(N'2025-04-08T17:08:28.587' AS DateTime), N'ST3_C3')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (55, 19, NULL, CAST(N'2025-04-08T17:22:29.167' AS DateTime), N'ST4_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (56, 6, NULL, CAST(N'2025-04-08T18:05:03.517' AS DateTime), N'ST2_C3')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (57, 6, NULL, CAST(N'2025-04-08T18:07:30.677' AS DateTime), N'ST2_C5')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (58, 6, NULL, CAST(N'2025-04-09T15:03:28.593' AS DateTime), N'ST3_C2')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (59, 6, NULL, CAST(N'2025-04-09T15:06:47.940' AS DateTime), N'ST3_C3')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (60, 6, NULL, CAST(N'2025-04-09T15:11:43.883' AS DateTime), N'ST2_C4')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (61, 6, NULL, CAST(N'2025-04-09T15:18:11.923' AS DateTime), N'ST3_C6')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (62, 6, NULL, CAST(N'2025-04-09T15:47:14.823' AS DateTime), N'ST3_C5')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (63, 6, 74, CAST(N'2025-04-09T16:10:33.447' AS DateTime), N'ST4_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (64, 19, 75, CAST(N'2025-04-09T16:15:30.967' AS DateTime), N'ST4_C2')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (65, 19, 83, CAST(N'2025-04-09T16:15:54.587' AS DateTime), N'ST3_C6')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (66, 19, 82, CAST(N'2025-04-09T16:18:29.257' AS DateTime), N'ST3_C5')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (68, 6, 122, CAST(N'2025-04-15T22:11:13.040' AS DateTime), N'_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (69, 6, 119, CAST(N'2025-04-15T22:11:19.593' AS DateTime), N'ST1_C1')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (1067, 6, 123, CAST(N'2025-05-05T14:49:50.983' AS DateTime), N'_C2')
INSERT [dbo].[PurchasedChapter] ([PurchasedChapterId], [UserId], [ChapterId], [PurchasedAt], [ChapterCode]) VALUES (1068, 6, 120, CAST(N'2025-05-13T15:42:41.030' AS DateTime), N'ST1_C2')
SET IDENTITY_INSERT [dbo].[PurchasedChapter] OFF
GO
SET IDENTITY_INSERT [dbo].[Rank] ON 

INSERT [dbo].[Rank] ([RankId], [Name], [Create_at], [Update_at]) VALUES (1, N'Tu Tiên', NULL, NULL)
INSERT [dbo].[Rank] ([RankId], [Name], [Create_at], [Update_at]) VALUES (2, N'Hiệp Sĩ', NULL, NULL)
INSERT [dbo].[Rank] ([RankId], [Name], [Create_at], [Update_at]) VALUES (3, N'Pháp Sư', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Rank] OFF
GO
SET IDENTITY_INSERT [dbo].[Reading_history] ON 

INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (77, 19, 12, 74, CAST(N'2025-04-09T16:15:24.360' AS DateTime), CAST(N'2025-03-19T19:00:47.830' AS DateTime), CAST(N'2025-03-19T19:00:47.830' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (78, 19, 12, 75, CAST(N'2025-04-09T16:15:31.043' AS DateTime), CAST(N'2025-03-19T19:00:52.287' AS DateTime), CAST(N'2025-03-19T19:00:52.287' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (100, 19, 3, 79, CAST(N'2025-04-08T17:07:52.623' AS DateTime), CAST(N'2025-04-08T17:07:45.637' AS DateTime), CAST(N'2025-04-08T17:07:45.643' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (101, 19, 3, 80, CAST(N'2025-04-08T17:08:28.610' AS DateTime), CAST(N'2025-04-08T17:07:58.097' AS DateTime), CAST(N'2025-04-08T17:07:58.100' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (103, 19, 3, 100, CAST(N'2025-04-08T17:10:00.753' AS DateTime), CAST(N'2025-04-08T17:10:00.753' AS DateTime), CAST(N'2025-04-08T17:10:00.753' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (104, 19, 3, 83, CAST(N'2025-04-09T16:15:54.610' AS DateTime), CAST(N'2025-04-08T17:10:23.203' AS DateTime), CAST(N'2025-04-08T17:10:23.207' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (105, 19, 3, 82, CAST(N'2025-04-09T16:18:29.383' AS DateTime), CAST(N'2025-04-08T17:10:31.427' AS DateTime), CAST(N'2025-04-08T17:10:31.420' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (106, 19, 3, 81, CAST(N'2025-04-08T17:11:26.047' AS DateTime), CAST(N'2025-04-08T17:11:26.047' AS DateTime), CAST(N'2025-04-08T17:11:26.047' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (107, 6, 3, 100, CAST(N'2025-04-09T15:32:33.683' AS DateTime), CAST(N'2025-04-08T17:18:25.107' AS DateTime), CAST(N'2025-04-08T17:18:25.223' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (108, 6, 3, 83, CAST(N'2025-04-09T16:17:57.337' AS DateTime), CAST(N'2025-04-08T17:18:26.767' AS DateTime), CAST(N'2025-04-08T17:18:26.770' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (109, 6, 3, 79, CAST(N'2025-05-05T14:56:21.217' AS DateTime), CAST(N'2025-04-08T17:20:44.060' AS DateTime), CAST(N'2025-04-08T17:20:44.137' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (110, 6, 3, 80, CAST(N'2025-04-09T16:18:03.497' AS DateTime), CAST(N'2025-04-08T17:20:47.433' AS DateTime), CAST(N'2025-04-08T17:20:47.433' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (111, 6, 3, 81, CAST(N'2025-04-09T16:18:01.350' AS DateTime), CAST(N'2025-04-08T17:20:48.980' AS DateTime), CAST(N'2025-04-08T17:20:48.980' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (115, 6, 3, 82, CAST(N'2025-04-09T15:47:18.240' AS DateTime), CAST(N'2025-04-09T15:47:12.713' AS DateTime), CAST(N'2025-04-09T15:47:12.753' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (116, 6, 12, 74, CAST(N'2025-05-16T15:54:25.173' AS DateTime), CAST(N'2025-04-09T16:09:51.880' AS DateTime), CAST(N'2025-04-09T16:09:51.927' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (117, 6, 12, 75, CAST(N'2025-04-14T15:04:35.347' AS DateTime), CAST(N'2025-04-09T16:15:01.133' AS DateTime), CAST(N'2025-04-09T16:15:01.263' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (119, 6, 14, 103, CAST(N'2025-04-15T22:24:58.620' AS DateTime), CAST(N'2025-04-15T15:06:45.877' AS DateTime), CAST(N'2025-04-15T15:06:45.880' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (120, 6, 6, 122, CAST(N'2025-05-16T15:54:43.477' AS DateTime), CAST(N'2025-04-15T22:11:11.390' AS DateTime), CAST(N'2025-04-15T22:11:11.403' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (121, 6, 15, 119, CAST(N'2025-05-13T15:39:30.827' AS DateTime), CAST(N'2025-04-15T22:11:17.943' AS DateTime), CAST(N'2025-04-15T22:11:17.947' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1119, 6, 15, 120, CAST(N'2025-05-16T15:54:56.767' AS DateTime), CAST(N'2025-04-22T16:05:39.323' AS DateTime), CAST(N'2025-04-22T16:05:39.333' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1120, 6, 6, 123, CAST(N'2025-05-05T14:49:51.020' AS DateTime), CAST(N'2025-04-25T15:36:56.683' AS DateTime), CAST(N'2025-04-25T15:36:56.690' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1121, 6, 17, 1104, CAST(N'2025-05-16T14:25:32.983' AS DateTime), CAST(N'2025-05-16T14:25:32.983' AS DateTime), CAST(N'2025-05-16T14:25:32.990' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1122, 6, 2, 116, CAST(N'2025-05-16T15:54:17.667' AS DateTime), CAST(N'2025-05-16T15:54:12.237' AS DateTime), CAST(N'2025-05-16T15:54:12.367' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1123, 6, 13, 113, CAST(N'2025-05-16T15:54:31.250' AS DateTime), CAST(N'2025-05-16T15:54:31.250' AS DateTime), CAST(N'2025-05-16T15:54:31.253' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1124, 6, 6, 124, CAST(N'2025-05-16T15:54:41.087' AS DateTime), CAST(N'2025-05-16T15:54:41.087' AS DateTime), CAST(N'2025-05-16T15:54:41.073' AS DateTime))
INSERT [dbo].[Reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1125, 6, 6, 1103, CAST(N'2025-05-16T15:54:42.340' AS DateTime), CAST(N'2025-05-16T15:54:42.340' AS DateTime), CAST(N'2025-05-16T15:54:42.347' AS DateTime))
SET IDENTITY_INSERT [dbo].[Reading_history] OFF
GO
SET IDENTITY_INSERT [dbo].[RechargeHistory] ON 

INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (1, 19, 2000, 2, N'Pending', N'RC1', CAST(N'2025-04-01T15:41:10.587' AS DateTime), NULL, NULL)
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (2, 19, 2000, 2, N'Pending', N'RC2', CAST(N'2025-04-01T15:41:24.203' AS DateTime), NULL, NULL)
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (3, 6, 2000, 2, N'Pending', N'RC3', CAST(N'2025-04-01T15:42:02.040' AS DateTime), NULL, NULL)
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (4, 6, 1000, 1, N'Pending', N'RC4', CAST(N'2025-04-01T15:42:08.653' AS DateTime), NULL, NULL)
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (5, 19, 2000, 2, N'Pending', N'RC5', CAST(N'2025-04-01T15:43:49.903' AS DateTime), NULL, NULL)
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (7, 19, 2000, 2, N'Failed', N'MM7', CAST(N'2025-04-01T15:55:29.740' AS DateTime), NULL, NULL)
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (8, 19, 2000, 2, N'Pending', N'MM8', CAST(N'2025-04-01T15:59:04.797' AS DateTime), NULL, NULL)
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (10, 19, 2000, 2, N'Failed', N'MM10', CAST(N'2025-04-01T16:11:12.160' AS DateTime), NULL, N'captureWallet                                                                                                                                                                                                                                                  ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (12, 19, 2000, 2, N'Failed', N'MM12', CAST(N'2025-04-01T16:15:02.620' AS DateTime), NULL, N'captureWallet                                                                                                                                                                                                                                                  ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (16, 6, 10000, 10, N'Failed', N'MM16', CAST(N'2025-04-01T16:30:19.340' AS DateTime), NULL, N'captureWallet                                                                                                                                                                                                                                                  ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (17, 6, 10000, 10, N'Completed', N'MM17', CAST(N'2025-04-01T16:30:41.140' AS DateTime), CAST(N'2025-04-01T16:32:30.493' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (19, 19, 10000, 10, N'Failed', N'MM19', CAST(N'2025-04-01T16:50:47.747' AS DateTime), NULL, N'captureWallet                                                                                                                                                                                                                                                  ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (21, 19, 5000, 2000, N'Failed', N'MM21', CAST(N'2025-04-01T16:53:04.337' AS DateTime), NULL, N'captureWallet                                                                                                                                                                                                                                                  ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (23, 19, 10000, 2500, N'Completed', N'MM23', CAST(N'2025-04-01T16:53:22.543' AS DateTime), CAST(N'2025-04-01T16:54:27.680' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (24, 6, 10000, 1000, N'Failed', N'MM24', CAST(N'2025-04-01T16:55:10.470' AS DateTime), NULL, N'captureWallet                                                                                                                                                                                                                                                  ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (25, 6, 10000, 1000, N'Completed', N'MM25', CAST(N'2025-04-01T16:55:21.763' AS DateTime), CAST(N'2025-04-01T16:56:16.937' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (26, 6, 10000, 1000, N'Pending', N'MM26', CAST(N'2025-04-01T16:58:36.963' AS DateTime), NULL, N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (106, 6, 10000, 1000, N'Pending', N'MM106', CAST(N'2025-04-02T15:39:07.853' AS DateTime), NULL, N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (107, 6, 10000, 1000, N'Pending', N'MM107', CAST(N'2025-04-05T18:42:04.170' AS DateTime), NULL, N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (108, 6, 10000, 1000, N'Failed', N'MM108', CAST(N'2025-04-05T21:30:04.457' AS DateTime), NULL, N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (109, 6, 10000, 1000, N'Completed', N'MM109', CAST(N'2025-04-10T12:40:36.803' AS DateTime), CAST(N'2025-04-10T12:41:43.057' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (110, 6, 10000, 1000, N'Completed', N'MM110', CAST(N'2025-04-15T15:16:26.190' AS DateTime), CAST(N'2025-04-15T15:17:22.600' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (111, 6, 10000, 1000, N'Failed', N'MM111', CAST(N'2025-04-15T22:18:12.483' AS DateTime), NULL, N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (1110, 6, 10000, 1000, N'Completed', N'MM1110', CAST(N'2025-04-22T14:04:07.917' AS DateTime), CAST(N'2025-04-22T14:04:56.847' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (1111, 6, 10000, 1000, N'Failed', N'MM1111', CAST(N'2025-05-05T14:48:13.147' AS DateTime), NULL, N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (1112, 6, 10000, 1000, N'Completed', N'MM1112', CAST(N'2025-05-10T14:55:23.170' AS DateTime), CAST(N'2025-05-10T14:56:50.087' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (1113, 6, 2000000, 200000, N'Completed', N'MM1113', CAST(N'2025-05-13T15:46:50.970' AS DateTime), CAST(N'2025-05-13T15:47:44.807' AS DateTime), N'payWithATM                                                                                                                                                                                                                                                     ')
INSERT [dbo].[RechargeHistory] ([RechargeId], [UserId], [Amount], [Coins], [Status], [MomoTransactionId], [CreatedAt], [CompletedAt], [PaymentMethod]) VALUES (1114, 6, 10000, 1000, N'Pending', N'MM1114', CAST(N'2025-05-16T16:08:57.290' AS DateTime), NULL, N'payWithATM                                                                                                                                                                                                                                                     ')
SET IDENTITY_INSERT [dbo].[RechargeHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (1, N'SuperAdmin', N'Toàn quyền hệ thống')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (2, N'ContentManager', N'Duyệt/chỉnh sửa/xóa truyện và chapter, quản lý thể loại, tag.')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (3, N'UserManager', N'Quản lý người dùng (user), khoá/mở tài khoản, theo dõi nạp xu, xử lý report')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (4, N'FinanceManager', N'Quản lý nạp/rút xu, xem lịch sử giao dịch, xử lý các vấn đề thanh toán')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (5, N'CommentModerator', N'Duyệt/xoá bình luận, xử lý vi phạm bình luận')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (6, N'ReporterHandler', N'Xem và xử lý các báo cáo từ người dùng (vi phạm nội dung, spam, v.v.)')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [Description]) VALUES (7, N'Admin', N'Quản lý phân vùng và cấp quyền cho các ContentManager, UserManager,...')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Sticker] ON 

INSERT [dbo].[Sticker] ([StickerId], [Name], [ImagePath], [Create_at], [Update_at]) VALUES (1, N'stick 1', N'images/stickers/sticker-cute-la-chona-2.jpg', NULL, NULL)
INSERT [dbo].[Sticker] ([StickerId], [Name], [ImagePath], [Create_at], [Update_at]) VALUES (2, N'sticker 2', N'images/stickers/sticker-cute-la-chona-3.jpg', NULL, NULL)
INSERT [dbo].[Sticker] ([StickerId], [Name], [ImagePath], [Create_at], [Update_at]) VALUES (3, N'sticker 3', N'images/stickers/sticker-cute-la-chona-4.jpg', NULL, NULL)
INSERT [dbo].[Sticker] ([StickerId], [Name], [ImagePath], [Create_at], [Update_at]) VALUES (4, N'sticker 4', N'images/stickers/sticker-cute-la-chona-5.jpg', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Sticker] OFF
GO
SET IDENTITY_INSERT [dbo].[Stories] ON 

INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (2, N'Chưởng Môn Khiêm Tốn Chút', N'Đang cập nhật', N'<p style="text-align: justify;">Xuy&ecirc;n kh&ocirc;ng tới Thi&ecirc;n Huyền Giới, th&acirc;n phận l&agrave; chưởng m&ocirc;n dởm của Mạc m&ocirc;n, Đ&ocirc; Th&agrave;nh Khắc Kim t&aacute;i sinh ở trong thế giới tr&ograve; chơi, kh&ocirc;ng để người chơi v&agrave;o mắt, thu nhận nh&acirc;n vật ch&iacute;nh của thế giới n&agrave;y l&agrave;m tiểu đệ, giả dạng l&agrave;m thi&ecirc;n hạ đệ nhất!</p>', N'images/admins/stories/ChuongMonKhiemTonChut.jfif', CAST(N'2025-03-03T10:19:30.803' AS DateTime), 0, CAST(N'2025-04-15T22:10:16.540' AS DateTime), 0, 1, N'ST2', NULL)
INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (3, N'Cửu Thiên Kiếm Pháp', N'Đang cập nhật', N'<p style="text-align: justify;">"&Ocirc;ng ấy l&agrave; chủ nh&acirc;n của Cửu Thi&ecirc;n." Yeon Jeokha l&agrave; con của một người vợ lẽ. Bị vợ của cha m&igrave;nh v&agrave; c&aacute;c anh chị em của m&igrave;nh bắt nạt một c&aacute;ch t&agrave;n nhẫn, anh ta sau đ&oacute; bị giam trong nh&agrave; kho sau khi cha anh ta qua đời v&igrave; bệnh tật&hellip; Đ&atilde; mười năm kể từ khi anh ta trốn tho&aacute;t sau khi anh ta học được m&ocirc;n v&otilde; thuật vượt ra ngo&agrave;i thế giới. Cuộc phi&ecirc;u lưu kh&ocirc;ng thể ngăn cản của người kế thừa duy nhất của Cửu Thi&ecirc;n, Yeon Jeokha, bắt đầu ngay b&acirc;y giờ!</p>', N'images/admins/stories/CuuThienKiemPhap.jfif', CAST(N'2025-03-03T10:19:59.923' AS DateTime), 0, CAST(N'2025-03-22T18:41:12.497' AS DateTime), 0, 1, N'ST3', NULL)
INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (6, N'Vinh Quang Vô Tận', N'Đang cập nhật', N'<p style="text-align: justify;">Halo, nhạc sĩ giỏi nhất thời bấy giờ, gặp tai nạn giao th&ocirc;ng tr&ecirc;n đường tới lễ trao giải Grammy. v&agrave; khi anh ấy tỉnh lại, anh thấy m&igrave;nh trong cơ thể của một cậu b&eacute; người H&agrave;n Quốc t&ecirc;n No Hae-il. Anh ấy thấy m&igrave;nh trong thế giới ho&agrave;n to&agrave;n kh&aacute;c</p>', N'images/admins/stories/VinhQuangVoTan.jfif', CAST(N'2025-03-03T10:21:06.690' AS DateTime), 0, CAST(N'2025-04-22T16:56:15.720' AS DateTime), 0, 1, NULL, NULL)
INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (12, N'Vạn Tra Triêu Hoàng', N'Đang cập nhật', N'<p style="text-align: justify;">Truyện tranh Vạn Tra Tri&ecirc;u Ho&agrave;ng được cập nhật nhanh v&agrave; đầy đủ nhất tại TATruyen. Bạn đọc đừng qu&ecirc;n để lại b&igrave;nh luận v&agrave; chia sẻ, ủng hộ TruyenQQ ra c&aacute;c chương mới nhất của truyện Vạn Tra Tri&ecirc;u Ho&agrave;ng.</p>', N'images/admins/stories/VanTraTrieuHoang.jpg', CAST(N'2025-03-03T10:22:26.617' AS DateTime), 0, CAST(N'2025-03-03T18:41:03.653' AS DateTime), 0, 1, NULL, NULL)
INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (13, N'Thiết Huyết Kiếm Sĩ Hồi Quy', N'Đang cập nhật', N'<p style="text-align: justify;">1 t&aacute;c phẩm đến từ Red Ice Studio, studio đ&atilde; thực hiện Tử Thần Phi&ecirc;u Nguyệt, Thợ R&egrave;n Huyền Thoại, Cửu Thi&ecirc;n Cực Kiếm...</p>', N'images/admins/stories/thiet-huyet-kiem-si-hoi-quy_1681531186.jpg', CAST(N'2025-03-03T16:13:48.010' AS DateTime), 0, CAST(N'2025-04-15T22:09:47.473' AS DateTime), 0, 1, NULL, NULL)
INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (14, N'Nguyên Lai Ta Là Tu Tiên Đại Lão', N'Đang cập nhật', N'<p style="text-align: justify;">- Từ một thế giới tu ti&ecirc;n đang tr&ecirc;n đ&agrave; xuống dốc , sự xuất hiện của hắn giống như thổi một l&agrave;n sức sống mới ngăn chặn sự xuống dốc đ&oacute; . Từ sau đại kiếp , Long m&ocirc;n , Địa Phủ , Thi&ecirc;n Cung bị phong bế đều bởi v&igrave; hắn m&agrave; lần lượt mở ra ... Truyện đi từ từ dần dần mang đậm phong c&aacute;ch h&agrave;i hước , tuy cũng c&oacute; sạn nhưng cũng kh&ocirc;ng phải nhiều bởi mỗi thế giới l&agrave; của một t&aacute;c giả tạo n&ecirc;n cho n&ecirc;n chẳng c&oacute; ai c&oacute; thể định đ&uacute;ng sai , t&aacute;c giả c&oacute; kh&aacute;c g&igrave; thi&ecirc;n đạo , truyện n&agrave;y mang t&iacute;nh giải tr&iacute; cực cao , đủ để c&aacute;c đạo hữu đọc tới xuy&ecirc;n đ&ecirc;m .<br>___________________<br>-Ti&ecirc;n đạo mờ mịt , ti&ecirc;n tung kh&oacute; t&igrave;m .<br>-L&yacute; Niệm Ph&agrave;m tới thế giới tu ti&ecirc;n với th&acirc;n thể của một người ph&agrave;m , sau khi biết được rằng kh&ocirc;ng c&oacute; hy vọng ở việc tu ti&ecirc;n th&igrave; chỉ muốn sống một cuộc sống ổn định qua ng&agrave;y . Lại kh&ocirc;ng biết Con ch&oacute; nhỏ m&agrave; m&igrave;nh nu&ocirc;i dưỡng , bởi v&igrave; ở b&ecirc;n cạnh hắn cho n&ecirc;n được ăn c&aacute;c loại hoa quả m&agrave; hắn trồng ra , những m&oacute;n ăn m&agrave; hắn l&agrave;m , thấy c&aacute;c loại thơ m&agrave; hắn viết từ đ&oacute; trở th&agrave;nh một con ch&oacute; s&acirc;u kh&ocirc;ng lường được , &acirc;m thầm bảo vệ nơi ở của hắn . C&acirc;y cối hắn trồng ở hậu viện , bởi v&igrave; nghe hắn đ&aacute;nh đ&agrave;n m&agrave; đều trở th&agrave;nh những c&acirc;y đại thụ cũng s&acirc;u kh&ocirc;ng lường được , chống đỡ l&agrave;m cầu nối trong thi&ecirc;n địa . Hắn gặp phải một t&ecirc;n thư sinh ăn mặc như kẻ ăn m&agrave;y , bởi v&igrave; theo những lời n&oacute;i hững hờ của hắn m&agrave; lại trở th&agrave;nh thuận miệng điểm h&oacute;a cho t&ecirc;n thư sinh đ&oacute; , trở th&agrave;nh người truyền đạo , đứng đầu một thời đại<br>- Hỏa Tước v&ocirc; c&ugrave;ng cực hiếm c&oacute; đẻ ra trứng th&igrave; chỉ cần nh&igrave;n thấy hắn l&agrave; ra sức đẻ trứng , một lần 2 3 4 5 quả trứng ... cuối c&ugrave;ng được gọi l&agrave; g&agrave; biết để trứng . - Ngũ Sắc Thần Ngưu ki&ecirc;u căng ngạo mạn , được k&eacute;o về hậu viện của hắn , lấy cỏ đều l&agrave; linh căn m&agrave; ăn , thấy hắn th&igrave; ra sức m&agrave; tạo sữa , nguồn sữa dồi d&agrave;o kh&ocirc;ng dứt th&agrave;nh b&ograve; sữa<br>___________________________<br>-Cảnh giới trong thế giới tu ti&ecirc;n : Luyện Kh&iacute; , Tr&uacute;c Cơ , Kim Đan Nguy&ecirc;n Anh , Xuất Khiếu Ph&acirc;n Thần , Hợp Thế Độ Kiếp Đại Thừa Trong Ti&ecirc;n giới ti&ecirc;n nh&acirc;n chia Thi&ecirc;n Ti&ecirc;n , Ch&acirc;n Ti&ecirc;n , Kim Ti&ecirc;n , Th&aacute;i Ất Kim Ti&ecirc;n , Đại La Kim Ti&ecirc;n , B&aacute;n Th&aacute;nh . Th&aacute;nh Nh&acirc;n</p>', N'images/admins/stories/nguyen-lai-ta-la-tu-tien-dai-lao_1644166269.jpg', CAST(N'2025-03-06T13:57:59.903' AS DateTime), 0, CAST(N'2025-04-15T15:08:23.670' AS DateTime), 1, 1, N'ST4', NULL)
INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (15, N'Người Chơi Mạnh Nhất Hồi Quy Lần Thứ 100', N'Đang cập nhật', N'<p style="text-align: justify;">Truyện được cập nhật nhanh v&agrave; đầy đủ nhất tại TAQQ. Bạn đọc đừng qu&ecirc;n để lại b&igrave;nh luận v&agrave; chia sẻ, ủng hộ TAMANGA ra c&aacute;c chương mới nhất nha</p>', N'images/admins/stories/nguoi-choi-manh-nhat-hoi-quy-lan-thu-100_1698889715.jpg', CAST(N'2025-03-19T15:18:52.540' AS DateTime), 0, CAST(N'2025-05-13T08:59:42.333' AS DateTime), 1, 0, N'ST1', NULL)
INSERT [dbo].[Stories] ([story_id], [title], [author], [description], [cover_image], [created_at], [IsCompleted], [LastUpdatedAt], [IsHot], [IsNew], [storyCode], [view]) VALUES (17, N'Một Căn Phòng, Đầy Ánh Sáng, Có Thiên Thần', N'Đang cập nhật', N'<p>Được cập nhật nhanh v&agrave; đầy đủ nhất tại TAMANGA. Bạn đọc đừng qu&ecirc;n để lại b&igrave;nh luận v&agrave; chia sẻ, ủng hộ TruyenQQ ra c&aacute;c chương mới nhất của truyện.</p>', N'images/admins/stories/mot-can-phong-day-anh-sang-co-thien-than_1745420701.jpg', CAST(N'2025-05-16T14:20:52.993' AS DateTime), 0, CAST(N'2025-05-16T14:24:57.980' AS DateTime), 1, 0, N'ST6', NULL)
SET IDENTITY_INSERT [dbo].[Stories] OFF
GO
SET IDENTITY_INSERT [dbo].[Story_genres] ON 

INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (157, 2, 8)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (125, 6, 6)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (127, 6, 29)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (112, 12, 5)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (111, 12, 20)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (110, 12, 36)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (135, 13, 8)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (136, 13, 29)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (164, 15, 5)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (165, 15, 8)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (166, 15, 29)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (175, 17, 6)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (176, 17, 13)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (177, 17, 36)
INSERT [dbo].[Story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (178, 17, 44)
SET IDENTITY_INSERT [dbo].[Story_genres] OFF
GO
SET IDENTITY_INSERT [dbo].[Transactions] ON 

INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (1, 1, 10000, 100, N'Pending', NULL, CAST(N'2025-02-24T16:58:42.073' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (10, 1, 2000, 2000, N'Success', N'1740652898', CAST(N'2025-02-27T17:42:09.443' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (11, 2, 2000, 2000, N'Success', N'1740653177', CAST(N'2025-02-27T17:46:58.820' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (12, 19, 2000, 2000, N'Success', N'1741342103', CAST(N'2025-03-07T17:09:30.307' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (13, 20, 2000, 4000, N'Success', N'1741344421', CAST(N'2025-03-07T17:47:46.450' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (14, 20, 2000, 2000, N'Success', N'1741344488', CAST(N'2025-03-07T17:48:51.270' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (15, 19, 5000, 500, N'Success', N'1742223379', CAST(N'2025-03-17T21:57:05.573' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (16, 21, 5000, 2000, N'Success', N'1742227183', CAST(N'2025-03-17T23:00:50.420' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (17, 21, 5000, 500, N'Success', N'1742227969', CAST(N'2025-03-17T23:13:20.763' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (18, 19, 5000, 500, N'Success', N'1743300436', CAST(N'2025-03-30T09:08:15.157' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (19, 6, 2000, 2, N'Pending', N'MOMO_638791161987093061', CAST(N'2025-04-01T14:56:38.710' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (20, 6, 4000, 4, N'Pending', N'MOMO_638791162167465951', CAST(N'2025-04-01T14:56:56.747' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (21, 6, 1000, 1, N'Pending', N'MOMO_638791164750442899', CAST(N'2025-04-01T15:01:22.693' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (22, 6, 2000, 2, N'Pending', N'MOMO_638791167895203782', CAST(N'2025-04-01T15:06:29.520' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (30, 6, 5000, 2000, N'Success', N'1744704935', CAST(N'2025-04-15T15:16:13.783' AS DateTime))
INSERT [dbo].[Transactions] ([TransactionId], [UserId], [Amount], [Coins], [TransactionStatus], [VnpayTransactionId], [CreatedAt]) VALUES (1030, 6, 5000, 500, N'Success', N'1745305515', CAST(N'2025-04-22T14:06:06.267' AS DateTime))
SET IDENTITY_INSERT [dbo].[Transactions] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (1, N'Adays', N'test@gmail.com', NULL, NULL, NULL, NULL, 0, 976, NULL, 20770000, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (2, N'Aday8', N'test1@gmail.com', NULL, NULL, NULL, N'8.jpeg', 0, 1327, 6, 2202, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (4, N'Aday3', N'test2@gmail.com', N'12345@', CAST(N'2025-02-28T18:09:56.893' AS DateTime), 1, N'74.jpeg', 2, 388, NULL, 614, NULL, 0, NULL, 0, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (5, N'Aday', N'test4@gmail.com', N'AQAAAAIAAYagAAAAEAKdsC6fC5noq+YjSml6k801Xdh3+izE8JfJ2PAXdleASTyxjD5qzkDX+A3h7AjPPw==', CAST(N'2025-03-03T11:11:18.750' AS DateTime), 2, N'tải xuống - 2025-02-20T180226.672.jfif', 36, 782, 13, 125, NULL, 0, NULL, 0, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (6, N'Lylah', N'buitienanh13122003@gmail.com', N'AQAAAAIAAYagAAAAEGfjGFn4MxXXIHNdoWbhmS4elO0L5hfITkIv5Y9ib155LZ0bGhWl6UWz8KyhUJwdtg==', CAST(N'2025-03-04T16:05:41.920' AS DateTime), 3, N'VanTraTrieuHoang.jpg', 25, 1335, 10, 91789, 29, 0, NULL, 0, NULL, 2, 206010, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (7, N'Xuin', N'nguyentaiphat2003@gmail.com', NULL, NULL, NULL, N'11.jpg', 0, 60, 11, 0, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (8, N'HaiDna', N'tranhaidang102@gmail.com', N'12345@', NULL, NULL, N'2.jfif', 0, 90, 11, 0, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (19, N'Lybys112', N'btanh13122003@gmail.com', N'AQAAAAIAAYagAAAAEALUQiYtIpUZPQ2JsNe+48s8XBoUBuSh4rHs689NQFJGa/GDXw3CUTXzIEuiKD14Pw==', CAST(N'2025-03-06T16:27:13.690' AS DateTime), 1, N'3.jpeg', 42, 565, 14, 12181, 40, 0, N'335893', 0, CAST(N'2025-03-26T10:20:10.997' AS DateTime), 0, 3000, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (20, N'Lybys', N'taff03288@gmail.com', N'AQAAAAIAAYagAAAAEMpkpbDLKXkvVfmL9QcD2nMux6yMiIrLuhGJ9bigdToEhzp4iFTzRQ/qhaPPUabCuw==', CAST(N'2025-03-07T14:12:26.887' AS DateTime), 3, N'4.jfif', 24, 788, NULL, 5810, 28, 0, N'514536', 1, CAST(N'2025-03-21T14:35:05.670' AS DateTime), 1, 4000, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (21, N'Luint', N'english13122003@gmail.com', N'AQAAAAIAAYagAAAAENDKz5ZnBcf9++4PTIKWzbcFIPLKnSJQDYXpePyVQwo8nJ3w6LDWK9+Yk4l05bzLNg==', CAST(N'2025-03-17T22:53:05.880' AS DateTime), 1, N'3.jfif', 36, 0, 14, 2320, NULL, NULL, NULL, 1, NULL, 2, 5500, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Email], [Password], [Created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId], [Coins], [CategoryRankId], [ShakeCount], [VerificationCode], [IsEmailVerified], [VerificationCodeExpires], [VipLevel], [TotalRechargedCoins], [ConfirmPassword], [Updated_at]) VALUES (25, N'Nguoidung1', N'nguoidung1@gmail.com', N'AQAAAAIAAYagAAAAEHLw3yDNlP2cs9r533YS2Dm0dgNVdglihwTY0Tu8omh0GLwVXMcefMPp6+AWimbsYA==', CAST(N'2025-05-13T16:36:54.737' AS DateTime), 1, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, 0, N'12345@', NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__admins__AB6E61642427EAFB]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Admins] ADD  CONSTRAINT [UQ__admins__AB6E61642427EAFB] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__admins__F3DBC5722758602E]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Admins] ADD  CONSTRAINT [UQ__admins__F3DBC5722758602E] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [unique_follow]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Followed_stories] ADD  CONSTRAINT [unique_follow] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[StoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__genres__72E12F1B75844B93]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Genres] ADD  CONSTRAINT [UQ__genres__72E12F1B75844B93] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Recharge__9A323593BE6854F3]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[RechargeHistory] ADD  CONSTRAINT [UQ__Recharge__9A323593BE6854F3] UNIQUE NONCLUSTERED 
(
	[MomoTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [unique_story_genre]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Story_genres] ADD  CONSTRAINT [unique_story_genre] UNIQUE NONCLUSTERED 
(
	[story_id] ASC,
	[genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Transact__F672E9732F65629D]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [UQ__Transact__F672E9732F65629D] UNIQUE NONCLUSTERED 
(
	[VnpayTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E6164979432CC]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ__users__AB6E6164979432CC] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__F3DBC57212A6DAF4]    Script Date: 5/17/2025 11:43:35 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ__users__F3DBC57212A6DAF4] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[admin_logs] ADD  CONSTRAINT [DF__admin_log__creat__656C112C]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Admins] ADD  CONSTRAINT [DF__admins__role__3E52440B]  DEFAULT ('moderator') FOR [role]
GO
ALTER TABLE [dbo].[Admins] ADD  CONSTRAINT [DF__admins__created___3F466844]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Banners] ADD  CONSTRAINT [DF__Banners__IsActiv__2C538F61]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Banners] ADD  CONSTRAINT [DF__Banners__Display__2D47B39A]  DEFAULT ((0)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF__chapters__create__44FF419A]  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF__chapters__IsLock__2CF2ADDF]  DEFAULT ((1)) FOR [IsLocked]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF__chapters__Coins__531856C7]  DEFAULT ((0)) FOR [Coins]
GO
ALTER TABLE [dbo].[Chapters] ADD  CONSTRAINT [DF__chapters__IsUnlo__540C7B00]  DEFAULT ((0)) FOR [IsUnlocked]
GO
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF__comments__create__5AEE82B9]  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[ExpHistory] ADD  CONSTRAINT [DF__ExpHistor__Creat__078C1F06]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Favorites] ADD  CONSTRAINT [DF__favorites__added__5070F446]  DEFAULT (getdate()) FOR [added_at]
GO
ALTER TABLE [dbo].[Followed_stories] ADD  CONSTRAINT [DF__followed___follo__6A30C649]  DEFAULT (getdate()) FOR [followed_at]
GO
ALTER TABLE [dbo].[ManagerPermission] ADD  CONSTRAINT [DF__ManagerPe__CanVi__041093DD]  DEFAULT ((0)) FOR [CanView]
GO
ALTER TABLE [dbo].[ManagerPermission] ADD  CONSTRAINT [DF__ManagerPe__CanEd__0504B816]  DEFAULT ((0)) FOR [CanEdit]
GO
ALTER TABLE [dbo].[ManagerPermission] ADD  CONSTRAINT [DF__ManagerPe__CanCr__05F8DC4F]  DEFAULT ((0)) FOR [CanCreate]
GO
ALTER TABLE [dbo].[ManagerPermission] ADD  CONSTRAINT [DF__ManagerPe__CanDe__06ED0088]  DEFAULT ((0)) FOR [CanDelete]
GO
ALTER TABLE [dbo].[ManagerPermission] ADD  CONSTRAINT [DF__ManagerPe__Assig__07E124C1]  DEFAULT (getdate()) FOR [AssignedAt]
GO
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF__Notificat__Creat__20E1DCB5]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF__Notificat__IsRea__21D600EE]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[PurchasedAvatarFrame] ADD  CONSTRAINT [DF__Purchased__Purch__3552E9B6]  DEFAULT (getdate()) FOR [PurchasedAt]
GO
ALTER TABLE [dbo].[PurchasedChapter] ADD  CONSTRAINT [DF__Purchased__Purch__503BEA1C]  DEFAULT (getdate()) FOR [PurchasedAt]
GO
ALTER TABLE [dbo].[Ratings] ADD  CONSTRAINT [DF__ratings__created__60A75C0F]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Reading_history] ADD  CONSTRAINT [DF__reading_h__last___5535A963]  DEFAULT (getdate()) FOR [last_read_at]
GO
ALTER TABLE [dbo].[Reading_history] ADD  CONSTRAINT [DF__reading_h__Start__1CBC4616]  DEFAULT (getdate()) FOR [StartTime]
GO
ALTER TABLE [dbo].[Reading_history] ADD  CONSTRAINT [DF__reading_h__EndTi__1DB06A4F]  DEFAULT (getdate()) FOR [EndTime]
GO
ALTER TABLE [dbo].[RechargeHistory] ADD  CONSTRAINT [DF__RechargeH__Creat__451F3D2B]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Stories] ADD  CONSTRAINT [DF__stories__created__4222D4EF]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Stories] ADD  CONSTRAINT [DF__stories__IsCompl__382F5661]  DEFAULT ((0)) FOR [IsCompleted]
GO
ALTER TABLE [dbo].[Stories] ADD  CONSTRAINT [DF__stories__IsHot__39237A9A]  DEFAULT ((0)) FOR [IsHot]
GO
ALTER TABLE [dbo].[Stories] ADD  CONSTRAINT [DF__stories__IsNew__3A179ED3]  DEFAULT ((1)) FOR [IsNew]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF__Transacti__Creat__6166761E]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__users__created_a__398D8EEE]  DEFAULT (getdate()) FOR [Created_at]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__users__RankId__18EBB532]  DEFAULT ((1)) FOR [RankId]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__users__Level__1AD3FDA4]  DEFAULT ((0)) FOR [Level]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__users__ExpPoints__1EA48E88]  DEFAULT ((0)) FOR [ExpPoints]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__users__Coins__2DE6D218]  DEFAULT ((0)) FOR [Coins]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsEmailVerified]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [VipLevel]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [TotalRechargedCoins]
GO
ALTER TABLE [dbo].[admin_logs]  WITH CHECK ADD  CONSTRAINT [FK__admin_log__admin__66603565] FOREIGN KEY([admin_id])
REFERENCES [dbo].[Admins] ([AdminId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[admin_logs] CHECK CONSTRAINT [FK__admin_log__admin__66603565]
GO
ALTER TABLE [dbo].[Admins]  WITH CHECK ADD  CONSTRAINT [FK_Admins_ManagerId] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[Admins] ([AdminId])
GO
ALTER TABLE [dbo].[Admins] CHECK CONSTRAINT [FK_Admins_ManagerId]
GO
ALTER TABLE [dbo].[Admins]  WITH CHECK ADD  CONSTRAINT [FK_Admins_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Admins] CHECK CONSTRAINT [FK_Admins_Roles]
GO
ALTER TABLE [dbo].[CategoryRank]  WITH CHECK ADD  CONSTRAINT [FK__CategoryR__RankI__7755B73D] FOREIGN KEY([RankId])
REFERENCES [dbo].[Rank] ([RankId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryRank] CHECK CONSTRAINT [FK__CategoryR__RankI__7755B73D]
GO
ALTER TABLE [dbo].[Chapter_images]  WITH CHECK ADD  CONSTRAINT [FK__chapter_i__chapt__6EF57B66] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[Chapters] ([Chapter_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chapter_images] CHECK CONSTRAINT [FK__chapter_i__chapt__6EF57B66]
GO
ALTER TABLE [dbo].[Chapters]  WITH CHECK ADD  CONSTRAINT [FK__chapters__story___45F365D3] FOREIGN KEY([Story_id])
REFERENCES [dbo].[Stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chapters] CHECK CONSTRAINT [FK__chapters__story___45F365D3]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK__comments__Parent__02FC7413] FOREIGN KEY([ParentCommentId])
REFERENCES [dbo].[Comments] ([CommentId])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK__comments__Parent__02FC7413]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK__comments__story___5CD6CB2B] FOREIGN KEY([StoryId])
REFERENCES [dbo].[Stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK__comments__story___5CD6CB2B]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK__comments__user_i__5BE2A6F2] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK__comments__user_i__5BE2A6F2]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Chapters] FOREIGN KEY([chapterId])
REFERENCES [dbo].[Chapters] ([Chapter_id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Chapters]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_comments_Sticker] FOREIGN KEY([StickerId])
REFERENCES [dbo].[Sticker] ([StickerId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_comments_Sticker]
GO
ALTER TABLE [dbo].[ExpHistory]  WITH CHECK ADD  CONSTRAINT [FK__ExpHistor__UserI__0880433F] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExpHistory] CHECK CONSTRAINT [FK__ExpHistor__UserI__0880433F]
GO
ALTER TABLE [dbo].[Favorites]  WITH CHECK ADD  CONSTRAINT [FK__favorites__story__52593CB8] FOREIGN KEY([StoryId])
REFERENCES [dbo].[Stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Favorites] CHECK CONSTRAINT [FK__favorites__story__52593CB8]
GO
ALTER TABLE [dbo].[Favorites]  WITH CHECK ADD  CONSTRAINT [FK__favorites__user___5165187F] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Favorites] CHECK CONSTRAINT [FK__favorites__user___5165187F]
GO
ALTER TABLE [dbo].[Followed_stories]  WITH CHECK ADD  CONSTRAINT [FK__followed___story__6C190EBB] FOREIGN KEY([StoryId])
REFERENCES [dbo].[Stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Followed_stories] CHECK CONSTRAINT [FK__followed___story__6C190EBB]
GO
ALTER TABLE [dbo].[Followed_stories]  WITH CHECK ADD  CONSTRAINT [FK__followed___user___6B24EA82] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Followed_stories] CHECK CONSTRAINT [FK__followed___user___6B24EA82]
GO
ALTER TABLE [dbo].[Followed_stories]  WITH CHECK ADD  CONSTRAINT [FK_followed_stories_LastReadChapter] FOREIGN KEY([LastReadChapterId])
REFERENCES [dbo].[Chapters] ([Chapter_id])
GO
ALTER TABLE [dbo].[Followed_stories] CHECK CONSTRAINT [FK_followed_stories_LastReadChapter]
GO
ALTER TABLE [dbo].[Level]  WITH CHECK ADD  CONSTRAINT [FK__Level__CategoryR__7A3223E8] FOREIGN KEY([CategoryRankId])
REFERENCES [dbo].[CategoryRank] ([CategoryRankId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Level] CHECK CONSTRAINT [FK__Level__CategoryR__7A3223E8]
GO
ALTER TABLE [dbo].[ManagerPermission]  WITH CHECK ADD  CONSTRAINT [FK__ManagerPe__Admin__08D548FA] FOREIGN KEY([AdminId])
REFERENCES [dbo].[Admins] ([AdminId])
GO
ALTER TABLE [dbo].[ManagerPermission] CHECK CONSTRAINT [FK__ManagerPe__Admin__08D548FA]
GO
ALTER TABLE [dbo].[ManagerPermission]  WITH CHECK ADD  CONSTRAINT [FK__ManagerPe__Assig__09C96D33] FOREIGN KEY([AssignedBy])
REFERENCES [dbo].[Admins] ([AdminId])
GO
ALTER TABLE [dbo].[ManagerPermission] CHECK CONSTRAINT [FK__ManagerPe__Assig__09C96D33]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Comments] FOREIGN KEY([CommentId])
REFERENCES [dbo].[Comments] ([CommentId])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Comments]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Users]
GO
ALTER TABLE [dbo].[PurchasedAvatarFrame]  WITH CHECK ADD  CONSTRAINT [FK_PurchasedAvatarFrame_AvatarFrame] FOREIGN KEY([AvatarFrameId])
REFERENCES [dbo].[AvatarFrame] ([AvatarFrameId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PurchasedAvatarFrame] CHECK CONSTRAINT [FK_PurchasedAvatarFrame_AvatarFrame]
GO
ALTER TABLE [dbo].[PurchasedAvatarFrame]  WITH CHECK ADD  CONSTRAINT [FK_PurchasedAvatarFrame_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PurchasedAvatarFrame] CHECK CONSTRAINT [FK_PurchasedAvatarFrame_Users]
GO
ALTER TABLE [dbo].[PurchasedChapter]  WITH CHECK ADD  CONSTRAINT [FK_PurchasedChapter_Chapter] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[Chapters] ([Chapter_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PurchasedChapter] CHECK CONSTRAINT [FK_PurchasedChapter_Chapter]
GO
ALTER TABLE [dbo].[PurchasedChapter]  WITH CHECK ADD  CONSTRAINT [FK_PurchasedChapter_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PurchasedChapter] CHECK CONSTRAINT [FK_PurchasedChapter_User]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [FK__ratings__story_i__628FA481] FOREIGN KEY([story_id])
REFERENCES [dbo].[Stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [FK__ratings__story_i__628FA481]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [FK__ratings__user_id__619B8048] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [FK__ratings__user_id__619B8048]
GO
ALTER TABLE [dbo].[Reading_history]  WITH CHECK ADD  CONSTRAINT [FK__reading_h__chapt__5812160E] FOREIGN KEY([chapter_id])
REFERENCES [dbo].[Chapters] ([Chapter_id])
GO
ALTER TABLE [dbo].[Reading_history] CHECK CONSTRAINT [FK__reading_h__chapt__5812160E]
GO
ALTER TABLE [dbo].[Reading_history]  WITH CHECK ADD  CONSTRAINT [FK__reading_h__story__571DF1D5] FOREIGN KEY([story_id])
REFERENCES [dbo].[Stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reading_history] CHECK CONSTRAINT [FK__reading_h__story__571DF1D5]
GO
ALTER TABLE [dbo].[Reading_history]  WITH CHECK ADD  CONSTRAINT [FK__reading_h__user___5629CD9C] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reading_history] CHECK CONSTRAINT [FK__reading_h__user___5629CD9C]
GO
ALTER TABLE [dbo].[RechargeHistory]  WITH CHECK ADD  CONSTRAINT [FK_RechargeHistory_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RechargeHistory] CHECK CONSTRAINT [FK_RechargeHistory_User]
GO
ALTER TABLE [dbo].[Story_genres]  WITH CHECK ADD  CONSTRAINT [FK__story_gen__genre__4D94879B] FOREIGN KEY([genre_id])
REFERENCES [dbo].[Genres] ([Genre_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Story_genres] CHECK CONSTRAINT [FK__story_gen__genre__4D94879B]
GO
ALTER TABLE [dbo].[Story_genres]  WITH CHECK ADD  CONSTRAINT [FK__story_gen__story__4CA06362] FOREIGN KEY([story_id])
REFERENCES [dbo].[Stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Story_genres] CHECK CONSTRAINT [FK__story_gen__story__4CA06362]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK__Transacti__UserI__625A9A57] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK__Transacti__UserI__625A9A57]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_User_AvatarFrame] FOREIGN KEY([AvatarFrameId])
REFERENCES [dbo].[AvatarFrame] ([AvatarFrameId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_User_AvatarFrame]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_users_CategoryRank] FOREIGN KEY([CategoryRankId])
REFERENCES [dbo].[CategoryRank] ([CategoryRankId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_users_CategoryRank]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_users_Rank] FOREIGN KEY([RankId])
REFERENCES [dbo].[Rank] ([RankId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_users_Rank]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [CK__ratings__rating__5FB337D6] CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [CK__ratings__rating__5FB337D6]
GO
ALTER TABLE [dbo].[RechargeHistory]  WITH CHECK ADD  CONSTRAINT [CK__RechargeH__Statu__442B18F2] CHECK  (([Status]='Failed' OR [Status]='Completed' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[RechargeHistory] CHECK CONSTRAINT [CK__RechargeH__Statu__442B18F2]
GO
