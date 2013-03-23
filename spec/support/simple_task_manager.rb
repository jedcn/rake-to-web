class SimpleTaskManager
  def names
    [ 'multiply_4_by_4', 'add_4_and_4' ]
  end

  def run(name)
    if name == 'multiply_4_by_4'
      16
    elsif name == 'add_4_and_4'
      8
    end
  end

  def tasks
    require 'ostruct'
    tasks = []
    tasks << OpenStruct.new({ :name => 'multiply_4_by_4' })
    tasks << OpenStruct.new({ :name => 'add_4_and_4' })
    tasks
  end
end
