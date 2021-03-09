$(document).on('turbolinks:load', function() {
		$('form').on('change', '.file_upload', function(event) {
				console.log("Creating Preview");
				$('img').attr('src', URL.createObjectURL(this.files[0]));
				$('img').css({ width: '100px', height: '100px' });
		});
});
