$ ->
  window.wiselinks = new Wiselinks($('#theloop > .copy-pad'), html4: false )
  $(document).on 'page:done', ->
    page_events()
