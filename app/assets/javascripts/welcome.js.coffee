# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.ajax
    url: "http://localhost:8888/api/v1/campaigns"
    dataType: "json"
    method: "get"
    data:
      access_token: "407a4d5e268ee49a957a81fbf2639237"
    error: ->
      alert("ERROR")
    success: (data) ->
      template = $("#campaign-listing-template").html()
      Mustache.parse(template)
      for campaign in data
        rendered_template = Mustache.render(template, campaign)
        $("#campaigns").append(rendered_template)

  $("#campaigns").on "click", ".title", ->
    $.ajax
      url: "http://localhost:8888/api/v1/campaigns/" + $(@).data("id")
      dataType: "json"
      method: "get"
      error: ->
        alert("ERROR")
      success: (data) ->
        template = $("#single-campaign-display").html()
        rendered = Mustache.render(template, data)
        $("#single-campaign-container").hide()
        $("#single-campaign-container").html(rendered)
        $("#campaigns").fadeOut 700, ->
          $("#single-campaign-container").fadeIn(300)
    false

  $("#single-campaign-container").on "click", ".back", ->
    $("#single-campaign-container").fadeOut 700, ->
      $("#campaigns").fadeIn 300


