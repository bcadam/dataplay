class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :user_signed_in?, :correct_user?

  helper_method :clean_title, :clean_string, :clean_name, :clean_name_string

  def clean_title (filings)
    cleaned_name = filings.title.sub('(Issuer)' , '')
    cleaned_name = cleaned_name.sub('(Reporting)' , '')
    cleaned_name = cleaned_name.sub('(Filer)' , '')
    cleaned_name = cleaned_name.sub('(Filed by)' , '')
    cleaned_name = cleaned_name.sub('(' + filings.cik + ')' , '')


    return cleaned_name

  end

  def clean_name (filings)
    cleaned_name = filings.name.sub('(Issuer)' , '')
    cleaned_name = cleaned_name.sub('(Reporting)' , '')
    cleaned_name = cleaned_name.sub('(Filer)' , '')
    cleaned_name = cleaned_name.sub('(Filed by)' , '')
    cleaned_name = cleaned_name.sub('(' + filings.cik + ')' , '')


    return cleaned_name

  end

  def clean_name_string (filings)
    cleaned_name = filings.sub('(Issuer)' , '')
    cleaned_name = cleaned_name.sub('(Reporting)' , '')
    cleaned_name = cleaned_name.sub('(Filer)' , '')
    cleaned_name = cleaned_name.sub('(Filed by)' , '')

    return cleaned_name

  end


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

  def graph(unit, id, pass_width, pass_height)

    #unit.categories


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
