function showModal(link) {
	var _modal = $("#modalImage");
	var _image = document.getElementById('modalImageBody');

	_image.src = link;

	_modal.modal();
}