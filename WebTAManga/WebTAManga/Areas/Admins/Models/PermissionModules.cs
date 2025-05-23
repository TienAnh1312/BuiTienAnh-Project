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
        public const string Transactions = "Transactions";
        public const string Reports = "Reports";
        public const string Comments = "Comments";
        public const string GroupManagement = "GroupManagement";
        public const string FinancialReports = "FinancialReports";

        public static readonly List<string> AllModules = new List<string>
        {
            Banners, Ranks, Stories, Chapters, ChapterImages, Genres, Stickers, Transactions, Reports, Comments, GroupManagement, FinancialReports
        };

        public static readonly List<string> ContentManagerModules = new List<string>
        {
            Banners, Ranks, Stories, Chapters, ChapterImages, Genres, GroupManagement
        };

        public static readonly List<string> UserManagerModules = new List<string>
        {
            Transactions, Reports, GroupManagement
        };

        public static readonly List<string> FinanceManagerModules = new List<string>
        {
            Transactions, FinancialReports, GroupManagement
        };

        public static readonly List<string> CommentModeratorModules = new List<string>
        {
            Comments, GroupManagement
        };

        public static readonly List<string> ReporterHandlerModules = new List<string>
        {
            Reports, GroupManagement
        };

        public static readonly Dictionary<string, List<string>> ManagerAssignableModules = new Dictionary<string, List<string>>
        {
            { "ContentManager", ContentManagerModules },
            { "UserManager", UserManagerModules },
            { "FinanceManager", FinanceManagerModules }, 
            { "CommentModerator", CommentModeratorModules },
            { "ReporterHandler", ReporterHandlerModules }
        };
    }
}