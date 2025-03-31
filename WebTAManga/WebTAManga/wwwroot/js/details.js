
(function ($) {
    "use strict";

    // === Xử lý phần mô tả (Description) ===
    function initDescriptionToggle() {
        const description = document.getElementById("description");
        const toggleButton = document.getElementById("toggleDescription");

        if (!description || !toggleButton) return;

        if (description.scrollHeight > description.clientHeight) {
            toggleButton.style.display = "block";
        } else {
            toggleButton.style.display = "none";
        }

        toggleButton.addEventListener("click", function () {
            if (description.style.maxHeight === "none") {
                description.style.maxHeight = "285px";
                toggleButton.textContent = "Xem thêm";
            } else {
                description.style.maxHeight = "none";
                toggleButton.textContent = "Thu gọn";
            }
        });
    }

    // === Xử lý bình luận và trả lời ===
    function toggleReplyForm(commentId, grandParentId, username, isCurrentUser) {
        const form = document.getElementById(`replyForm-${commentId}`);
        if (!form) return;

        const isHidden = form.style.display === "none" || form.style.display === "";
        form.style.display = isHidden ? "block" : "none";
        if (!isHidden) return;

        if (grandParentId) {
            const grandParentInput = form.querySelector('input[name="grandParentCommentId"]');
            if (grandParentInput) grandParentInput.value = grandParentId;
        }

        const textarea = form.querySelector("textarea");
        if (!textarea || isCurrentUser) return;

        const existingText = textarea.value.trim();
        if (!existingText.startsWith(`@${username}`)) {
            textarea.value = `@${username} `;
            textarea.focus();
        }
    }

    //Ẩn hiện bình luận
    function toggleReplies(commentId) {
        const repliesDiv = document.getElementById(`replies-${commentId}`);
        if (!repliesDiv) return;

        const toggleButton = repliesDiv.previousElementSibling;
        if (!toggleButton) return;

        const isHidden = repliesDiv.style.display === "none" || repliesDiv.style.display === "";
        repliesDiv.style.display = isHidden ? "block" : "none";

        const replyCount = repliesDiv.querySelectorAll(".reply").length;
        toggleButton.innerHTML = isHidden
            ? `<i class="fas fa-caret-up"></i> Ẩn ${replyCount} bình luận`
            : `<i class="fas fa-caret-down"></i> Hiện ${replyCount} bình luận`;
    }

   

    // === Xử lý sticker ===
    function initStickerSelection() {
        document.addEventListener("DOMContentLoaded", function () {
            // Xử lý chọn nhãn dán
            document.querySelectorAll('.sticker-icon').forEach(sticker => {
                sticker.addEventListener('click', function () {
                    const stickerId = this.getAttribute('data-sticker-id');
                    const formId = this.closest('.reply-form') ? `#selectedStickerId-${this.closest('.reply-form').id.split('-')[1]}` : '#selectedStickerId';
                    document.querySelector(formId).value = stickerId;
                    this.closest('.sticker-row').querySelectorAll('.sticker-icon').forEach(s => s.style.border = 'none');
                    this.style.border = '2px solid #00c4ff';
                });
            });
        });

        // Xử lý khi submit form
        document.querySelectorAll("form").forEach((form) =>
            form.addEventListener("submit", function (e) {
                const selectedSticker = form.querySelector(".sticker-icon.selected");
                const hiddenInput = form.querySelector('input[name="StickerId"]');
                if (selectedSticker && hiddenInput) {
                    hiddenInput.value = selectedSticker.getAttribute("data-sticker-id");
                    console.log(`Form submitting with StickerId: ${hiddenInput.value}`);
                } else {
                    console.log("No sticker selected or hidden input missing for form:", form);
                }
            })
        );
    }

    // === Khởi tạo khi DOM sẵn sàng ===
    document.addEventListener("DOMContentLoaded", function () {
        initDescriptionToggle();
        initStickerSelection();
        initFavoriteToggle();
        initFollowToggle();
    });

    // Xuất các hàm toàn cục nếu cần (cho các sự kiện inline HTML)
    window.toggleReplyForm = toggleReplyForm;
    window.toggleReplies = toggleReplies;
})(jQuery);