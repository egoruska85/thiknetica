class Station
  ### Созлание станции #######
  attr_reader :name, :trains, :sent_trains, :arrived
  def initialize(name)
    @name = name
    @trains = []
    @sent_trains = []
    @arrived = []
  end
  #def add_train(train)
  #  @arrived << train
  #  @trains << train
  #end
  #def destroy_train(train)
  #  @sent_trains << train
  #  @trains.delete(train)
  #end
  ######### Вывод всех поездов находящие на стации #####
  def show_trains
    @pas = 0
    @gru = 0
    @trains.each do |train|
      if train[1] == 1
        @pas += 1
      elsif train[1] == 2
        @gru += 1
      end
    end
    @trains.each do |train|
      train[0].each do |key, value|
        print "#{key}(#{value}); "
      end
    end
    puts ''
    puts "###############################"
    puts "Пассажирские составы #{@pas}"
    puts "Грузовые составы #{@gru}"
  end
end
