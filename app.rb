require 'sinatra'
require 'httparty'
require 'json'

post '/gateway' do
  messsage = params[:text].gsub(params[:trigger_word], '').split  
  action, repo = messsage.split('_').map { |c| c.strip.downcase }
  repo_url = "https://api.github.com/repos/#{repo}"
  
  
  case action
    when 'issues'
      resp = HttParty.get(repo_url)
      resp = JSON.parse(resp.body)
      respond_message("There are #{resp['open_issues_count']} open issues on #{repo}")
  end
  
  def respond_message(message) 
    content_type :json
    {:text => message}.to_json
  end
  
end

