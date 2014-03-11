class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :user_signed_in?, :correct_user?, :get_last_seven  


  ##  Will graph the last seven days of filings. 
  #   Needs an array and the desired title of the canvas. Then the name of the header
  def get_last_seven(passed, needle, newid, sectiontitle)
  recent = Array.new
  today = DateTime.now.utc
  todaytext = today.to_date
  onedaytext = (today - 1.day).to_date
  twodaytext = (today - 2.day).to_date
  threedaytext = (today - 3.day).to_date
  fourdaytext = (today - 4.day).to_date
  fivedaytext = (today - 5.day).to_date
  sixdaytext = (today - 6.day).to_date

  recent.push( passed.where(["DATE(#{needle}) = ?", todaytext ]).size )
  recent.push( passed.where(["DATE(#{needle}) = ?", onedaytext ]).size )
  recent.push( passed.where(["DATE(#{needle}) = ?", twodaytext ]).size )
  recent.push( passed.where(["DATE(#{needle}) = ?", threedaytext ]).size )
  recent.push( passed.where(["DATE(#{needle}) = ?", fourdaytext ]).size )
  recent.push( passed.where(["DATE(#{needle}) = ?", fivedaytext ]).size )
  recent.push( passed.where(["DATE(#{needle}) = ?", sixdaytext ]).size )

  todaytext = todaytext.to_formatted_s(:short)
  onedaytext = onedaytext.to_formatted_s(:short)
  twodaytext = twodaytext.to_formatted_s(:short)
  threedaytext = threedaytext.to_formatted_s(:short)
  fourdaytext = fourdaytext.to_formatted_s(:short)
  fivedaytext = fivedaytext.to_formatted_s(:short)
  sixdaytext = sixdaytext.to_formatted_s(:short)

  "<p><strong>#{sectiontitle}</strong></p><canvas class='panel' id='#{newid}' width='600' height='300'></canvas>

    <script>
    var buyerData = {
      labels : ['#{todaytext}','#{onedaytext}','#{twodaytext}','#{threedaytext}','#{fourdaytext}','#{fivedaytext}','#{sixdaytext}'],
      datasets : [
        {
          fillColor : 'rgb(0,128,128)',
          strokeColor : 'rgba(210,220,220,1)',
          data : [#{recent[0]},#{recent[1]},#{recent[2]},#{recent[3]},#{recent[4]},#{recent[5]},#{recent[6]}]
        }/**,
        {
          fillColor : 'rgba(151,187,205,0.5)',
          strokeColor : 'rgba(151,187,205,1)',
          data : [28,48,40,19,96,27,100]
        }**/
      ]
    };

      var pieOptions = {
          segmentShowStroke : true,
          segmentStrokeColor : '#fff',
          segmentStrokeWidth : 2,
          percentageInnerCutout : 50,
          animation : true,
          animationSteps : 100,
          animationEasing : 'easeOutBounce',
          animateRotate : true,
          animateScale : false,
          onAnimationComplete : 'revealInfo()',
          labelFontFamily : 'Arial',
          labelFontStyle : 'normal',
          labelFontSize : 24,
          labelFontColor : '#666'
      }

      function revealInfo()
      {
          alert('Hello World!');
      }

      var results = document.getElementById('#{newid}').getContext('2d');
      new Chart(results).Bar(buyerData,pieOptions);

      $('##{newid}').css('width','100%');
      $('##{newid}').css('max-width','600px');
      $('##{newid}').css('height','auto');
      </script>".html_safe


  end

  # accepts an array of a model and returns an array with the first four most common values of the needle
  def get_common_elements (passed_array, needle)
    temparray = passed_array.pluck('DISTINCT ' + needle)
    count_array = Array.new()
      count = 0


      temparray.each do |t|

        count_array.push( [t, passed_array.where(needle => t).count] )
        #count = count + 1
      end


     
    ordered = count_array.sort_by(&:last).reverse

      if ordered.fourth != nil
      ordered = ordered.first + ordered.second + ordered.third + ordered.fourth 
      end
  
  return ordered

  end

  #accepts an multi-dimensional array that is FOUR by TWO long. And graphs the output as a bar chart
  #must pass width and height
  def graph(unit, id, pass_width, pass_height)


    return "<canvas class='panel' id='#{id}' width='#{pass_width}' height='#{pass_height}'></canvas>

    <script>
    var buyerData = {
      labels : ['#{unit[0]}','#{unit[2]}','#{unit[4]}','#{unit[6]}'],
      datasets : [
        {
          fillColor : 'rgb(0,128,128)',
          strokeColor : 'rgba(210,220,220,1)',
          data : [#{unit[1]},#{unit[3]},#{unit[5]},#{unit[7]}/**,90,81,56,55,40**/]
        }/**,
        {
          fillColor : 'rgba(151,187,205,0.5)',
          strokeColor : 'rgba(151,187,205,1)',
          data : [28,48,40,19,96,27,100]
        }**/
      ]
    };

      var pieOptions = {
          segmentShowStroke : true,
          segmentStrokeColor : '#fff',
          segmentStrokeWidth : 2,
          percentageInnerCutout : 50,
          animation : true,
          animationSteps : 100,
          animationEasing : 'easeOutBounce',
          animateRotate : true,
          animateScale : false,
          onAnimationComplete : 'revealInfo()',
          labelFontFamily : 'Arial',
          labelFontStyle : 'normal',
          labelFontSize : 24,
          labelFontColor : '#666'
      }

      function revealInfo()
      {
          alert('Hello World!');
      }

      var results = document.getElementById('#{id}').getContext('2d');
      new Chart(results).Bar(buyerData,pieOptions);
      </script>".html_safe

  end


  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

end
