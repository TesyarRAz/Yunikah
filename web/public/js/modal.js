

function showModal(imageLink) {
	var _modal = $("#modalImage");
	var _image = document.getElementById('modalImageBody');

	_image.src = imageLink;

	_modal.modal();
}