$(document).ready ->
  toggle_transparent_class = -> $(this).find('button').toggleClass('transparent')
  $('table#roles tr').hover(toggle_transparent_class, toggle_transparent_class)
