namespace WebTAManga.Areas.Admins.Models
{
    public static class PermissionModules
    {
        public const string Banners = "Banners";
        public const string Ranks = "Ranks";
        public const string Stories = "Stories";
        public const string Chapters = "Chapters";
        public const string ChapterImages = "ChapterImages";
        public const string Genres = "Genres";
        public const string Stickers = "Stickers";

        public static readonly List<string> AllModules = new List<string>
    {
        Banners, Ranks, Stories, Chapters, ChapterImages, Genres, Stickers
    };
    }
}
