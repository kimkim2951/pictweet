$(function(){
  //以下は、コメント内容を盛り込んだHTML
  function buildHTML(comment){
    let html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }
  //発火する引き金の場所（アクションを実行した場所） .on アクション内容（今回は”submitボタンを押した時”）※他にもクリックした時など
  $('#new_comment').on('submit', function(e){
    //上記内容を作動した際に以下を実行しないようなイメージ
    e.preventDefault();
    //大文字Formdata　今回の場合は１２行目の'#new_comment'。非同期通信で送信する場所
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    //29行目には３行目〜９行目で入力した内容がlet html に入っている。
    .done(function(data){
      let html = buildHTML(data);
      //親要素'.comments'の中に上記で入力した(html)を追加（.append）するの意味。
      $('.comments').append(html);
      $('.textbox').val('');
      $('.form__submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error')
    })
  })
});

