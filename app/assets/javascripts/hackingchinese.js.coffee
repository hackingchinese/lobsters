$ ->
  window.wiselinks = new Wiselinks($('#theloop > .copy-pad'), html4: false )
  $(document).on 'page:done', ->
    $("#story_tags_a").select2
      formatSelection: (what)-> what.id
      matcher: (term, text)->
        return text.toUpperCase().indexOf(term.toUpperCase()) == 0
    $("#story_url").focus()
  .trigger('page:done')

  $('body').on 'click', "#story_fetch_title", ->
    Lobsters.fetchURLTitle($(this), $("#story_url"), $("#story_title"))
    false

  $('body').on 'click', "#delete_all", ->
    table = $(e.target).closest("table")
    $("td input:checkbox", table).attr("checked", e.target.checked)
  $('body').on 'click', ".comment a.downvoter", ->
    Lobsters.downvoteComment(this)
    false
  $('body').on 'click', ".comment a.upvoter", ->
    Lobsters.upvoteComment(this)
    false
  $('body').on 'click', "li.story a.downvoter", ->
    Lobsters.downvote(this)
    false
  $('body').on 'click', "li.story a.upvoter", ->
    Lobsters.upvote(this)
    false
  $('body').on 'click', "li.story a.mod_story_link", ->
    Lobsters.moderateStory(this)
