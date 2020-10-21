class SalePayment < Payment
    attr_accessor :card_number, :cvv, :expiration_date, :amount, :usage, :type, :email, :address, :card_holder

    def initialize
        @type = 'sale'
    end

    def populate_fields(fields={})
        @card_number = (fields[:card_number]) ? fields[:card_number] : "4200000000000000"
        @cvv = (fields[:cvv]) ? fields[:cvv] : "123"
        @expiration_date = (fields[:expiration_date]) ? fields[:expiration_date] : "06/2019"
        @amount = (fields[:amount]) ? fields[:amount] : "500"
        @usage  = (fields[:usage]) ? fields[:usage] : "Coffeemaker"
        @email = (fields[:email]) ? fields[:email] : Faker::Internet.email 
        @address = (fields[:address]) ? fields[:address] : Faker::Address.street_address 
        @card_holder = (fields[:card_holder]) ? fields[:card_holder] : "Panda Panda"
        self
    end
end