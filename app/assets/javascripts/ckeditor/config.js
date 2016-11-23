CKEDITOR.editorConfig = function( config )
{
    config.toolbar =
        [
            { name: 'document',    items : [ 'Source' ] },
            { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
            { name: 'tools',       items : [ 'Maximize' ] },
            { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
            { name: 'insert',      items : [ 'Image','Table' ] },
            { name: 'colors',      items : [ 'TextColor','BGColor' ] }
        ];
    config.removePlugins = 'elementspath';
    config.forcePasteAsPlainText = true;
};