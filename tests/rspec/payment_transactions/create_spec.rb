require_relative '../../helpers/spec_helper'

describe 'The /payment_transactions endpoint' do
    before(:all) do
        @base_url = "#{BASE_URL}payment_transactions"
        @sale_payment_object = SalePayment.new.populate_fields({email: 'panda@example.com'})
        @sale_payload =  { 
            payment_transaction: {
                card_number: @sale_payment_object.card_number,
                cvv: @sale_payment_object.cvv,
                expiration_date: @sale_payment_object.expiration_date,
                amount: @sale_payment_object.amount,
                usage:  @sale_payment_object.usage,
                transaction_type:  @sale_payment_object.type,
                card_holder:  @sale_payment_object.card_holder,
                email:  @sale_payment_object.email,
                address:  @sale_payment_object.address
            }
        } 
    end

    context 'unsuccessfully create sale payment transaction without authorization' do
        before  do
            @response = SalePayment.new.create(@base_url, @sale_payload, false) 
        end

        it 'returns the correct response code' do 
            expect(@response.code).to eq(401) 
        end
    end

    context 'unsuccessfully create void payment transaction without authorization' do
        before  do
            sale_transaction_response = SalePayment.new.create(@base_url, @sale_payload, AUTH_TOKEN)  
            results = JSON.parse(sale_transaction_response)
            void_payment_object = VoidPayment.new.populate_fields({reference_id: results['unique_id']})
            void_payload =  { payment_transaction: 
                {
                    reference_id: void_payment_object.reference_id, 
                    transaction_type: void_payment_object.type
                }
            }
            @response = VoidPayment.new.create(@base_url, void_payload, false)
        end

        it 'returns the correct response code' do
            expect(@response.code).to eq(401)
        end
    end


    context 'unsuccessfully create void payment transaction with invalid key' do
        before do
        end

        it 'returns the correct response code' do
        end

        it 'returns the correct response body' do
        end
    end

    context 'succesfully create valid sale payment transaction' do 
        before do 
        end

        it 'returns the correct response code' do
        end

        it 'returns the correct response body' do
        end
    end

    context 'succesfully create valid void payment transaction' do 
        before  do
        end

        it 'returns the correct response code' do
        end

        it 'returns the correct response body' do
        end
    end
end