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
    @trains.each { |train| puts train }
  end
end
