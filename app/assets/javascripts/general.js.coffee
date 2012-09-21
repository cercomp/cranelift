# Double Click on trs
$(document).ready ->
  $('table.dblclick tr').dblclick ->
    window.location.href = $(this).data 'url'

  $('table.nowrap tr').hover(
    -> $('td > div', this).css('white-space', 'normal')
    -> $('td > div', this).css('white-space', 'nowrap')
  )
