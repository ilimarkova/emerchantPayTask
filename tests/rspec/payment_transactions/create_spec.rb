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
            void_payment_object = VoidPayment.new.populate_fields({reference_id: 'fake id'})
            void_payload =  { payment_transaction: 
                {
                    reference_id: void_payment_object.reference_id, 
                    transaction_type: void_payment_object.type
                }
            }
            @response = VoidPayment.new.create(@base_url, void_payload)
        end

        it 'returns the correct response code' do
            expect(@response.code).to eq(422)
        end

        it 'returns the correct response body' do
            errors = []
            errors.push "Invalid reference transaction!"
            results = JSON.parse(@response.body)
            expect(results['reference_id']).to match errors
        end
    end

    context 'succesfully create valid sale payment transaction' do 
        before do
            @response = SalePayment.new.create(@base_url, @sale_payload)
        end

        it 'returns the correct response code' do
            expect(@response.code).to eq(200)
        end

        it 'returns the correct response body' do
            results = JSON.parse(@response.body)
            sendDate = Time.parse(results['transaction_time'])
            expect(results['status']).to eql('approved')
            expect(results['message']).to eql('Your transaction has been approved.')
            expect(results['usage']).to eql(@sale_payment_object.usage)
            expect(results['amount']).to eql(@sale_payment_object.amount.to_i)
            expect(sendDate.to_i).to equal(Time.now.utc.to_i)
        end
    end

    context 'succesfully create valid void payment transaction' do 
        before  do
            sale_transaction_response = SalePayment.new.create(@base_url, @sale_payload)  
            results = JSON.parse(sale_transaction_response)
            void_payment_object = VoidPayment.new.populate_fields({reference_id: results['unique_id']})
            void_payload =  { payment_transaction: 
                {
                    reference_id: void_payment_object.reference_id, 
                    transaction_type: void_payment_object.type
                }
            }
            @response = VoidPayment.new.create(@base_url, void_payload)  
        end

        it 'returns the correct response code' do
            expect(@response.code).to eq(200)
        end

        it 'returns the correct response body' do
            results = JSON.parse(@response.body)
            sendDate = Time.parse(results['transaction_time'])
            expect(results['unique_id']).not_to be_empty
            expect(results['status']).to eql('approved')
            expect(results['message']).to eql('Your transaction has been voided successfully')
            expect(results['usage']).to eql(@sale_payment_object.usage)
            expect(results['amount']).to eql(@sale_payment_object.amount.to_i)
            expect(sendDate.to_i).to equal(Time.now.utc.to_i)
        end
    end
end