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
    url = $('#story_url').val()
    button = $(this)
    old_val = button.val()
    button.prop("disabled", true)
    button.val("Fetching...")
    $.post("/stories/fetch_url_title", { fetch_url: url })
      .success (data)->
        error = button.parent().find('div.errors')
        if data.status == 'error'
          if error.length == 0
            error = button.parent().append('<div class="errors"/>').find('.errors')
          error.html(data.message)
        else
          error.remove()
          $('#story_title').val(data.title)
          t = $('#story_description')
          if t.val() == ''
            t.val(data.snippet)
          $('#story_url').val(data.url)
        button.val(old_val)
        button.prop("disabled", false)
      .error ->
        button.val(old_val)
        button.prop("disabled", false)

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

