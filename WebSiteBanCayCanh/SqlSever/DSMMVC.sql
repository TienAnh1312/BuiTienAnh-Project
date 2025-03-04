USE [WebManga]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2/18/2025 3:32:54 PM ******/
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
/****** Object:  Table [dbo].[admin_logs]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin_logs](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[admin_id] [int] NOT NULL,
	[action] [nvarchar](255) NOT NULL,
	[target_id] [int] NULL,
	[target_table] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admins]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admins](
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[role] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AvatarFrame]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvatarFrame](
	[AvatarFrameId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[ImagePath] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AvatarFrameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chapter_images]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chapter_images](
	[image_id] [int] IDENTITY(1,1) NOT NULL,
	[chapter_id] [int] NOT NULL,
	[image_url] [nvarchar](255) NOT NULL,
	[page_number] [int] NOT NULL,
	[StoryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chapters]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chapters](
	[chapter_id] [int] IDENTITY(1,1) NOT NULL,
	[story_id] [int] NOT NULL,
	[chapter_title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[chapter_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comments]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comments](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[story_id] [int] NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NULL,
	[ParentCommentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[favorites]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[favorites](
	[favorite_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[story_id] [int] NOT NULL,
	[added_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[favorite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[followed_stories]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[followed_stories](
	[follow_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[story_id] [int] NOT NULL,
	[followed_at] [datetime] NULL,
	[LastReadChapterId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[follow_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[genres]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[genres](
	[genre_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RankCategories]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RankCategories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ranks]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ranks](
	[RankId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[MinExp] [float] NOT NULL,
	[CategoryId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ratings]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ratings](
	[rating_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[story_id] [int] NOT NULL,
	[rating] [tinyint] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[rating_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reading_history]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reading_history](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[story_id] [int] NOT NULL,
	[chapter_id] [int] NOT NULL,
	[last_read_at] [datetime] NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stories]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stories](
	[story_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[author] [nvarchar](100) NULL,
	[description] [nvarchar](max) NULL,
	[cover_image] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[story_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[story_genres]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[story_genres](
	[story_genre_id] [int] IDENTITY(1,1) NOT NULL,
	[story_id] [int] NOT NULL,
	[genre_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[story_genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2/18/2025 3:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NULL,
	[RankId] [int] NULL,
	[Avatar] [nvarchar](255) NULL,
	[Level] [float] NOT NULL,
	[ExpPoints] [float] NULL,
	[AvatarFrameId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[admins] ON 

INSERT [dbo].[admins] ([admin_id], [username], [email], [password], [role], [created_at]) VALUES (1, N'Admin', N'admin@gmail.com', N'12345@', N'1', CAST(N'2025-01-20T21:21:43.630' AS DateTime))
INSERT [dbo].[admins] ([admin_id], [username], [email], [password], [role], [created_at]) VALUES (3, N'Bùi Tiến Anh', N'buitienanh13122003@gmail.com', N'12345@', N'1', CAST(N'2025-01-20T21:22:10.070' AS DateTime))
SET IDENTITY_INSERT [dbo].[admins] OFF
GO
SET IDENTITY_INSERT [dbo].[chapter_images] ON 

INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (4, 1, N'images/admins/stories/0.jpg', 0, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (5, 1, N'images/admins/cpimages/1.jpg', 1, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (6, 1, N'images/admins/cpimages/2.jpg', 2, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (7, 1, N'images/admins/cpimages/3.jpg', 3, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (8, 1, N'images/admins/cpimages/4.jpg', 4, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (9, 1, N'images/admins/cpimages/5.jpg', 5, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (10, 1, N'images/admins/cpimages/6.jpg', 6, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (11, 1, N'images/admins/cpimages/7.jpg', 7, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (12, 1, N'images/admins/cpimages/8.jpg', 8, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (13, 1, N'images/admins/cpimages/9.jpg', 9, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (14, 1, N'images/admins/cpimages/10.jpg', 10, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (15, 1, N'images/admins/cpimages/11.jpg', 11, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (16, 1, N'images/admins/cpimages/12.jpg', 12, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (17, 1, N'images/admins/cpimages/13.jpg', 13, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (18, 1, N'images/admins/cpimages/14.jpg', 14, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (19, 1, N'images/admins/cpimages/15.jpg', 15, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (20, 1, N'images/admins/cpimages/16.jpg', 16, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (21, 1, N'images/admins/cpimages/17.jpg', 17, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (22, 1, N'images/admins/cpimages/18.jpg', 18, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (23, 1, N'images/admins/cpimages/19.jpg', 19, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (24, 1, N'images/admins/cpimages/20.jpg', 20, NULL)
INSERT [dbo].[chapter_images] ([image_id], [chapter_id], [image_url], [page_number], [StoryId]) VALUES (25, 1, N'images/admins/cpimages/21.jpg', 21, NULL)
SET IDENTITY_INSERT [dbo].[chapter_images] OFF
GO
SET IDENTITY_INSERT [dbo].[chapters] ON 

INSERT [dbo].[chapters] ([chapter_id], [story_id], [chapter_title], [content], [created_at]) VALUES (1, 1, N'Chương 1 - Bản chất của chuyển sinh', N'Bản chất của chuyển sinh', CAST(N'2025-01-20T21:50:02.060' AS DateTime))
INSERT [dbo].[chapters] ([chapter_id], [story_id], [chapter_title], [content], [created_at]) VALUES (2, 1, N'Chương 2 - Bản chất của chuyển sinh', N'Bản chất của chuyển sinh', CAST(N'2025-01-20T22:05:20.907' AS DateTime))
INSERT [dbo].[chapters] ([chapter_id], [story_id], [chapter_title], [content], [created_at]) VALUES (3, 2, N'Chương 1 - Chưởng Môn Khiêm Tốn Chút', N'Chưởng Môn Khiêm Tốn Chút', CAST(N'2025-01-20T22:08:40.520' AS DateTime))
INSERT [dbo].[chapters] ([chapter_id], [story_id], [chapter_title], [content], [created_at]) VALUES (4, 1, N'Chương 3 - Bản chất của chuyển sinh', N'Bản chất của chuyển sinh', CAST(N'2025-01-20T22:43:12.053' AS DateTime))
INSERT [dbo].[chapters] ([chapter_id], [story_id], [chapter_title], [content], [created_at]) VALUES (5, 3, N'Chương 1 - Cửu thiên kiếm pháp', N'Cửu thiên kiếm pháp', CAST(N'2025-01-22T00:08:12.970' AS DateTime))
INSERT [dbo].[chapters] ([chapter_id], [story_id], [chapter_title], [content], [created_at]) VALUES (6, 3, N'Chương 2 - Cửu thiên kiếm pháp', N'Cửu thiên kiếm pháp', CAST(N'2025-01-22T01:51:47.667' AS DateTime))
INSERT [dbo].[chapters] ([chapter_id], [story_id], [chapter_title], [content], [created_at]) VALUES (8, 1, N'Chương 4', N'Bản chất của chuyển sinh', CAST(N'2025-02-13T17:33:27.743' AS DateTime))
SET IDENTITY_INSERT [dbo].[chapters] OFF
GO
SET IDENTITY_INSERT [dbo].[comments] ON 

INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (1, 1, 1, N'hello', CAST(N'2025-01-22T02:16:12.773' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (2, 2, 1, N'truyện hay không nhỉ?
', CAST(N'2025-01-22T02:17:46.303' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (3, 1, 1, N'không
', CAST(N'2025-01-22T12:17:41.787' AS DateTime), 2)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (4, 1, 1, N'k hay ', CAST(N'2025-01-22T12:17:59.470' AS DateTime), 1)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (5, 1, 1, N'thật?', CAST(N'2025-01-22T12:19:15.010' AS DateTime), 4)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (6, 1, 1, N'chào', CAST(N'2025-01-22T12:20:57.573' AS DateTime), 1)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (7, 1, 2, N'truyện hay không nhỉ', CAST(N'2025-01-22T12:22:50.010' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (8, 2, 2, N'không nhé', CAST(N'2025-01-22T12:23:10.580' AS DateTime), 7)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (9, 1, 2, N'không', CAST(N'2025-01-22T12:26:08.153' AS DateTime), 7)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (10, 1, 2, N'hello', CAST(N'2025-01-22T12:30:05.350' AS DateTime), 7)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (11, 1, 1, N'hay lắm ạ', CAST(N'2025-01-22T12:38:20.447' AS DateTime), 2)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (12, 1, 1, N'cc', CAST(N'2025-01-22T12:39:22.247' AS DateTime), 3)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (13, 1, 1, N'cc', CAST(N'2025-01-22T12:39:29.010' AS DateTime), 3)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (14, 1, 1, N'thật ?', CAST(N'2025-01-22T12:42:52.163' AS DateTime), 3)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (15, 1, 1, N'c', CAST(N'2025-01-22T12:43:01.310' AS DateTime), 11)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (16, 1, 1, N'hihi', CAST(N'2025-01-22T12:43:06.837' AS DateTime), 2)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (17, 1, 1, N'c', CAST(N'2025-01-22T12:43:14.503' AS DateTime), 16)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (18, 1, 1, N'cc', CAST(N'2025-01-22T12:46:39.287' AS DateTime), 3)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (19, 1, 1, N'bb', CAST(N'2025-01-22T12:50:12.050' AS DateTime), 3)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (20, 1, 1, N'cc', CAST(N'2025-01-22T12:55:21.807' AS DateTime), 2)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (21, 1, 1, N'uh', CAST(N'2025-01-22T12:55:47.037' AS DateTime), 1)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (22, 1, 1, N'mm', CAST(N'2025-01-22T13:02:33.617' AS DateTime), 2)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (23, 1, 2, N'hi', CAST(N'2025-01-22T13:08:24.857' AS DateTime), 7)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (24, 1, 2, N'ok', CAST(N'2025-01-22T13:08:32.740' AS DateTime), 7)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (25, 1, 1, N'c', CAST(N'2025-01-22T13:13:15.473' AS DateTime), 16)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (26, 1, 1, N'c2', CAST(N'2025-01-22T13:13:26.177' AS DateTime), 16)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (27, 1, 3, N'hello', CAST(N'2025-01-22T13:14:44.733' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (28, 1, 3, N'hello1', CAST(N'2025-01-22T13:15:10.517' AS DateTime), 27)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (29, 1, 3, N'hello2', CAST(N'2025-01-22T13:15:17.823' AS DateTime), 27)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (30, 1, 1, N'uh', CAST(N'2025-02-13T14:26:48.283' AS DateTime), 3)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (31, 1, 1, N'nn', CAST(N'2025-02-13T18:59:02.500' AS DateTime), 2)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (32, 1, 1, N'adasdas', CAST(N'2025-02-13T19:04:30.387' AS DateTime), 3)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (33, 1, 1, N'hello 2/14/2025
', CAST(N'2025-02-14T23:13:48.170' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (34, 1, 1, N'hello c2', CAST(N'2025-02-14T23:14:06.940' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (35, 1, 1, N'hello c3', CAST(N'2025-02-14T23:14:14.830' AS DateTime), 34)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (36, 1, 1, N'hello c4', CAST(N'2025-02-14T23:16:41.463' AS DateTime), 35)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (37, 1, 1, N'helloc4', CAST(N'2025-02-14T23:17:48.733' AS DateTime), 34)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (38, 1, 1, N'@Aday1 hello', CAST(N'2025-02-14T23:59:27.413' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (39, 1, 1, N'@Aday1 cc', CAST(N'2025-02-14T23:59:46.573' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (40, 2, 1, N'@Aday1 gg', CAST(N'2025-02-15T00:00:09.857' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (41, 1, 1, N'@Aday1 uh', CAST(N'2025-02-15T00:02:41.747' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (42, 2, 1, N'@Aday1 hello 1', CAST(N'2025-02-15T00:05:04.340' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (43, 1, 1, N'@undefined gg', CAST(N'2025-02-15T00:06:15.517' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (44, 2, 1, N'hello', CAST(N'2025-02-15T00:07:14.357' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (45, 2, 1, N'1', CAST(N'2025-02-15T00:08:06.260' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (46, 2, 1, N'2', CAST(N'2025-02-15T00:08:09.540' AS DateTime), 45)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (47, 2, 1, N'3', CAST(N'2025-02-15T00:08:12.820' AS DateTime), 45)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (48, 2, 1, N'4', CAST(N'2025-02-15T00:08:22.103' AS DateTime), 45)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (49, 2, 1, N'3', CAST(N'2025-02-15T00:09:17.517' AS DateTime), 45)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (50, 2, 1, N'1', CAST(N'2025-02-15T00:10:45.940' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (51, 2, 1, N'2', CAST(N'2025-02-15T00:10:48.727' AS DateTime), 50)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (52, 2, 1, N'3', CAST(N'2025-02-15T00:10:51.897' AS DateTime), 50)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (53, 1, 2, N'1', CAST(N'2025-02-15T00:12:24.290' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (54, 1, 2, N'2', CAST(N'2025-02-15T00:12:27.913' AS DateTime), 53)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (55, 1, 2, N'3', CAST(N'2025-02-15T00:12:30.783' AS DateTime), 53)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (56, 1, 2, N'4', CAST(N'2025-02-15T00:13:07.830' AS DateTime), 53)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (57, 1, 3, N'1', CAST(N'2025-02-15T00:14:38.367' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (58, 1, 3, N'2', CAST(N'2025-02-15T00:14:41.140' AS DateTime), 57)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (59, 1, 3, N'3', CAST(N'2025-02-15T00:14:44.177' AS DateTime), 57)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (60, 1, 4, N'1', CAST(N'2025-02-15T00:16:25.830' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (61, 1, 4, N'2', CAST(N'2025-02-15T00:16:27.913' AS DateTime), 60)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (62, 1, 4, N'3', CAST(N'2025-02-15T00:16:31.710' AS DateTime), 60)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (63, 1, 4, N'1', CAST(N'2025-02-15T00:16:37.990' AS DateTime), 60)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (64, 1, 4, N'1', CAST(N'2025-02-15T00:27:01.913' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (65, 1, 4, N'2', CAST(N'2025-02-15T00:27:04.210' AS DateTime), 64)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (66, 1, 4, N'3', CAST(N'2025-02-15T00:27:06.323' AS DateTime), 64)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (67, 1, 3, N'1', CAST(N'2025-02-15T00:29:16.997' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (68, 1, 3, N'2', CAST(N'2025-02-15T00:29:19.513' AS DateTime), 67)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (69, 1, 3, N'3', CAST(N'2025-02-15T00:29:22.493' AS DateTime), 67)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (70, 1, 6, N'1', CAST(N'2025-02-15T00:41:18.230' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (71, 1, 6, N'2', CAST(N'2025-02-15T00:41:20.543' AS DateTime), 70)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (72, 1, 6, N'3', CAST(N'2025-02-15T00:41:22.863' AS DateTime), 71)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (73, 1, 6, N'4', CAST(N'2025-02-15T00:41:29.713' AS DateTime), 72)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (74, 1, 6, N'4', CAST(N'2025-02-15T00:41:33.900' AS DateTime), 72)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (75, 1, 6, N'4', CAST(N'2025-02-15T00:45:05.290' AS DateTime), 72)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (76, 1, 6, N'3', CAST(N'2025-02-15T00:45:10.837' AS DateTime), 71)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (77, 1, 6, N'1', CAST(N'2025-02-15T00:47:24.060' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (78, 1, 6, N'2', CAST(N'2025-02-15T00:47:26.257' AS DateTime), 77)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (79, 1, 6, N'3', CAST(N'2025-02-15T00:47:28.740' AS DateTime), 78)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (80, 1, 6, N'4', CAST(N'2025-02-15T00:47:31.417' AS DateTime), 79)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (81, 1, 4, N'1', CAST(N'2025-02-15T00:49:05.860' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (82, 1, 4, N'2', CAST(N'2025-02-15T00:49:08.480' AS DateTime), 81)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (83, 1, 4, N'3', CAST(N'2025-02-15T00:49:11.250' AS DateTime), 81)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (84, 2, 1, N'3', CAST(N'2025-02-15T00:51:13.933' AS DateTime), 50)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (85, 2, 1, N'3', CAST(N'2025-02-15T00:51:28.933' AS DateTime), 33)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (86, 1, 1, N'1', CAST(N'2025-02-15T16:46:27.020' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (87, 1, 1, N'2', CAST(N'2025-02-15T16:46:29.980' AS DateTime), 86)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (88, 1, 1, N'3', CAST(N'2025-02-15T16:46:33.240' AS DateTime), 86)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (89, 2, 6, N'1', CAST(N'2025-02-15T16:48:14.530' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (90, 2, 6, N'2', CAST(N'2025-02-15T16:48:17.250' AS DateTime), 89)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (91, 2, 6, N'3', CAST(N'2025-02-15T16:48:19.410' AS DateTime), 89)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (92, 1, 5, N'hello', CAST(N'2025-02-15T16:52:33.137' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (93, 1, 5, N'@Aday1 uh', CAST(N'2025-02-15T16:52:46.043' AS DateTime), 92)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (94, 1, 5, N'hello', CAST(N'2025-02-15T16:58:13.017' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (95, 1, 5, N'1', CAST(N'2025-02-15T17:00:32.557' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (96, 1, 5, N'hh', CAST(N'2025-02-15T17:02:08.457' AS DateTime), 95)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (97, 1, 5, N'1', CAST(N'2025-02-15T17:09:30.120' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (98, 1, 2, N'cap', CAST(N'2025-02-15T17:09:58.607' AS DateTime), 7)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (99, 1, 4, N'1', CAST(N'2025-02-15T17:12:50.270' AS DateTime), NULL)
GO
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (100, 2, 5, N'22', CAST(N'2025-02-15T17:13:13.783' AS DateTime), 97)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (101, 2, 5, N'33', CAST(N'2025-02-15T17:13:20.813' AS DateTime), 100)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (102, 2, 5, N'33', CAST(N'2025-02-15T17:13:29.510' AS DateTime), 100)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (103, 2, 5, N'@Aday2 4', CAST(N'2025-02-15T17:14:29.320' AS DateTime), 97)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (104, 2, 3, N'1', CAST(N'2025-02-15T17:17:44.097' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (105, 1, 1, N'1', CAST(N'2025-02-15T17:37:28.327' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (106, 1, 1, N'@Aday1 2', CAST(N'2025-02-15T17:37:31.530' AS DateTime), 105)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (107, 1, 2, N'@Aday1 jj', CAST(N'2025-02-15T17:38:51.933' AS DateTime), 53)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (108, 1, 2, N'@Aday1 không
', CAST(N'2025-02-15T17:40:14.270' AS DateTime), 53)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (109, 1, 2, N'@Aday2 @Aday2 n', CAST(N'2025-02-15T17:45:27.603' AS DateTime), 8)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (110, 1, 1, N'@Aday1 kk', CAST(N'2025-02-15T17:50:17.073' AS DateTime), 105)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (111, 1, 1, N'1', CAST(N'2025-02-15T17:54:31.850' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (112, 1, 1, N'@Aday1 2', CAST(N'2025-02-15T17:54:34.760' AS DateTime), 111)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (113, 1, 1, N'@Aday1 3', CAST(N'2025-02-15T17:54:41.547' AS DateTime), 111)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (114, 1, 1, N'ok', CAST(N'2025-02-17T15:06:52.447' AS DateTime), NULL)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (115, 1, 1, N'@Adays ok', CAST(N'2025-02-17T15:37:47.673' AS DateTime), 114)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (116, 1, 1, N'@Adays 111', CAST(N'2025-02-17T15:45:10.863' AS DateTime), 114)
INSERT [dbo].[comments] ([comment_id], [user_id], [story_id], [content], [created_at], [ParentCommentId]) VALUES (117, 1, 3, N'@Aday2 1', CAST(N'2025-02-17T16:57:46.917' AS DateTime), 104)
SET IDENTITY_INSERT [dbo].[comments] OFF
GO
SET IDENTITY_INSERT [dbo].[favorites] ON 

INSERT [dbo].[favorites] ([favorite_id], [user_id], [story_id], [added_at]) VALUES (10, 1, 3, CAST(N'2025-01-22T01:51:59.873' AS DateTime))
INSERT [dbo].[favorites] ([favorite_id], [user_id], [story_id], [added_at]) VALUES (11, 1, 1, CAST(N'2025-02-13T14:10:53.073' AS DateTime))
INSERT [dbo].[favorites] ([favorite_id], [user_id], [story_id], [added_at]) VALUES (12, 2, 1, CAST(N'2025-02-14T15:42:32.770' AS DateTime))
INSERT [dbo].[favorites] ([favorite_id], [user_id], [story_id], [added_at]) VALUES (13, 1, 2, CAST(N'2025-02-15T17:52:15.730' AS DateTime))
SET IDENTITY_INSERT [dbo].[favorites] OFF
GO
SET IDENTITY_INSERT [dbo].[followed_stories] ON 

INSERT [dbo].[followed_stories] ([follow_id], [user_id], [story_id], [followed_at], [LastReadChapterId]) VALUES (1, 1, 1, CAST(N'2025-01-22T01:27:41.503' AS DateTime), 1)
INSERT [dbo].[followed_stories] ([follow_id], [user_id], [story_id], [followed_at], [LastReadChapterId]) VALUES (2, 1, 3, CAST(N'2025-01-22T13:18:45.203' AS DateTime), 5)
INSERT [dbo].[followed_stories] ([follow_id], [user_id], [story_id], [followed_at], [LastReadChapterId]) VALUES (3, 2, 1, CAST(N'2025-02-14T15:42:38.217' AS DateTime), 8)
SET IDENTITY_INSERT [dbo].[followed_stories] OFF
GO
SET IDENTITY_INSERT [dbo].[genres] ON 

INSERT [dbo].[genres] ([genre_id], [name]) VALUES (6, N'Học Đường')
INSERT [dbo].[genres] ([genre_id], [name]) VALUES (7, N'Isekai')
INSERT [dbo].[genres] ([genre_id], [name]) VALUES (4, N'Manga')
INSERT [dbo].[genres] ([genre_id], [name]) VALUES (5, N'Manhua')
INSERT [dbo].[genres] ([genre_id], [name]) VALUES (1, N'Ngôn Tình')
INSERT [dbo].[genres] ([genre_id], [name]) VALUES (3, N'Siêu Nhiên')
INSERT [dbo].[genres] ([genre_id], [name]) VALUES (2, N'Thể Thao')
SET IDENTITY_INSERT [dbo].[genres] OFF
GO
SET IDENTITY_INSERT [dbo].[RankCategories] ON 

INSERT [dbo].[RankCategories] ([CategoryId], [Name]) VALUES (1, N'Tu Tiên')
INSERT [dbo].[RankCategories] ([CategoryId], [Name]) VALUES (2, N'Tu Ma')
SET IDENTITY_INSERT [dbo].[RankCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Ranks] ON 

INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (3, N'Luy?n Khí', 100, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (4, N'Trúc Co', 500, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (5, N'Kim Ðan', 1500, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (6, N'Nguyên Anh', 3000, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (7, N'Hóa Th?n', 6000, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (8, N'Ð? Ki?p', 12000, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (9, N'Ð?i Th?a', 25000, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (10, N'Tiên Nhân', 50000, 1)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (11, N'Ma Khí', 100, 2)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (12, N'Ma Tu?ng', 500, 2)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (13, N'Ma Vuong', 1500, 2)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (14, N'Ma Ð?', 3000, 2)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (15, N'Ma Th?n', 6000, 2)
INSERT [dbo].[Ranks] ([RankId], [Name], [MinExp], [CategoryId]) VALUES (16, N'Thiên Ma', 12000, 2)
SET IDENTITY_INSERT [dbo].[Ranks] OFF
GO
SET IDENTITY_INSERT [dbo].[reading_history] ON 

INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (1, 1, 1, 1, CAST(N'2025-01-21T23:51:14.733' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (2, 1, 1, 2, CAST(N'2025-01-21T23:51:27.893' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (3, 1, 2, 3, CAST(N'2025-01-21T23:59:35.493' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (4, 1, 1, 4, CAST(N'2025-01-22T00:01:08.987' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (5, 1, 3, 5, CAST(N'2025-01-22T00:08:21.223' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (6, 1, 3, 6, CAST(N'2025-01-22T02:04:27.467' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (7, 2, 1, 1, CAST(N'2025-02-13T14:44:00.630' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (8, 2, 1, 2, CAST(N'2025-02-13T14:44:07.140' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (9, 1, 1, 8, CAST(N'2025-02-13T18:44:37.423' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (10, 2, 1, 4, CAST(N'2025-02-14T15:42:23.660' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
INSERT [dbo].[reading_history] ([history_id], [user_id], [story_id], [chapter_id], [last_read_at], [StartTime], [EndTime]) VALUES (11, 2, 1, 8, CAST(N'2025-02-15T00:51:21.537' AS DateTime), CAST(N'2025-02-17T14:46:39.710' AS DateTime), CAST(N'2025-02-17T14:46:39.713' AS DateTime))
SET IDENTITY_INSERT [dbo].[reading_history] OFF
GO
SET IDENTITY_INSERT [dbo].[stories] ON 

INSERT [dbo].[stories] ([story_id], [title], [author], [description], [cover_image], [created_at]) VALUES (1, N'Bản Chất Của Chuyển Sinh', N'Đang cập nhật', N'Gia tộc võ thuật vĩ đại nhất, Samion. Dayven, một thành viên của gia đình Samion, là một võ sĩ. Bất chấp sự chế giễu và khinh miệt vì chỉ có một cánh tay trái, anh đã vượt qua dòng dõi của gia đình Samion như một thiên tài. Tuy nhiên, cuối cùng anh lại bị gia đình và cha mẹ phản bội, kết cục không mấy tốt đẹp. Nhưng,anh ấy đã được đầu thai. "Tôi có một cánh tay phải?" Anh ấy có một gia đình mới. Một cơ thể có năng khiếu bẩm sinh. Kinh nghiệm từ cuộc sống quá khứ của mình. Và cả thần Yulion với anh ta nữa. Sau khi tái sinh, mọi thứ đã thay đổi, và một cuộc phiêu lưu mới bắt đầu.', N'images/admins/stories/BanChatCuaChuyenSinh.jfif', CAST(N'2025-02-14T16:27:00.783' AS DateTime))
INSERT [dbo].[stories] ([story_id], [title], [author], [description], [cover_image], [created_at]) VALUES (2, N'Chưởng Môn Khiêm Tốn Chút', N'Đang cập nhật', N'Xuyên không tới Thiên Huyền Giới, thân phận là chưởng môn dởm của Mạc môn, Đô Thành Khắc Kim tái sinh ở trong thế giới trò chơi, không để người chơi vào mắt, thu nhận nhân vật chính của thế giới này làm tiểu đệ, giả dạng làm thiên hạ đệ nhất!', N'images/admins/stories/ChuongMonKhiemTonChut.jfif', CAST(N'2025-01-20T21:47:42.263' AS DateTime))
INSERT [dbo].[stories] ([story_id], [title], [author], [description], [cover_image], [created_at]) VALUES (3, N'Cửu Thiên Kiếm Pháp', N'Đang cập nhật', N'"Ông ấy là chủ nhân của Cửu Thiên." Yeon Jeokha là con của một người vợ lẽ. Bị vợ của cha mình và các anh chị em của mình bắt nạt một cách tàn nhẫn, anh ta sau đó bị giam trong nhà kho sau khi cha anh ta qua đời vì bệnh tật… Đã mười năm kể từ khi anh ta trốn thoát sau khi anh ta học được môn võ thuật vượt ra ngoài thế giới. Cuộc phiêu lưu không thể ngăn cản của người kế thừa duy nhất của Cửu Thiên, Yeon Jeokha, bắt đầu ngay bây giờ!', N'images/admins/stories/CuuThienKiemPhap.jfif', CAST(N'2025-01-20T21:48:17.170' AS DateTime))
INSERT [dbo].[stories] ([story_id], [title], [author], [description], [cover_image], [created_at]) VALUES (4, N'Thiên Tài Đoản Mệnh', N'Đang cập nhật', N'Định mệnh an bài cho Trịnh Liên Thần một số phận đoản mệnh, "không sống quá tuổi hai mươi". Cả gia tộc hắt hủi, khinh miệt hắn, nhưng hắn vẫn kiên trì tự sáng tạo võ công, đạt đến cảnh giới xuất thần nhập hóa. Một ngày nọ, Liên Thần phát hiện sinh mệnh mình chẳng còn bao lâu… Cuộc chiến sinh tồn của thiên tài đoản mệnh, Trịnh Liên Thần, giờ đây mới chính thức bắt đầu!', N'images/admins/stories/ThienTaiDoanMenh.jfif', CAST(N'2025-01-20T21:48:50.890' AS DateTime))
INSERT [dbo].[stories] ([story_id], [title], [author], [description], [cover_image], [created_at]) VALUES (5, N'Tinh Tú Kiếm Sĩ', N'Đang cập nhật', N'Vlad là một cậu bé nghèo khổ lang thang trong khu ổ chuột nhưng vẫn luôn không ngừng ngưỡng mộ các hiệp sĩ. Sau khi bị tia sét đen bất ngờ đánh trúng, cậu bắt đầu nghe thấy một giọng nói bí ẩn. Vào cái ngày định mệnh ấy, một hiệp sĩ xuất hiện dưới ánh trăng xanh huyền ảo đã xáo trộn cuộc sống trong con hẻm nghèo của Vlad. Chính sự kiện này đã chứng minh rằng ngay cả một ngôi sao khuất bóng sau những mịt mờ đen tối nhất của màn đêm vẫn có thể tỏa sáng rực rỡ nếu nó thực sự khao khát được tỏa sáng.', N'images/admins/stories/TinhTuKiemSi.jfif', CAST(N'2025-01-20T21:49:32.390' AS DateTime))
INSERT [dbo].[stories] ([story_id], [title], [author], [description], [cover_image], [created_at]) VALUES (6, N'Vinh Quang Vô Tận', N'Đang cập nhật', N'Halo, nhạc sĩ giỏi nhất thời bấy giờ, gặp tai nạn giao thông trên đường tới lễ trao giải Grammy. và khi anh ấy tỉnh lại, anh thấy mình trong cơ thể của một cậu bé người Hàn Quốc tên No Hae-il. Anh ấy thấy mình trong thế giới hoàn toàn khác', N'images/admins/stories/VinhQuangVoTan.jfif', CAST(N'2025-01-20T21:49:47.507' AS DateTime))
SET IDENTITY_INSERT [dbo].[stories] OFF
GO
SET IDENTITY_INSERT [dbo].[story_genres] ON 

INSERT [dbo].[story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (28, 1, 1)
INSERT [dbo].[story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (29, 1, 3)
INSERT [dbo].[story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (27, 1, 4)
INSERT [dbo].[story_genres] ([story_genre_id], [story_id], [genre_id]) VALUES (2, 2, 3)
SET IDENTITY_INSERT [dbo].[story_genres] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [username], [email], [password], [created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId]) VALUES (1, N'Adays', N'test@gmail.com', N'12345@', CAST(N'2025-01-21T18:55:14.183' AS DateTime), NULL, N'BanChatCuaChuyenSinh.jfif', 0, NULL, NULL)
INSERT [dbo].[users] ([user_id], [username], [email], [password], [created_at], [RankId], [Avatar], [Level], [ExpPoints], [AvatarFrameId]) VALUES (2, N'Aday2', N'test1@gmail.com', N'12345@', CAST(N'2025-01-22T02:17:11.680' AS DateTime), NULL, NULL, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__admins__AB6E61642427EAFB]    Script Date: 2/18/2025 3:32:55 PM ******/
ALTER TABLE [dbo].[admins] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__admins__F3DBC5722758602E]    Script Date: 2/18/2025 3:32:55 PM ******/
ALTER TABLE [dbo].[admins] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [unique_follow]    Script Date: 2/18/2025 3:32:55 PM ******/
ALTER TABLE [dbo].[followed_stories] ADD  CONSTRAINT [unique_follow] UNIQUE NONCLUSTERED 
(
	[user_id] ASC,
	[story_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__genres__72E12F1B75844B93]    Script Date: 2/18/2025 3:32:55 PM ******/
ALTER TABLE [dbo].[genres] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [unique_story_genre]    Script Date: 2/18/2025 3:32:55 PM ******/
ALTER TABLE [dbo].[story_genres] ADD  CONSTRAINT [unique_story_genre] UNIQUE NONCLUSTERED 
(
	[story_id] ASC,
	[genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E6164979432CC]    Script Date: 2/18/2025 3:32:55 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__F3DBC57212A6DAF4]    Script Date: 2/18/2025 3:32:55 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[admin_logs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[admins] ADD  DEFAULT ('moderator') FOR [role]
GO
ALTER TABLE [dbo].[admins] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[chapters] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[comments] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[favorites] ADD  DEFAULT (getdate()) FOR [added_at]
GO
ALTER TABLE [dbo].[followed_stories] ADD  DEFAULT (getdate()) FOR [followed_at]
GO
ALTER TABLE [dbo].[ratings] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[reading_history] ADD  DEFAULT (getdate()) FOR [last_read_at]
GO
ALTER TABLE [dbo].[reading_history] ADD  DEFAULT (getdate()) FOR [StartTime]
GO
ALTER TABLE [dbo].[reading_history] ADD  DEFAULT (getdate()) FOR [EndTime]
GO
ALTER TABLE [dbo].[stories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [RankId]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [Level]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [ExpPoints]
GO
ALTER TABLE [dbo].[admin_logs]  WITH CHECK ADD FOREIGN KEY([admin_id])
REFERENCES [dbo].[admins] ([admin_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[chapter_images]  WITH CHECK ADD FOREIGN KEY([chapter_id])
REFERENCES [dbo].[chapters] ([chapter_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[chapters]  WITH CHECK ADD FOREIGN KEY([story_id])
REFERENCES [dbo].[stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD FOREIGN KEY([ParentCommentId])
REFERENCES [dbo].[comments] ([comment_id])
GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD FOREIGN KEY([story_id])
REFERENCES [dbo].[stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[favorites]  WITH CHECK ADD FOREIGN KEY([story_id])
REFERENCES [dbo].[stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[favorites]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[followed_stories]  WITH CHECK ADD FOREIGN KEY([story_id])
REFERENCES [dbo].[stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[followed_stories]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[followed_stories]  WITH CHECK ADD  CONSTRAINT [FK_followed_stories_LastReadChapter] FOREIGN KEY([LastReadChapterId])
REFERENCES [dbo].[chapters] ([chapter_id])
GO
ALTER TABLE [dbo].[followed_stories] CHECK CONSTRAINT [FK_followed_stories_LastReadChapter]
GO
ALTER TABLE [dbo].[Ranks]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[RankCategories] ([CategoryId])
GO
ALTER TABLE [dbo].[ratings]  WITH CHECK ADD FOREIGN KEY([story_id])
REFERENCES [dbo].[stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ratings]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[reading_history]  WITH CHECK ADD FOREIGN KEY([chapter_id])
REFERENCES [dbo].[chapters] ([chapter_id])
GO
ALTER TABLE [dbo].[reading_history]  WITH CHECK ADD FOREIGN KEY([story_id])
REFERENCES [dbo].[stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[reading_history]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[story_genres]  WITH CHECK ADD FOREIGN KEY([genre_id])
REFERENCES [dbo].[genres] ([genre_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[story_genres]  WITH CHECK ADD FOREIGN KEY([story_id])
REFERENCES [dbo].[stories] ([story_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([RankId])
REFERENCES [dbo].[Ranks] ([RankId])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_User_AvatarFrame] FOREIGN KEY([AvatarFrameId])
REFERENCES [dbo].[AvatarFrame] ([AvatarFrameId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_User_AvatarFrame]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Rank] FOREIGN KEY([RankId])
REFERENCES [dbo].[Ranks] ([RankId])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_Users_Rank]
GO
ALTER TABLE [dbo].[ratings]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
