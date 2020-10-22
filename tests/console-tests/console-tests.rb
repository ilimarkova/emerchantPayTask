require 'optparse'
require_relative '../helpers/spec_helper'

class ConsoleApiExecute < Payment
    def self.parse_console_inputs
        params = {}
        OptionParser.new do |opts|
            opts.on("-u", "--url URL", "The url of the api") do |v|
                params[:url] = v
            end

            opts.on("-t", "--type TYPE", "The payment type") do |v|
                params[:type] = v
            end
        end.parse!(into: params)
        params
    end

    def self.create_sale_payment(url, type)
        payload = {
            payment_transaction: {
                card_number: "4200000000000000",
                cvv: "123",
                expiration_date: "06/2019",
                amount: "500",
                usage: "Coffeemaker",
                transaction_type: type,
                card_holder: "Panda Panda",
                email: "panda@example.com",
                address: "5196 Skiles Cliff"
            }
        }
        Payment.new.create(url, payload)
    end

    def self.create_void_payment(url, type, key)
        payload = {
            payment_transaction: {
                reference_id: key,
                transaction_type: type
            }
        }
        Payment.new.create(url, payload)
    end 

    def self.build_output(type, url)
        sale_results = create_sale_payment(url, 'sale') if type == 'sale' || type == 'void'
        case type
        when 'sale'
            p JSON.parse(sale_results)
        when  'void'
            key = JSON.parse(sale_results)['unique_id']
            void_results = create_void_payment(url, 'void', key)
            p  JSON.parse(void_results)
        else
            raise 'Please, add payment type!'
        end
    end
end

console_inputs = ConsoleApiExecute.parse_console_inputs
type = console_inputs[:type]
url = console_inputs[:url]
ConsoleApiExecute.build_output(type, url)