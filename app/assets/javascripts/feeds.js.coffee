# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  #Create hot list
  $('.feeds').append '<ul class="hot-feeds"></ul>'
  #Create cold list
  $('.feeds').append '<ul class="cold-feeds"></ul>'

  $.each gon.feed, ->

    id             = this.id
    title          = this.title
    url            = this.url
    last_modified  = new Date(this.last_modified)
    last_visited   = new Date(this.last_visited)


    if last_modified > last_visited
      $('ul.hot-feeds').append '<li class="feed" id="feed-'+id+'"><a href="'+url+'" target="_blank">'+title+' Last Mod:'+last_modified+' Last Vis:'+last_visited+'</a></li>'
    else
      $('ul.cold-feeds').append '<li class="feed" id="feed-'+id+'"><a href="'+url+'" target="_blank">'+title+' Last Mod:'+last_modified+' Last Vis:'+last_visited+'</a></li>'

  $("a").click (e) ->
      e.preventDefault

      feedId = parseInt $(this).parent().attr('id').replace('feed-','')

      ## Find feed in gon array
      i = 0
      while i < gon.feed.length
        if gon.feed[i].id == feedId
          gonId = i
          break
        i++


      # Runs controller to update last_view
      $.ajax
        type: "get"
        url: "/feeds/" + feedId

  #     dataType: "script"
  #     beforeSend: ->
  #       alert "sdfsf"


