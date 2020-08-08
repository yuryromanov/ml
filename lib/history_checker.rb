class HistoryChecker
  attr_reader :history

  def initialize(history)
    @history = history
  end

  def none?(*ids)
    history.none? {|history_ids| history_ids & ids == ids }
  end
end
