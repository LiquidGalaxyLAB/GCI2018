console.log("JS");
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.carousel');
    var instance = M.Carousel.init(elems, {
        fullWidth: true,
        indicators: true
    });

    var elems = document.querySelectorAll('.scrollspy');
    var instances = M.ScrollSpy.init(elems, {
        
    });

    var elems = document.querySelectorAll('.modal');
    var instances = M.Modal.init(elems, {
        
    });

    setInterval(() => {
        var instance = M.Carousel.getInstance(document.querySelector('.carousel'));
        instance.next();
    }, 2500);
});

