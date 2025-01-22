using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace WebTAManga.Models​;

public partial class WebMangaContext : DbContext
{
    public WebMangaContext()
    {
    }

    public WebMangaContext(DbContextOptions<WebMangaContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Admin> Admins { get; set; }

    public virtual DbSet<AdminLog> AdminLogs { get; set; }

    public virtual DbSet<Chapter> Chapters { get; set; }

    public virtual DbSet<ChapterImage> ChapterImages { get; set; }

    public virtual DbSet<Comment> Comments { get; set; }

    public virtual DbSet<Favorite> Favorites { get; set; }

    public virtual DbSet<FollowedStory> FollowedStories { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Rating> Ratings { get; set; }

    public virtual DbSet<ReadingHistory> ReadingHistories { get; set; }

    public virtual DbSet<Story> Stories { get; set; }

    public virtual DbSet<StoryGenre> StoryGenres { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=DESKTOP-53K42V9;Database=WebManga;uid=sa;pwd=123456;MultipleActiveResultSets=True;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Admin>(entity =>
        {
            entity.HasKey(e => e.AdminId).HasName("PK__admins__43AA41419291874A");

            entity.ToTable("admins");

            entity.HasIndex(e => e.Email, "UQ__admins__AB6E61642427EAFB").IsUnique();

            entity.HasIndex(e => e.Username, "UQ__admins__F3DBC5722758602E").IsUnique();

            entity.Property(e => e.AdminId).HasColumnName("admin_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .HasColumnName("password");
            entity.Property(e => e.Role)
                .HasMaxLength(20)
                .HasDefaultValue("moderator")
                .HasColumnName("role");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .HasColumnName("username");
        });

        modelBuilder.Entity<AdminLog>(entity =>
        {
            entity.HasKey(e => e.LogId).HasName("PK__admin_lo__9E2397E00F4C406B");

            entity.ToTable("admin_logs");

            entity.Property(e => e.LogId).HasColumnName("log_id");
            entity.Property(e => e.Action)
                .HasMaxLength(255)
                .HasColumnName("action");
            entity.Property(e => e.AdminId).HasColumnName("admin_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.TargetId).HasColumnName("target_id");
            entity.Property(e => e.TargetTable)
                .HasMaxLength(50)
                .HasColumnName("target_table");

            entity.HasOne(d => d.Admin).WithMany(p => p.AdminLogs)
                .HasForeignKey(d => d.AdminId)
                .HasConstraintName("FK__admin_log__admin__66603565");
        });

        modelBuilder.Entity<Chapter>(entity =>
        {
            entity.HasKey(e => e.ChapterId).HasName("PK__chapters__745EFE8771004EC1");

            entity.ToTable("chapters");

            entity.Property(e => e.ChapterId).HasColumnName("chapter_id");
            entity.Property(e => e.ChapterTitle)
                .HasMaxLength(255)
                .HasColumnName("chapter_title");
            entity.Property(e => e.Content).HasColumnName("content");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.StoryId).HasColumnName("story_id");

            entity.HasOne(d => d.Story).WithMany(p => p.Chapters)
                .HasForeignKey(d => d.StoryId)
                .HasConstraintName("FK__chapters__story___45F365D3");
        });

        modelBuilder.Entity<ChapterImage>(entity =>
        {
            entity.HasKey(e => e.ImageId).HasName("PK__chapter___DC9AC9559DDFE85B");

            entity.ToTable("chapter_images");

            entity.Property(e => e.ImageId).HasColumnName("image_id");
            entity.Property(e => e.ChapterId).HasColumnName("chapter_id");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(255)
                .HasColumnName("image_url");
            entity.Property(e => e.PageNumber).HasColumnName("page_number");

            entity.HasOne(d => d.Chapter).WithMany(p => p.ChapterImages)
                .HasForeignKey(d => d.ChapterId)
                .HasConstraintName("FK__chapter_i__chapt__6EF57B66");
        });

        modelBuilder.Entity<Comment>(entity =>
        {
            entity.HasKey(e => e.CommentId).HasName("PK__comments__E7957687FA04305E");

            entity.ToTable("comments");

            entity.Property(e => e.CommentId).HasColumnName("comment_id");
            entity.Property(e => e.Content).HasColumnName("content");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.StoryId).HasColumnName("story_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.ParentComment).WithMany(p => p.InverseParentComment)
                .HasForeignKey(d => d.ParentCommentId)
                .HasConstraintName("FK__comments__Parent__02FC7413");

            entity.HasOne(d => d.Story).WithMany(p => p.Comments)
                .HasForeignKey(d => d.StoryId)
                .HasConstraintName("FK__comments__story___5CD6CB2B");

            entity.HasOne(d => d.User).WithMany(p => p.Comments)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__comments__user_i__5BE2A6F2");
        });

        modelBuilder.Entity<Favorite>(entity =>
        {
            entity.HasKey(e => e.FavoriteId).HasName("PK__favorite__46ACF4CB92150085");

            entity.ToTable("favorites");

            entity.Property(e => e.FavoriteId).HasColumnName("favorite_id");
            entity.Property(e => e.AddedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("added_at");
            entity.Property(e => e.StoryId).HasColumnName("story_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Story).WithMany(p => p.Favorites)
                .HasForeignKey(d => d.StoryId)
                .HasConstraintName("FK__favorites__story__52593CB8");

            entity.HasOne(d => d.User).WithMany(p => p.Favorites)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__favorites__user___5165187F");
        });

        modelBuilder.Entity<FollowedStory>(entity =>
        {
            entity.HasKey(e => e.FollowId).HasName("PK__followed__15A69144C7050AB0");

            entity.ToTable("followed_stories");

            entity.HasIndex(e => new { e.UserId, e.StoryId }, "unique_follow").IsUnique();

            entity.Property(e => e.FollowId).HasColumnName("follow_id");
            entity.Property(e => e.FollowedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("followed_at");
            entity.Property(e => e.StoryId).HasColumnName("story_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.LastReadChapter).WithMany(p => p.FollowedStories)
                .HasForeignKey(d => d.LastReadChapterId)
                .HasConstraintName("FK_followed_stories_LastReadChapter");

            entity.HasOne(d => d.Story).WithMany(p => p.FollowedStories)
                .HasForeignKey(d => d.StoryId)
                .HasConstraintName("FK__followed___story__6C190EBB");

            entity.HasOne(d => d.User).WithMany(p => p.FollowedStories)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__followed___user___6B24EA82");
        });

        modelBuilder.Entity<Genre>(entity =>
        {
            entity.HasKey(e => e.GenreId).HasName("PK__genres__18428D42B38D820E");

            entity.ToTable("genres");

            entity.HasIndex(e => e.Name, "UQ__genres__72E12F1B75844B93").IsUnique();

            entity.Property(e => e.GenreId).HasColumnName("genre_id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Rating>(entity =>
        {
            entity.HasKey(e => e.RatingId).HasName("PK__ratings__D35B278BF3CCAC4C");

            entity.ToTable("ratings");

            entity.Property(e => e.RatingId).HasColumnName("rating_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Rating1).HasColumnName("rating");
            entity.Property(e => e.StoryId).HasColumnName("story_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Story).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.StoryId)
                .HasConstraintName("FK__ratings__story_i__628FA481");

            entity.HasOne(d => d.User).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__ratings__user_id__619B8048");
        });

        modelBuilder.Entity<ReadingHistory>(entity =>
        {
            entity.HasKey(e => e.HistoryId).HasName("PK__reading___096AA2E9F47ADE32");

            entity.ToTable("reading_history");

            entity.Property(e => e.HistoryId).HasColumnName("history_id");
            entity.Property(e => e.ChapterId).HasColumnName("chapter_id");
            entity.Property(e => e.LastReadAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("last_read_at");
            entity.Property(e => e.StoryId).HasColumnName("story_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Chapter).WithMany(p => p.ReadingHistories)
                .HasForeignKey(d => d.ChapterId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__reading_h__chapt__5812160E");

            entity.HasOne(d => d.Story).WithMany(p => p.ReadingHistories)
                .HasForeignKey(d => d.StoryId)
                .HasConstraintName("FK__reading_h__story__571DF1D5");

            entity.HasOne(d => d.User).WithMany(p => p.ReadingHistories)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__reading_h__user___5629CD9C");
        });

        modelBuilder.Entity<Story>(entity =>
        {
            entity.HasKey(e => e.StoryId).HasName("PK__stories__66339C5649B23FA7");

            entity.ToTable("stories");

            entity.Property(e => e.StoryId).HasColumnName("story_id");
            entity.Property(e => e.Author)
                .HasMaxLength(100)
                .HasColumnName("author");
            entity.Property(e => e.CoverImage)
                .HasMaxLength(255)
                .HasColumnName("cover_image");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Description).HasColumnName("description");
            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .HasColumnName("title");
        });

        modelBuilder.Entity<StoryGenre>(entity =>
        {
            entity.HasKey(e => e.StoryGenreId).HasName("PK__story_ge__B78B7C18999E6C04");

            entity.ToTable("story_genres");

            entity.HasIndex(e => new { e.StoryId, e.GenreId }, "unique_story_genre").IsUnique();

            entity.Property(e => e.StoryGenreId).HasColumnName("story_genre_id");
            entity.Property(e => e.GenreId).HasColumnName("genre_id");
            entity.Property(e => e.StoryId).HasColumnName("story_id");

            entity.HasOne(d => d.Genre).WithMany(p => p.StoryGenres)
                .HasForeignKey(d => d.GenreId)
                .HasConstraintName("FK__story_gen__genre__4D94879B");

            entity.HasOne(d => d.Story).WithMany(p => p.StoryGenres)
                .HasForeignKey(d => d.StoryId)
                .HasConstraintName("FK__story_gen__story__4CA06362");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__users__B9BE370FED03E79E");

            entity.ToTable("users");

            entity.HasIndex(e => e.Email, "UQ__users__AB6E6164979432CC").IsUnique();

            entity.HasIndex(e => e.Username, "UQ__users__F3DBC57212A6DAF4").IsUnique();

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .HasColumnName("password");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .HasColumnName("username");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
