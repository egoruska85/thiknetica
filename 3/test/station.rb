class Station
  attr_reader :trains, :name
  ### Созлание станции #######
  attr_reader :name, :trains, :sent_trains, :arrived
  def initialize(name)
    @name = name
    @trains = []
    @sent_trains = []
    @arrived = []
  end
  def add_train(train)
    @arrived << train.number
    @trains << train
  end
  def send_train(train)
    @sent_trains << train.number
    @trains.delete(train)
  end
  ######### Вывод всех поездов находящие на стации #####
  def show_trains(type_train)
    type_trains = { 1 => 'Пассажирский', 2 => 'Грузовой' }
    trains.select{ |train| train.type_train == type_trains[type_train] }
  end
end
