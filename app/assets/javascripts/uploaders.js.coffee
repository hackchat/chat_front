# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
BASE_URL = 'hackchat.dev'

updateFiles = ->
  room_id = $('#current_room').html()
  modal = $('#file-modal')
  file_count = 0
  files = []
  $.get('/uploader.json', room_id: room_id).success (data) ->
    file_count = data.file_count
    files = data.files
  for file in files
    modal.find('#files').append 

$ ->
  $('#upload_file').click ->
    form = $('#file_upload')[0]
    setHiddenFieldsForFileUpload(form)
    data =  new FormData form
    jqxhr = $.ajax({
      type: 'POST',
      url: "/uploader",
      data: data,
      cache: false,
      contentType: false,
      processData: false
    })

    jqxhr.success (data) ->
      $('#message_content').html "#{data.url}"


  setHiddenFieldsForFileUpload = (form)->
    $(form).find('#file_room_id').val $('#current_room').html()
    $(form).find('#file_user_token').val $('#current_user').attr('user-token')