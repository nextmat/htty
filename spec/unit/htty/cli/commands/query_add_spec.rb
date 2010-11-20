require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli")

describe HTTY::CLI::Commands::QueryAdd do
  before :each do
    @session = HTTY::Session.new('')
  end

  describe 'with no arguments' do
    describe 'without key already present' do
      it 'should add key' do
        query_add = create_query_add_and_perform('test')
        query_add.session.requests.last.uri.query.should == 'test'
      end
    end
    
    describe 'with key already present' do
      it 'should add key' do
        @session.requests.last.uri.query = 'test=true'
        query_add = create_query_add_and_perform('test')
        query_add.session.requests.last.uri.query.should == 'test=true&test'
      end
    end
  end
  
  describe 'with one argument' do
    describe 'without key already present' do
      it 'should add key and value' do
        query_add = create_query_add_and_perform('test', 'true')
        query_add.session.requests.last.uri.query.should == 'test=true'
      end
    end
    
    describe 'with key already present' do
      it 'should add key and value' do
        @session.requests.last.uri.query = 'test=true'
        query_add = create_query_add_and_perform('test', 'false')
        query_add.session.requests.last.uri.query.should == 'test=true&test=false'
      end
    end
  end

  def create_query_add_and_perform(*arguments)
    query_set = HTTY::CLI::Commands::QueryAdd.new(:session => @session, 
                                                  :arguments => arguments)
    query_set.perform
    query_set
  end

end
