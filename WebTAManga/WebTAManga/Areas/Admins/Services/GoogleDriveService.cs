using Google.Apis.Auth.OAuth2;
using Google.Apis.Drive.v3;
using Google.Apis.Services;
using Google.Apis.Upload;
using Microsoft.AspNetCore.Http;

namespace WebTAManga.Areas.Admins.Services
{
    public class GoogleDriveService
    {
        private readonly DriveService _driveService;
        private readonly string _folderId;

        public GoogleDriveService(string credentialsPath, string folderId)
        {
            _folderId = folderId;

            var credential = GoogleCredential.FromFile(credentialsPath)
                .CreateScoped(DriveService.Scope.Drive);

            _driveService = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "WebTAManga"
            });

            CheckFolderAccess();
        }

        private void CheckFolderAccess()
        {
            try
            {
                var request = _driveService.Files.Get(_folderId);
                request.Fields = "id, name, mimeType";
                var folder = request.Execute();
                if (folder.MimeType != "application/vnd.google-apps.folder")
                {
                    throw new Exception($"ID {_folderId} is not a folder, it's a {folder.MimeType}");
                }
                Console.WriteLine($"Folder accessible: {folder.Name} (ID: {folder.Id})");
            }
            catch (Google.GoogleApiException ex) when (ex.HttpStatusCode == System.Net.HttpStatusCode.NotFound)
            {
                throw new Exception($"Folder {_folderId} not found. Please check FolderId or permissions.");
            }
            catch (Exception ex)
            {
                throw new Exception($"Cannot access folder {_folderId}: {ex.Message}");
            }
        }
        public async Task<(string FileId, string WebViewLink)> UploadFileAsync(IFormFile file, string fileName)
        {
            var fileMetadata = new Google.Apis.Drive.v3.Data.File()
            {
                Name = fileName,
                Parents = new List<string> { _folderId }
            };

            try
            {
                using var stream = file.OpenReadStream();
                var request = _driveService.Files.Create(fileMetadata, stream, file.ContentType);
                request.Fields = "id, webViewLink";

                var uploadProgress = await request.UploadAsync();
                if (uploadProgress.Status != UploadStatus.Completed)
                {
                    throw new Exception("Upload failed: " + uploadProgress.Exception?.Message);
                }

                var uploadedFile = request.ResponseBody;
                if (uploadedFile == null)
                {
                    throw new Exception("Upload completed but no file metadata returned.");
                }

                // Đặt quyền công khai
                var permission = new Google.Apis.Drive.v3.Data.Permission()
                {
                    Type = "anyone",
                    Role = "reader"
                };
                await _driveService.Permissions.Create(permission, uploadedFile.Id).ExecuteAsync();

                string embedUrl = $"https://drive.google.com/uc?export=view&id={uploadedFile.Id}";
                return (uploadedFile.Id, embedUrl);
            }
            catch (Exception ex)
            {
                throw new Exception($"Upload error for {fileName}: {ex.Message}", ex);
            }
        }

        public async Task DeleteFileAsync(string fileId)
        {
            if (string.IsNullOrEmpty(fileId)) return; // Bỏ qua nếu FileId rỗng

            try
            {
                await _driveService.Files.Delete(fileId).ExecuteAsync();
                Console.WriteLine($"File {fileId} deleted successfully.");
            }
            catch (Google.GoogleApiException ex) when (ex.HttpStatusCode == System.Net.HttpStatusCode.NotFound)
            {
                Console.WriteLine($"File {fileId} not found, skipping deletion.");
                // Không ném lỗi, chỉ ghi log và tiếp tục
            }
            catch (Exception ex)
            {
                throw new Exception($"Error deleting file {fileId}: {ex.Message}", ex);
            }
        }
    }
}