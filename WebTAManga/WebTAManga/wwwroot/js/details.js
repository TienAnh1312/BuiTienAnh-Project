
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
        document.addEventListener("click", function (e) {
            if (!e.target.classList.contains("sticker-icon")) return;

            const sticker = e.target;
            const form = sticker.closest(".comment-form") || sticker.closest(".reply-form");
            if (!form) return;

            // Xóa lớp selected khỏi tất cả sticker trong form hiện tại
            form.querySelectorAll(".sticker-icon").forEach((s) => s.classList.remove("selected"));

            // Thêm lớp selected vào sticker được chọn
            sticker.classList.add("selected");

            // Cập nhật giá trị StickerId vào input ẩn
            const stickerId = sticker.getAttribute("data-sticker-id");
            const hiddenInput = form.querySelector('input[name="StickerId"]');
            if (hiddenInput) {
                hiddenInput.value = stickerId;
                console.log(`StickerId set to ${stickerId} for form:`, form);
            } else {
                console.error("Hidden input for StickerId not found in form:", form);
            }
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