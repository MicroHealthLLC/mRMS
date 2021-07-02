$('.data_title').tooltip({
  content: function(){
    var element = $( this );
    return element.attr('title');
  }
});
