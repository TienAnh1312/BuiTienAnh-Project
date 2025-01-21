using System.ComponentModel.DataAnnotations;

namespace WebTAManga.Login.Models
{
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
}
