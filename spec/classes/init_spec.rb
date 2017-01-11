require 'spec_helper'
describe 'cust_base' do
  context 'with default values for all parameters' do
    it { should contain_class('cust_base') }
  end
end
