# chef-client --local-mode hello.rb

file '/tmp/motd' do
  content 'hello world'
end
