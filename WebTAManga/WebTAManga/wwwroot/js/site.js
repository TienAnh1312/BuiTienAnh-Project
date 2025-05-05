const SwalHelper = {
    showSuccess: (title, text, callback) => {
        Swal.fire({
            icon: 'success',
            title: title || 'Thành công!',
            text: text || 'Hành động đã hoàn tất.',
            confirmButtonText: 'OK',
            confirmButtonColor: '#3085d6'
        }).then(callback);
    },
    showError: (title, text) => {
        Swal.fire({
            icon: 'error',
            title: title || 'Lỗi!',
            text: text || 'Có lỗi xảy ra, vui lòng thử lại.',
            confirmButtonText: 'OK',
            confirmButtonColor: '#d33'
        });
    },
    showLoading: () => {
        Swal.fire({
            title: 'Đang xử lý...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });
    },
    showConfirm: (title, text, confirmText, cancelText, callback) => {
        Swal.fire({
            title: title || 'Bạn có chắc chắn?',
            text: text || 'Hành động này không thể hoàn tác!',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: confirmText || 'Có',
            cancelButtonText: cancelText || 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                callback();
            }
        });
    }
};