# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

feedLi = (id, title, url) ->
  '<li class="feed" id="feed-'+id+'">
    <a class="thunderlink" href="'+url+'" target="_blank">
      <span class="light"></span>
      <span class="title">'+title+'</span>
    </a>
    <a class="feed-action delete"></a>
  </li>'

$(document).ready ->

  #Create hot list
  $('.feeds').append '<ol class="hot-feeds"></ul>'
  #Create cold list
  $('.feeds').append '<ol class="cold-feeds"></ul>'

  $.each gon.feed, ->

    id             = this.id
    title          = this.title
    url            = this.url
    last_modified  = new Date(this.last_modified)
    last_visited   = new Date(this.last_visited)


    if last_modified > last_visited
      $('ol.hot-feeds').append feedLi(id,title,url)
    else
      $('ol.cold-feeds').append feedLi(id,title,url)

  #Flip the order of hot list
  $('ol.hot-feeds').children().each ->
    $('ol.hot-feeds').prepend this

  $(".feeds a").click (e) ->
      e.preventDefault

      feedId = parseInt $(this).parent().attr('id').replace('feed-','')

      # $(this).parent().addClass "fadeOutDown"

      ## Find feed in gon array
      i = 0
      while i < gon.feed.length
        if gon.feed[i].id == feedId
          gonId = i
          break
        i++

      $(this).parent().addClass "animated"
      $(this).parent().addClass "fadeInUp"
      $(this).parent().delay(2000).appendTo('ol.cold-feeds')

      # Runs controller to update last_view
      $.ajax
        type: "get"
        url: "/feeds/" + feedId

  #Load new form
  $("a.add_thunderlink").click ->

    if $(".feed-add").is(":visible")
      $(".feed-add").remove()
      $(this).removeClass('active')
      false
    else
      $(this).addClass('active')
      url = $(this).attr("href")
      $.get url, (data) ->
        $('.feeds').prepend(data)

      false


hideAddThunderlinkForm = ->
  $(".remote-form").remove()
# counter = 0
# setInterval (->

#   $('body').attr('data-colour', 'colour-' + counter)
#   counter++

#   if counter == 3
#     counter = 0
# ), 10000