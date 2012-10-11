# Double Click on trs
$(document).ready ->
  $('table.nowrap tr').hover(
    -> $('td > div', this).css('white-space', 'normal')
    -> $('td > div', this).css('white-space', 'nowrap')
  )
