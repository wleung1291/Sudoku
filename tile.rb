
class Tile
    attr_reader :value, :given
    attr_writer :value, :given
    
    def initialize(val)
        @value = val
        @given = val == 0 ? false : true
    end

end