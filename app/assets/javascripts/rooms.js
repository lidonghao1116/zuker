$(function() {
  //var mediaDropzone;
  //mediaDropzone = new Dropzone("#media-dropzone");
  $("form#mediaDropzone").dropzone({ 
  // "myAwesomeDropzone" is the camelized version of the HTML element's ID
  //Dropzone.options.mediaDropzone = {
    paramName: "image", // The name that will be used to transfer the file
    maxFilesize: 1, // MB
    addRemoveLinks: true,
    autoProcessQueue: false,

     // The setting up of the dropzone
    init: function() {
      var myDropzone = this;
      // First change the button to actually tell Dropzone to process the queue.
      $("input[type=submit]").click(function(e) {
        console.log('go upload!');
        // Make sure that the form isn't actually being sent.
        e.preventDefault();
        e.stopPropagation();
        myDropzone.processQueue();
      });
    }
    // forceFallback: true,
    // accept: function(file, done) {
    //   if (file.name == "123.png") {
    //     done("Naha, you don't.");
    //   }
    //   else { done(); }
    // }
  });


});