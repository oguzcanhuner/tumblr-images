$(window).load(function() {
  var $container = $('#container');

  $container.masonry({
    itemSelector: '.image',
    columnWidth: 250,
    gutter: 10
  });
});
