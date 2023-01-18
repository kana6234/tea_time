/*global $*/
var navigationOpenFlag = false;
var navButtonFlag = true;
var focusFlag = false;

//ハンバーガーメニュー
    $(function(){

      $(document).on('click','.el_humburger',function(){
        if(navButtonFlag){
          spNavInOut.switch();
          setTimeout(function(){
            navButtonFlag = true;
          },200);
          navButtonFlag = false;
        }
      });
      $(document).on('click','.el_humburger',function(){
if(navButtonFlag){
spNavInOut.switch();
setTimeout(function(){
navButtonFlag = true;
},200);
navButtonFlag = false;
}
});
/*$(document).on('click touchend', function(event) {
if (!$(event.target).closest('.bl_header,.el_humburger').length && $('body').hasClass('js_humburgerOpen') && focusFlag) {
focusFlag = false;
//scrollBlocker(false);
spNavInOut.switch();
}
});*/
});

//ナビ開く処理
function spNavIn(){
  $('body').removeClass('js_humburgerClose');
  $('body').addClass('js_humburgerOpen');
  setTimeout(function(){
    focusFlag = true;
  },200);
  setTimeout(function(){
    navigationOpenFlag = true;
  },200);
}

//ナビ閉じる処理
function spNavOut(){
  $('body').removeClass('js_humburgerOpen');
  $('body').addClass('js_humburgerClose');
  setTimeout(function(){
    $(".uq_spNavi").removeClass("js_appear");
    focusFlag = false;
  },200);
  navigationOpenFlag = false;
}

//ナビ開閉コントロール
var spNavInOut = {
  switch:function(){
    if($('body.spNavFreez').length){
      return false;
    }
    if($('body').hasClass('js_humburgerOpen')){
     spNavOut();
    } else {
     spNavIn();
    }
  }
};

// Swiperのオプションを定数化
const opt = {
  loop: true,
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  }
}

// Swiperを実行(初期化)
$(document).on('turbolinks:load', function() {
    let swiper = new Swiper('.swiper',opt);
});
