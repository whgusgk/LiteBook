/**
 * 
 */

function searchToggle(obj, evt){
    let container = $(obj).closest('.search-wrapper');
    if(!container.hasClass('active')){
      container.addClass('active');
      evt.preventDefault();
      
      if(container.hasClass('active') && $(obj).closest('.input-holder').length != 0){
        const click = document.querySelector('.search-icon');
        click.addEventListener('click', () =>{
          //alert("확인");
                    $("#searchForm").submit();
   /* ■■■■■■■■■■■■■■■■■■■■■■x클릭 후에 다시 아이콘을 누르면 동작하는경우 걸러줘야함..■■■■■■■■■■■■■■ */

              });
            }

        }
        else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
            container.removeClass('active');
            // clear input
            container.find('.search-input').val('');
        }
}
