class VoidPayment < Payment
    attr_accessor :type, :reference_id

    def initialize
        @type = 'void'
    end

    def populate_fields(fields={})
        @reference_id = fields[:reference_id] 
        self
    end
end