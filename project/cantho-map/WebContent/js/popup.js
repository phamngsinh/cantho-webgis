 $(function()  
   {  
     var hideDelay = 500;    
     var currentID;  
     var hideTimer = null;   
     var container = $('<div id="searchPopupContainer"> '
    	 + '	 <a onclick="" href="#" class="SelectPlaceCloseBut">Tat</a>'  
         + '<table width="" border="0" cellspacing="0" cellpadding="0" align="center" class="searchPopupPopup">'  
         + '<tr>'  
         + '   <td class="corner topLeft"></td>'  
         + '   <td class="top"></td>'  
         + '   <td class="corner topRight"></td>'  
         + '</tr>'  
         + '<tr>'  
         + '   <td class="left">&nbsp;</td>'  
         + '   <td><div id="searchPopupContent"></div></td>'  
         + '   <td class="right">&nbsp;</td>'  
         + '</tr>'  
         + '<tr>'  
         + '   <td class="corner bottomLeft">&nbsp;</td>'  
         + '   <td class="bottom">&nbsp;</td>'  
         + '   <td class="corner bottomRight"></td>'  
         + '</tr>'  
         + '</table>'  
         + '</div>');  
     $('body').append(container);  
     $('.searchA').live('click', function()  {  
         if (hideTimer)  
             clearTimeout(hideTimer);  
         var pos = $(this).offset();  
         var width = $(this).width();  
         container.css({  
             left: (pos.left + width) + 'px',  
             top: pos.top - 5 + 'px'  
         });       
         
         if($('.tim-a').val()!='Nhap vao ðia danh...'){
        	 //alert($('.tim-a').val());
        	 var ten_lop="coquan";
             var ten_diadiem="can tho";
             getDiaDiem(ten_lop,ten_diadiem);
             container.css('display', 'block'); 
             
         }
          
        
     });  
     $('.searchA').live('mouseout', function()  {  
         if (hideTimer)  
               clearTimeout(hideTimer);  
           hideTimer = setTimeout(function()  {  
               container.css('display', 'none');  
           }, hideDelay);  
      });  
       $('#searchPopupContainer').mouseover(function() {  
           if (hideTimer)  
               clearTimeout(hideTimer);  
       });  
       $('#searchPopupContainer').mouseout(function()  {  
           if (hideTimer)  
              clearTimeout(hideTimer);  
          hideTimer = setTimeout(function(){  
              container.css('display', 'none');  
          }, hideDelay);    
    });  
       $('.SelectPlaceCloseBut').live('click', function()  {  
    	   container.css('display', 'none');   
        });     
  });  