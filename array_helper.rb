class Array
  def roughly_eql? another_arr
    eql = true
    self.each do |el|
      eql = false if not(another_arr.include? el)
    end
    return eql
  end
end