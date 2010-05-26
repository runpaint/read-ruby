$(document).ready(function() {
  $('figcaption').hide();    
  $('figure').hover(
    function() {
      $(this).find('figcaption').show();
    },
    function() {
      $(this).find('figcaption').hide();
    }
  );
});
