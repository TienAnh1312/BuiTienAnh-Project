﻿using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace K21CNT2_BuiTienAnh_2110900003.Utilities
{
    public static class Utils
    {
        public static string GetSHA26Hash(string input) 
        {
            string hash = "";
            using (var sha256 = new SHA256Managed())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
                hash = BitConverter.ToString(hashedBytes).Replace("-","").ToLower();
            }
            return hash;
        }

        internal static string? GetSHA256Hash(string password)
        {
            throw new NotImplementedException();
        }
    }
}
