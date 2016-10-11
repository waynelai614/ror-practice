class Test < ApplicationRecord
  def self.print(abc, &b)
    if !abc.blank?
      puts "hello??"
    else
      puts "not blank"
    end
    [1,2,3,4]
    call(b)
  end
end
