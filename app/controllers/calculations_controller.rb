class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.split

    @word_count = text_split_into_array.length

    @character_count_with_spaces = @text.chars.length

    @character_count_without_spaces = @text.gsub(" ","").gsub("\n","").gsub("\t","").gsub("\r","").length

    # @occurrences = @text.downcase.scan(@special_word).length

    text_array = @text.gsub(/[^a-z0-9\s]/i, "").downcase.split
    @occurrences = 0

    text_array.each do |word|
      if word == @special_word.downcase
        @occurrences += 1
      end
    end
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    months = @years*12
    month_rate = (@apr/100)/12
    step1 = month_rate*@principal
    step2 = (1+month_rate)**(-1*months)
    step3 = 1-step2


    @monthly_payment = step1/step3
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    middle=@count/2
    if @count.even?
      median = (@sorted_numbers[middle]+ @sorted_numbers[middle-1])/2
    else
      median = @sorted_numbers[middle]
    end

    @median = median

    @sum = @numbers.inject(0){|sum,x| sum + x }

    @mean = @sum/@count

    variance1 = @numbers.inject(0.0) {|s,x| s + (x - @mean)**2}
    variance2 = variance1/@count

    @variance = variance2

    @standard_deviation = @variance**(1.0/2)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    mode = @numbers.max_by { |v| freq[v] }
    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
