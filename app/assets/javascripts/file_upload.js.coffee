BASE_URL = 'hackchat.dev'

$ ->

  $(':file').change ->
    file = this.files[0]
    name = file.name
    size = file.size
    type = file.type

  $('#upload_file').click ->
    data =  new FormData $('form')[0]
    form = $('#file_upload')
    console.log form
    data =  new FormData form
    $.ajax({
      type: 'POST',
      url: "http://files.#{BASE_URL}/uploader",
      data: data,
      cache: false,
      contentType: 'multipart/alternative',
      processData: false,
      crossDomain: true
    })

  progressHandlingFunction = (e) ->
    if(e.lengthComputable)
        $('progress').attr({value:e.loaded,max:e.total})