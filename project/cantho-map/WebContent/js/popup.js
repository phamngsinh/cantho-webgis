 $(function()  
   {  
     var hideDelay = 500;    
     var currentID;  
     var hideTimer = null;  
     var hideTimer2 = null;
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
     var container2 = $('<div id="searchPopupContainer2"> '
        	 + '	 <a onclick="" href="#" class="SelectPlaceCloseBut">Tat</a>'  
             + '<table width="" border="0" cellspacing="0" cellpadding="0" align="center" class="searchPopupPopup">'  
             + '<tr>'  
             + '   <td class="corner topLeft"></td>'  
             + '   <td class="top"></td>'  
             + '   <td class="corner topRight"></td>'  
             + '</tr>'  
             + '<tr>'  
             + '   <td class="left">&nbsp;</td>'  
             + '   <td><div id="searchPopupContent2"></div></td>'  
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
     $('body').append(container2); 
     $('.searchA').live('click', function()  {  
         if (hideTimer)  
             clearTimeout(hideTimer);  
         var pos = $(this).offset();  
         var width = $(this).width();  
         container.css({  
             left: (pos.left + width) + 'px',  
             top: pos.top - 5 + 'px'  
         });               
         if($('.tim-a').val()!='Nhập vào địa danh...'){     	 
             var ten_dia_diem= $(".tim-a").val();             
             find_Place_By_Text(ten_dia_diem); 
             for(i =1;i<100000;i++){a=5;}
             container.css('display', 'block');              
         }       
     });
     $('.searchB').live('click', function()  {  
         if (hideTimer2)  
             clearTimeout(hideTimer2);  
         var pos = $(this).offset();  
         var width = $(this).width();  
         container2.css({  
             left: (pos.left + width) + 'px',  
             top: pos.top - 5 + 'px'  
         });       
         if($('.tim-b').val()!='Nhập vào địa danh...'){
             var ten_dia_diem2= $(".tim-b").val();             
             find_Place_By_Text2(ten_dia_diem2);  
             for(i =1;i<100000;i++){a=5;}
             container2.css('display', 'block'); 
         }
     });  
     $('.searchA').live('mouseout', function()  {  
         if (hideTimer)  
               clearTimeout(hideTimer);  
           hideTimer = setTimeout(function()  {  
               container.css('display', 'none');  
           }, hideDelay);  
      });  
     $('.searchB').live('mouseout', function()  {  
         if (hideTimer2)  
               clearTimeout(hideTimer2);  
           hideTimer2 = setTimeout(function()  {  
               container2.css('display', 'none');  
           }, hideDelay);  
      });  
       $('#searchPopupContainer').mouseover(function() {  
           if (hideTimer)  
               clearTimeout(hideTimer);  
       });  
       $('#searchPopupContainer2').mouseover(function() {  
           if (hideTimer2)  
               clearTimeout(hideTimer2);  
       });  
       $('#searchPopupContainer').mouseout(function()  {  
           if (hideTimer)  
              clearTimeout(hideTimer);  
          hideTimer = setTimeout(function(){  
              container.css('display', 'none');  
          }, hideDelay);    
       });  
       $('#searchPopupContainer2').mouseout(function()  {  
           if (hideTimer2)  
              clearTimeout(hideTimer2);  
          hideTimer2 = setTimeout(function(){  
              container2.css('display', 'none');  
          }, hideDelay);    
       }); 
       $('.SelectPlaceCloseBut').live('click', function()  {  
    	   container.css('display', 'none');
    	   container2.css('display', 'none');
        });  
  });  