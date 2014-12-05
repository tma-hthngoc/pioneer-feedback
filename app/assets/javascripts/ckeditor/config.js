// See http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.config.html#.toolbar_Basic
// and http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Setting_Configurations

CKEDITOR.config.toolbar_Basic = [
	  { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },

	  { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
	  { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
	  { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
	  { name: 'insert', items : [ 'Image','Smiley','SpecialChar' ] },
	  '/',
	  { name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
	  { name: 'colors', items : [ 'TextColor','BGColor' ] },
	  { name: 'tools', items : [ 'Maximize', '-', 'ShowBlocks','Source' ]}
];
