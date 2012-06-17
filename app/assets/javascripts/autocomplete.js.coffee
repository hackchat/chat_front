## monkey-path array.
Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

$ ->
  $('#message_content').keyup ->
    content = $(this)
    last_word = content.val().split(" ").pop()
    if last_word.match /^@/
      if last_word.length > 1
        regex = new RegExp(last_word.replace('@',''))
        
        matches = Roomies.slice().filter (roomie) ->
          roomie.name.match(regex)
        matches = matches.slice().unique()
        if matches.length == 1
          array = content.val().split(" ")
          array.pop()
          array.push("@#{matches[0].name}")
          content.val array.join(" ")