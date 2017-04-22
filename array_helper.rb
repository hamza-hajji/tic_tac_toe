class Array
  def roughly_eql? another_arr
    eql = true
    return false if another_arr.length != self.length
    self.each do |el|
      eql = false if not(another_arr.include? el)
    end
    return eql
  end
end