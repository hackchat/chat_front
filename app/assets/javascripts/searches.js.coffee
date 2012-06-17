# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#submit_search').click ->
    form = $('#new_search')
    setHiddenFieldsFor(form)
    data = form.serialize()
    jqxhr = $.post('/searches', data)
    displaySearchResults(jqxhr)  


  setHiddenFieldsFor = (form)->
    $(form).find('#room_id').val $('#current_room').html()
    $(form).find('#user_token').val $('#current_user').attr('user-token')

  displaySearchResults = (jqxhr) ->
    jqxhr.success((data) ->
          modal = $('#search_results')
          modal.find('#results').children().remove()
          numResults = data.results.length
          queryString = $('#new_search').find('#content').val().toString()
          if numResults > 0
            modal.find('#message').html(
              "Displaying #{numResults} #{ if numResults == 1 then 'result' else 'results'} for \'#{queryString}\'")
            results = modal.find('#results')
            console.log data.results
            for result in data['results']
              results.append Mustache.to_html($('#message_template').html(), result)
          else
            modal.find('#message').html "No results for #{queryString} :("

    )