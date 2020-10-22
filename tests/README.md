Automation Tests
======================
written in Ruby by Iliana Markova


Installation
============
- Follow guide to setup product https://github.com/eMerchantPay/codemonsters_api_full 

- Clone this repository https://github.com/ilimarkova/emerchantPayTask

- Run bundle install from main directory to install used gems

- Execute api tests from console as you run the following command from console
   ```
   ruby console-tests/console-tests.rb -u {API URL} -t {TRANSACTION TYPE}
   ```
   Example:
   ```
   ruby console-tests/console-tests.rb -u http://localhost:3001/payment_transactions -t void
   ```

- Execute all api tests run the following command
   ```
   rspec rspec/payment_transactions/create_spec.rb
   ```