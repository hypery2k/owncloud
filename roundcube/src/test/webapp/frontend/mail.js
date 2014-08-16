describe('mail', function() {
  it("Roundcube.fillWindow - null", function() {    
    spyOn(Roundcube, 'fillWindow');  
    var selector = {};
    selector.length=0;
    Roundcube.fillWindow(selector);
  });
  it("Roundcube.fillHeight - null", function() {    
    spyOn(Roundcube, 'fillWindow');  
    var selector = {};
    selector.length=0;
    Roundcube.fillHeight(selector);
  });
  it("Roundcube.iFrameReady - basic", function() {    
    Roundcube.iFrameReady();
  }); 
  it("Roundcube.iFrameReady - load complete", function() {    
    Roundcube.iFrameReady();
  }); 
 
});