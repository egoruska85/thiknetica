module Dictonary
  ASK_TO_GAME = "Вы хотите сыграть BLACK JACK ? Y - Да: N - Нет:"
  EXPLANATION = 'Все кто с тобой будет играть барыги, у всех псевдонимы. Получаетя шифруются. У всех найдуться деньги чтобы с тобой сыграть!!!'
  USERNAME = 'Как тебя зовут керя?: '
  DILLER_NAME = ['Джэк', 'Кощей', 'Трус', 'Балбесина', 'Золотозуб', 'Баба-яга', 'Емеля', 'Дон Карлеоне', 'Флэш-рояль', 'Владимирский централ'].shuffle!

  BET_AMOUNT = 10
  LIMIT = 21
  THRESHOLD = 17

  FACES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  POINTS = { J: 10, Q: 10, K: 10, A: 11 }.freeze
  SUITS = %w[♥ ♦ ♣ ♠].freeze
  ACE_ALT_VALUE = 1
end
