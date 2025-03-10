using System.ComponentModel.DataAnnotations;

namespace WebTAManga.Models
{
    public class Account
    {
        [Required(ErrorMessage = "Vui lòng nhập email")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ")]
        public string Email { get; set; }
    }

    public class LoginCustomers
    {
        [Required(ErrorMessage = "Email không được để trống")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Required(ErrorMessage = "Password không được để trống")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        public bool Remember { get; set; }
        public int CustomersID { get; internal set; }

    }

    public class ChangePassword
    {
        [Required(ErrorMessage = "Vui lòng nhập mật khẩu hiện tại")]
        [DataType(DataType.Password)]
        public string CurrentPassword { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mật khẩu mới")]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Mật khẩu mới phải từ 6 ký tự trở lên")]
        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "Vui lòng xác nhận mật khẩu mới")]
        [DataType(DataType.Password)]
        [Compare("NewPassword", ErrorMessage = "Mật khẩu xác nhận không khớp với mật khẩu mới")]
        public string ConfirmNewPassword { get; set; }
    }
   
    public class EnterResetCode
    {
        public string Email { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mã xác nhận")]
        public string Code { get; set; }
    }

    public class ResetPassword
    {
        public string Email { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mật khẩu mới")]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Mật khẩu phải có ít nhất 6 ký tự")]
        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập lại mật khẩu")]
        [Compare("NewPassword", ErrorMessage = "Mật khẩu xác nhận không khớp")]
        [DataType(DataType.Password)]
        public string ConfirmPassword { get; set; }
    }
}