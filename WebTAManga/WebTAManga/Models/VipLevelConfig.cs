namespace WebTAManga.Models
{
    public static class VipLevelConfig
    {
        public static readonly Dictionary<int, double> VipThresholds = new Dictionary<int, double>
    {
        { 1, 1000 },   // VIP 1: 1,000 xu
        { 2, 5000 },   // VIP 2: 5,000 xu
        { 3, 10000 },  // VIP 3: 10,000 xu
        { 4, 20000 },  // VIP 4: 20,000 xu
        { 5, 35000 },  // VIP 5: 35,000 xu
        { 6, 50000 },  // VIP 6: 50,000 xu
        { 7, 75000 },  // VIP 7: 75,000 xu
        { 8, 100000 }, // VIP 8: 100,000 xu
        { 9, 150000 }, // VIP 9: 150,000 xu
        { 10, 200000 } // VIP 10: 200,000 xu
    };

        public static int CalculateVipLevel(double totalRechargedCoins)
        {
            foreach (var threshold in VipThresholds.OrderByDescending(x => x.Value))
            {
                if (totalRechargedCoins >= threshold.Value)
                {
                    return threshold.Key;
                }
            }
            return 0; // Không đạt ngưỡng nào thì là 0 (không VIP)
        }
    }
}
