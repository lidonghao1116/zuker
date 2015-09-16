module PagesHelper
  def render_school_card(schools, index_range)
    schools.each_with_index do |school, i|
      if index_range.include?(i)
        return render 'pages/school_card', school: school
      end
    end    
  end
end
