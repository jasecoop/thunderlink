# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(".feed a").click (e) ->
    e.preventDefault

    id = $(this).attr "data-id"

    # Runs controller to update last_view
    $.ajax
      type: "get"
      url: "/feeds/" + id

#     dataType: "script"
#     beforeSend: ->
#       alert "sdfsf"

    $(this).attr "data-last-visited", "update"


  # Determine if Feed is hot or cold
  $('li.feed a').each ->

    last_visited  = $(this).attr "data-last-visited"
    last_modified = $(this).attr "data-last-modified"

    last_visitied_date = new Date(Number(last_visited) * 1000)
    last_modified_date = new Date(Number(last_modified) * 1000)

    if last_modified_date > last_visitied_date
      $(this).parent().addClass "hot"
    else
      $(this).parent().addClass "cold"

    # timeDiff = Math.abs(last_modified_date.getTime() - last_visitied_date.getTime())
    # diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24))
    # alert diffDays
