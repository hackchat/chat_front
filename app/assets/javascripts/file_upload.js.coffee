$ ->

  $(':file').change ->
    file = this.files[0]
    name = file.name
    size = file.size
    type = file.type

  $('#upload_file').click ->
    console.log $('form')[0][0]
    data =  new FormData $('form')[0]
    $.ajax({
      type: 'POST',
      url: '/uploader',
      data: data,
      cache: false,
      contentType: false,
      processData: false
      })

  progressHandlingFunction = (e) ->
    if(e.lengthComputable)
        $('progress').attr({value:e.loaded,max:e.total})