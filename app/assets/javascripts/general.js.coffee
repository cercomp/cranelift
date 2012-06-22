# Double Click on trs
$(window).ready ->
  $('table.dblclick tr').dblclick ->
    window.location.href = $(this).data 'url'
