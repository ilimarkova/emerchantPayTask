require_relative '../../helpers/spec_helper'

describe 'The /payment_transactions endpoint' do
    before(:all) do 
       
    end

    context 'unsuccessfully create sale payment transaction without authorization' do
        before  do
        end

        it 'returns the correct response code' do  
        end
    end

    context 'unsuccessfully create void payment transaction without authorization' do
        before  do
        end

        it 'returns the correct response code' do
        end
    end


    context 'unsuccessfully create payment transaction with invalid key' do
        before do
        end

        it 'returns the correct response code' do
        end

        it 'returns the correct response body' do
        end
    end

    context 'succesfully create valid payment transaction' do 
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