
const SweetAlert = {
    // Hàm hiển thị thông báo thành công
    success: (title, message, callback) => {
        Swal.fire({
            icon: 'success',
            title: title || 'Thành công!',
            text: message,
            confirmButtonText: 'OK'
        }).then(callback);
    },

    // Hàm hiển thị thông báo lỗi
    error: (title, message, callback) => {
        Swal.fire({
            icon: 'error',
            title: title || 'Lỗi!',
            text: message,
            confirmButtonText: 'OK'
        }).then(callback);
    },

    // Hàm hiển thị thông báo cảnh báo (ví dụ: xác nhận xóa)
    confirm: (title, message, confirmText, cancelText, callback) => {
        Swal.fire({
            icon: 'warning',
            title: title || 'Xác nhận',
            text: message,
            showCancelButton: true,
            confirmButtonText: confirmText || 'Xác nhận',
            cancelButtonText: cancelText || 'Hủy'
        }).then((result) => {
            if (result.isConfirmed && callback) {
                callback();
            }
        });
    },

    // Hàm hiển thị thông báo thông tin
    info: (title, message, callback) => {
        Swal.fire({
            icon: 'info',
            title: title || 'Thông tin',
            text: message,
            confirmButtonText: 'OK'
        }).then(callback);
    }
};