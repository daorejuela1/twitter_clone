$(document).on('turbolinks:load', function() {
		$('form').on('change', '.file_upload', function(event) {
				console.log("Creating Preview");
				$('img.img_upload_field').attr('src', URL.createObjectURL(this.files[0]));
				$('img.img_upload_field').css({ width: '100px', height: '100px' });
		});
});
