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
                request.Fields = "id";

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

                var permission = new Google.Apis.Drive.v3.Data.Permission()
                {
                    Type = "anyone",
                    Role = "reader"
                };
                await _driveService.Permissions.Create(permission, uploadedFile.Id).ExecuteAsync();

                string downloadLink = $"https://drive.google.com/uc?export=download&id={uploadedFile.Id}";
                return (uploadedFile.Id, downloadLink);
            }
            catch (Exception ex)
            {
                throw new Exception($"Upload error for {fileName}: {ex.Message}", ex);
            }
        }

        public async Task<(string FileId, string WebViewLink)> UpdateFileAsync(string fileId, IFormFile newFile)
        {
            if (string.IsNullOrEmpty(fileId))
            {
                throw new ArgumentException("FileId cannot be null or empty.");
            }

            try
            {
                var fileMetadata = new Google.Apis.Drive.v3.Data.File();
                using var stream = newFile.OpenReadStream();
                var request = _driveService.Files.Update(fileMetadata, fileId, stream, newFile.ContentType);
                request.Fields = "id";

                var uploadProgress = await request.UploadAsync();
                if (uploadProgress.Status != UploadStatus.Completed)
                {
                    throw new Exception("Update failed: " + uploadProgress.Exception?.Message);
                }

                var updatedFile = request.ResponseBody;
                if (updatedFile == null)
                {
                    throw new Exception("Update completed but no file metadata returned.");
                }

                string downloadLink = $"https://drive.google.com/uc?export=download&id={updatedFile.Id}";
                return (updatedFile.Id, downloadLink);
            }
            catch (Google.GoogleApiException ex) when (ex.HttpStatusCode == System.Net.HttpStatusCode.NotFound)
            {
                throw new Exception($"File {fileId} not found on Google Drive.");
            }
            catch (Exception ex)
            {
                throw new Exception($"Error updating file {fileId}: {ex.Message}", ex);
            }
        }

        public async Task<bool> CheckFileExistsAsync(string fileId)
        {
            if (string.IsNullOrEmpty(fileId)) return false;

            try
            {
                var request = _driveService.Files.Get(fileId);
                request.Fields = "id";
                await request.ExecuteAsync();
                return true;
            }
            catch (Google.GoogleApiException ex) when (ex.HttpStatusCode == System.Net.HttpStatusCode.NotFound)
            {
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error checking file {fileId}: {ex.Message}");
                return false;
            }
        }

        public async Task DeleteFileAsync(string fileId)
        {
            if (string.IsNullOrEmpty(fileId)) return;

            const int maxRetries = 3;
            for (int attempt = 1; attempt <= maxRetries; attempt++)
            {
                try
                {
                  var response  =  await _driveService.Files.Delete(fileId).ExecuteAsync();
                    Console.WriteLine(response);
                    Console.WriteLine($"File {fileId} deleted successfully from Google Drive on attempt {attempt}.");
                    return;
                }
                catch (Google.GoogleApiException ex) when (ex.HttpStatusCode == System.Net.HttpStatusCode.NotFound)
                {
                    Console.WriteLine($"File {fileId} not found on Google Drive, skipping deletion.");
                    return;
                }
                catch (Exception ex)
                {
                    if (attempt == maxRetries)
                    {
                        throw new Exception($"Error deleting file {fileId} from Google Drive after {maxRetries} attempts: {ex.Message}", ex);
                    }
                    await Task.Delay(1000 * attempt); // Delay tăng dần trước khi thử lại
                    Console.WriteLine($"Retrying delete for file {fileId}, attempt {attempt} failed: {ex.Message}");
                }
            }
        }
    }
}