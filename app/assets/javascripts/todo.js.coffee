todo_autosubmit = ->
  input = $(this)
  input.unbind('change', todo_autosubmit)

  input.closest('form').submit()

todo_ajax_success = ->
  li = $(this).closest('li.todo')
  li.hide()

todo_ajax_error = ->
  form = $(this)

  li = form.closest('li.todo')
  li.effect('highlight', {color: '#FF0000'}, 1000)

  input = form.children('input[type="checkbox"]')
  input.attr('checked', false)
  input.bind('change', todo_autosubmit)

$ ->
  form = $('form.edit_todo')
  form.bind('ajax:success', todo_ajax_success)
  form.bind('ajax:error',   todo_ajax_error)

  elements = form.children('input.autosubmit')
  elements.bind('change', todo_autosubmit)
