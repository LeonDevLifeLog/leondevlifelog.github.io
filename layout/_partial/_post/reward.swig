{% if (theme.reward.enable and page.reward !== false) or page.reward === true %}
  <div class="post-reward">
    <input type="checkbox" name="reward" id="reward" hidden />
    <label class="reward-button" for="reward">{{ __('posts.reward') }}</label>
    <input type="checkbox" name="commentsbox" id="commentsbox" hidden />
    <label class="comments-button" for="commentsbox">{{ __('posts.comments') }}</label>
    <div class="qr-code">
      {% set qrCode = theme.reward.qrCode %}
      {% if qrCode.wechat %}
        <label class="qr-code-image" for="reward">
          <img class="image" src="{{url_for(qrCode.wechat)}}" title="wechat">
        </label>
      {% endif %}
      {% if qrCode.alipay %}
        <label class="qr-code-image" for="reward">
          <img class="image" src="{{url_for(qrCode.alipay)}}" title="alipay">
        </label>
      {% endif %}
    </div>
    <div  class="comments-box" id="comments-box">
    
    </div>
  </div>
{% endif %}