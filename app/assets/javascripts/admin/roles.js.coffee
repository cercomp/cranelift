$(document).ready ->
  $('table#roles tr').hover(
    -> $(this).find('button').toggleClass('hide')
    -> $(this).find('button').toggleClass('hide')
  )
